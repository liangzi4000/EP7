#include-once
#include "GlobalVariables.au3"
#include "AccountInfoStructure.au3"
#include "Lib/Logger.au3"
#include "Lib/Database.au3"
#include "Lib/ArrayHelper.au3"
#include <Array.au3>

Func ExecStep($funcName)
	If $funcName = "" Then Return

	For $x = 0 To UBound($v_windows) - 1
		$activewindow = $v_windows[$x]
		If _ArraySearch($inactivewindows, $activewindow) <> -1 Then
			WriteLog("Skip execute " & $funcName & " for window " & $activewindow)
			ContinueLoop
		EndIf

		WinActivate($activewindow)
		WriteLog("Before execute " & $funcName)
		Call($funcName)
		WriteLog("After execute " & $funcName)
	Next
EndFunc   ;==>ExecStep

Func GetNextRecord()
	Local $acctinfo = ""
	Local $result = False

	For $x = 1 To 5
		$acctinfo = ExecDBQuery("[dbo].[SP_GetNextRecord] '" & $activewindow & "'")
		If $acctinfo = "End" Then
			WriteLog("Reach end of database, close window.")
			AddArrayElem($inactivewindows, $activewindow)
			Call($g_fn_closeapp)
			$result = True
			ExitLoop
		ElseIf IsValidResult($acctinfo) Then
			WriteLog("$acctinfo = " & $acctinfo)
			$result = True
			ExitLoop
		Else
			WriteLog("GetNextRecord return invalid database record: " & $acctinfo, $v_exception)
			Sleep(10000)
		EndIf
	Next
	Assign("acctinfo" & $activewindow, $acctinfo, 2)

	If Not $result Then
		WriteLog("Failed to connnect to database after 5 times retry, close window.", $v_exception)
		AddArrayElem($inactivewindows, $activewindow)
		Call($g_fn_closeapp)
	EndIf

	Return $result
EndFunc   ;==>GetNextRecord

Func CompleteDailyTask()
	Local $uid = GetAccountInfo("uid")
	If $debug Then WriteLog($uid & "completed daily task")
	ExecDBQuery("[dbo].[SP_CompleteDailyTask] '" & $uid & "'")
EndFunc   ;==>CompleteDailyTask

Func CheckExit()
	If $exit Then Exit
EndFunc   ;==>CheckExit

Func CreateNextRecord()
	Local $acctinfo = ExecDBQuery("[dbo].[SP_CreateNextRecord] '" & $activewindow & "'")
	Assign("acctinfo" & $activewindow, $acctinfo, 2)
	If Not IsValidResult($acctinfo) Then
		WriteLog("CreateNextRecord return invalid database record: " & $acctinfo, $v_exception)
		AddArrayElem($inactivewindows, $activewindow)
		Return False
	EndIf
	Return True
EndFunc   ;==>CreateNextRecord

Func CompleteAccountCreation()
	Local $uid = GetAccountInfo("uid")
	If $debug Then WriteLog($uid & "completed account creation")
	ExecDBQuery("[dbo].[SP_CompleteAccountCreation] '" & $uid & "'")
EndFunc   ;==>CompleteAccountCreation
