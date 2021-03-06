#AutoIt3Wrapper_UseX64 = Y
#RequireAdmin ;start sql service require administrator right
#include <Common.au3>

Run(@ScriptDir & "\StartSQLServer.bat")
WaitImageDesktop("nox_multi_drive.bmp", 600)
Local $pos = [0, 0]
SearchImageDesktop("nox_multi_drive.bmp", $pos[0], $pos[1])
MouseClick($MOUSE_CLICK_LEFT, $pos[0], $pos[1], 2, 0)
WaitImageDesktop("NoxPlayer03.bmp", 600)
SearchImageDesktop("NoxPlayer03.bmp", $pos[0], $pos[1])
MouseClick($MOUSE_CLICK_LEFT, $pos[0] + 446, $pos[1], 1, 0)
SearchImageDesktop("NoxPlayer04.bmp", $pos[0], $pos[1])
MouseClick($MOUSE_CLICK_LEFT, $pos[0] + 446, $pos[1], 1, 0)
WaitImageDesktop("app_icon_home.bmp", 600)
WaitForSQLService()
Run(@ScriptDir & "\Start.exe")
Sleep(10000)
Send("^m")
Exit

Func WaitForSQLService()
	While ExecDBQuery("SELECT 1 AS Result") <> "1"
		WriteLog("Waiting for SQL service ...")
		Sleep(15000)
	WEnd
EndFunc   ;==>WaitForSQLService
