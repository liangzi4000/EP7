#include-once
#include <Common.au3>
#include <Array.au3>

Global $steps = []
_ArrayAdd($steps, "GetNextRecord")
_ArrayAdd($steps, "Login")
_ArrayAdd($steps, "CloseNotification")
_ArrayAdd($steps, "DrawFreeCard")
_ArrayAdd($steps, "CompleteDailyTask")
_ArrayAdd($steps, "GetDailyAward")
_ArrayAdd($steps, "Logout")
_ArrayAdd($steps, "CheckExit")

Func Login()
	WriteLog("Waiting for login screen")
	WaitPixelList($btn_denglu)

	WriteLog("Click on login button")
	ClickOnRelative($btn_denglu_elem1)

	WriteLog("Waiting for login option screen")
	WaitPixelList($ui_login_option)

	WriteLog("Click on login with other account")
	ClickOnRelative($ui_login_option_elem4)

	WriteLog("Wait for STOVE login screen")
	WaitPixelList($ui_stove_login)

	WriteLog("Enter email address")
	_ClipBoard_SetData(GetAccountInfo("uid")) ; 读取UID到粘贴板
	ClickOnRelative($ui_stove_login_elem1)
	SendPasteKeys() ; 黏贴

	WriteLog("Enter password")
	_ClipBoard_SetData(GetAccountInfo("pwd")) ; 读取UID到粘贴板
	ClickOnRelative($ui_stove_login_elem2)
	SendPasteKeys() ; 黏贴

	WriteLog("Click on login button")
	ClickOnRelative($ui_stove_login_elem3)

	WriteLog("Waiting for startup UI")
	WaitPixelList($ui_startup)
	Sleep(1000)
	WriteLog("Click any place to start")
	ClickOnRelative($btn_ignore)

EndFunc   ;==>Login

Func CloseNotification()
	WriteLog("Wait for notification screen")
	WaitPixelList($btn_close_announcement)

	WriteLog("Click X to close notification")
	ClickPosUntilScreenByMultiPixel($btn_close_announcement_elem1, $ui_daily_award)

	WriteLog("Click confirm to close daily award")
	ClickPosUntilScreenByMultiPixel($btn_close_announcement_elem3, $ui_bar)
EndFunc   ;==>CloseNotification

Func DrawFreeCard()
	WriteLog("Click on zhaohuan menu until shenyuezhaohuan appear")
	ClickPosUntilScreenByMultiPixel($menu_zhaohuan, $btn_shengyuezhaohuan)
	WriteLog("Click on shenyuezhaohuan until zhaohuan button appear")
	ClickPosUntilScreenByMultiPixel($btn_shengyuezhaohuan_elem1, $btn_zhaohuan)
	WriteLog("Click on zhaohuan button until queren zhaohuan button appear")
	ClickPosUntilScreenByMultiPixel($btn_zhaohuan_elem1, $btn_zhaohuan_queren)
	WriteLog("Click on queren zhaohuan button")
	ClickOnRelative($btn_zhaohuan_queren_elem1)
	Sleep(1000)
	WriteLog("Click on scrreen/arrow until setting icon appear")
	ClickPosUntilScreenByMultiPixel($ui_return_after_zhaohuan_elem1, $ui_next_summon)
EndFunc   ;==>DrawFreeCard

Func GetDailyAward()
;~ 	$ui_next_summon_elem6
EndFunc   ;==>GetDailyAward

Func Logout()
	WriteLog("Click on top right corner setting button until setting list screen appear")
	ClickPosUntilScreenByMultiPixel($menu_setting, $ui_setting)
	WriteLog("Click on gear icon until setting option screen appear")
	ClickPosUntilScreenByMultiPixel($ui_setting_elem3, $ui_option)
	WriteLog("Click on logout button until logout confirmation screen appear")
	ClickPosUntilScreenByMultiPixel($ui_option_elem5, $ui_logout)
	WriteLog("Click on confirm logout button")
	ClickOnRelative($ui_logout_elem2)
	Sleep(1000)
	WriteLog("Click on confirm logout button again")
	ClickOnRelative($ui_logout_elem2)
EndFunc   ;==>Logout

Func CloseApp()
	;To do
EndFunc   ;==>CloseApp

Func MoveWindow()
	Local $toolbarpos = GetHideToolBarPosition()
	Local $ctrlpos = GetCtrlPosition()
	ClickOn($toolbarpos)
	Sleep(500)
	If Not $winleftready Then
		WinMove($activewindow, "", 0, 0)
		$winleftready = True
		Sleep(500)
		Local $winleftheaderpos = [($ctrlpos[0] + $ctrlpos[2]) / 2, 10]
		WinActivate($activewindow)
		ClickOn($winleftheaderpos)
	ElseIf Not $winrightready Then
		Local $winpos = GetWinPosition()
		WinMove($activewindow, "", @DesktopWidth - $winpos[2], 0)
		$winrightready = True
		Sleep(500)
		Local $winrightheaderpos = [@DesktopWidth - $winpos[2] / 2, 10]
		WinActivate($activewindow)
		ClickOn($winrightheaderpos)
	EndIf
EndFunc   ;==>MoveWindow

Func OpenApp()
	ClickImage("app_icon_home.bmp")
EndFunc   ;==>OpenApp

Func RunScript()
	Run(@ScriptDir & "\Surrogate.exe")
EndFunc   ;==>RunScript