#include-once
#include "GlobalVariables.au3"

#Region Account Info Helper
Func GetAccountInfo($type)
	Local $result = ""
	Local $acctinfo = Eval("acctinfo" & $activewindow)
	Local $acctinfoarr = StringSplit($acctinfo, "|")

	Switch $type
		Case "acctid"
			$result = $acctinfoarr[1]
		Case "uid"
			$result = $acctinfoarr[2]
		Case "pwd"
			$result = $acctinfoarr[3]
		Case "nickname"
			$result = $acctinfoarr[4]
	EndSwitch

	Return $result
EndFunc   ;==>GetAccountInfo
#EndRegion Account Info Helper
