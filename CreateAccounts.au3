#include-once
#include <Common.au3>
#include <Array.au3>

Global $createaccountsteps = []

_ArrayAdd($createaccountsteps, "CreateNextRecord")
_ArrayAdd($createaccountsteps, "LoginAsGuest")
_ArrayAdd($createaccountsteps, "BackgroundStory")
_ArrayAdd($createaccountsteps, "Fight1_1")
_ArrayAdd($createaccountsteps, "Fight1_2")
_ArrayAdd($createaccountsteps, "Fight1_3")
_ArrayAdd($createaccountsteps, "PrepareFight")
_ArrayAdd($createaccountsteps, "Fight1_3_repeat")
_ArrayAdd($createaccountsteps, "Fight1_4")
_ArrayAdd($createaccountsteps, "DrawFirstCard")
_ArrayAdd($createaccountsteps, "ChangeNameAndLogout")
_ArrayAdd($createaccountsteps, "CompleteAccountCreation")
_ArrayAdd($createaccountsteps, "CheckExit")

Func ChangeNameAndLogout()
	ClickPosUntilScreenByMultiPixel($btn_return_to_bar, $ui_changename)
	ClickPosUntilScreenByMultiPixel($ui_changename_elem2, $ui_changename_pop)
	ClickOnRelative($ui_changename_pop_elem1)
	For $bs = 0 To 20
		Send("{BACKSPACE}")
	Next
	_ClipBoard_SetData(GetAccountInfo("nickname"))
	SendPasteKeys()
	ClickOnRelative($ui_changename_pop_elem2)
	Sleep(2000)
	While FindPixelList($ui_changename_pop_name_ok) = False
		ClickOnRelative($ui_changename_pop_elem1)
		Send("{BACKSPACE}")
		ClickOnRelative($ui_changename_pop_elem2)
		Sleep(2000)
	WEnd
	ClickPosUntilScreenByMultiPixel($ui_changename_pop_elem3, $ui_changename_done)

	ClickPosUntilScreenByMultiPixel($menu_setting, $ui_setting)
	ClickPosUntilScreenByMultiPixel($ui_setting_elem3, $ui_option)
	ClickPosUntilScreenByMultiPixel($ui_option_elem4, $ui_link)
	ClickPosUntilScreenByMultiPixel($ui_link_elem1, $ui_email)
	ClickPosUntilScreenByMultiPixel($ui_email_elem2, $ui_terms)
	ClickOnRelative($ui_terms_elem1)
	Sleep(500)
	ClickPosUntilScreenByMultiPixel($ui_terms_elem2, $ui_new_register)
	_ClipBoard_SetData(GetAccountInfo("uid"))
	ClickOnRelative($ui_new_register_elem1)
	SendPasteKeys()
	_ClipBoard_SetData(GetAccountInfo("pwd"))
	ClickOnRelative($ui_new_register_elem2)
	SendPasteKeys()
	ClickOnRelative($ui_new_register_elem3)
	SendPasteKeys()
	ClickPosUntilScreenByMultiPixel($ui_new_register_elem4, $ui_register_done)
	ClickOnRelative($ui_register_done_elem2)

	WaitPixelList($ui_startup)
	ClickPosUntilScreenByMultiPixel($menu_setting, $ui_setting)
	ClickPosUntilScreenByMultiPixel($ui_setting_elem3, $ui_option)
	ClickPosUntilScreenByMultiPixel($ui_option_elem5, $ui_logout)
	WriteLog("Click on confirm logout button")
	ClickOnRelative($ui_logout_elem2)
	Sleep(3000)
	WriteLog("Click on confirm logout button again")
	ClickOnRelative($ui_logout_elem2)
EndFunc   ;==>ChangeNameAndLogout

Func LoginAsGuest()
	WriteLog("Waiting for login screen")
	WaitPixelList($btn_denglu)
	WriteLog("Click on guest login")
	ClickOnRelative($btn_guest_login)
	WriteLog("Wait for notification setting window")
	WaitPixelList($btn_ntf_no)
	WriteLog("Click no for notification setting")
	ClickOnRelative($btn_ntf_no_elem1)
	WriteLog("Click asia server until guest login button appear")
	ClickPosUntilScreenByPixel($btn_server_asia, $btn_queren_guest_login)
	WriteLog("Confirm guest login")
	ClickOnRelative($btn_queren_guest_login)
	WriteLog("Waiting for startup UI")
	WaitPixelList($ui_startup)
	Sleep(1000)
	WriteLog("Click any place to start")
	ClickOnRelative($btn_ignore)
	SkipConversation()
EndFunc   ;==>LoginAsGuest

Func BackgroundStory()
	WriteLog("Chapter 1 start, waiting for ui_ready_to_skip.bmp")
	WaitImage("ui_ready_to_skip.bmp")
	SkipConversation()
	WriteLog("点击想移动的方向...")
	TrySkipTutorial()
	ProceeToNextFight()
	Sleep(1000)
	WriteLog("魔神的手下出现了...")
	TrySkipTutorial()
	WriteLog("Start to fight")
	Fight()
	WriteLog("使用指挥一击的话...")
	TrySkipTutorial()
	WriteLog("Continue to fight")
	Fight()
	SkipConversation()
	Sleep(3000)
	WriteLog("Waiting for ui_ready_to_skip.bmp")
	WaitImage("ui_ready_to_skip.bmp")
	SkipConversation()
	ProceeToNextFight()
	WriteLog("只要消灭一个家伙...")
	TrySkipTutorial()
	WriteLog("Start to fight")
	Fight()
	Sleep(4000)
	ProceeToNextFight()
	WriteLog("Start to fight, 中间会出现长动画")
	Fight()
	SkipConversation()
	Sleep(2000)
	WriteLog("三人战斗开始")
	ProceeToNextFight()
	WriteLog("Start to fight")
	Fight()
	Sleep(2000)
	ProceeToNextFight()
	SkipConversation()
	WriteLog("拉斯先生，就是现在...")
	TrySkipTutorial()
	WriteLog("Start to fight, 中间会出现超级长动画...")
	Fight()
	SkipConversation()
	; Bar screen begin
	WriteLog("Wait for notification screen")
	WaitPixelList($btn_close_announcement)
	WriteLog("Click on maoxian menu until btn_skip_tutorial.bmp appear")
	ClickPosUntilScreen($menu_maoxian, "btn_skip_tutorial.bmp", 1200)
	WriteLog("Click on btn_skip_tutorial.bmp")
	ClickImage("btn_skip_tutorial.bmp")
	Sleep(2000)
EndFunc   ;==>BackgroundStory

Func Fight1_1()
	WriteLog("1-1 start")
	WriteLog("Click on ready to fight button until ui_ready_to_skip.bmp")
	ClickPosUntilScreen($btn_ready_to_fight_elem1, "ui_ready_to_skip.bmp", 1000)
	SkipConversation()
	ProceeToNextFight()
	WriteLog("你好像很混乱...")
	TrySkipTutorial()
	WriteLog("Start to fight")
	Fight()
	SkipConversation()
	ProceeToNextFight() ;中间经过一个宝箱，还会出现一个对话情景 "这个世界和以前不太一样...". 会一直点击知道对话结束
	If IsReadyToSkipExist() = True Then
		TrySkipTutorial()
		ProceeToNextFight()
	EndIf
	WriteLog("Start to fight")
	Fight()
	SkipConversation()
	WriteLog("Click on stage clear arrow until zailaiyici button appear")
	ClickPosUntilScreenByMultiPixel($btn_stage_clear, $btn_zailaiyici, Default, 1200)
	WriteLog("Proceed to 1-2")
	ProceedToNextEpisode()
	WriteLog("Click on choose team button until ui_ready_to_skip.bmp")
	ClickPosUntilScreen($ui_1_2_choose_team_elem1, "ui_ready_to_skip.bmp")
EndFunc   ;==>Fight1_1

Func Fight1_2()
	WriteLog("1-2 start")
	SkipConversation()
	ProceeToNextFight()
	WriteLog("Start to fight 1-2-1")
	Fight() ; 哦~还挺不赖的嘛
	SkipConversation()
	ProceeToNextFight() ;中间经过一个宝箱
	If IsReadyToSkipExist() = True Then
		TrySkipTutorial()
	EndIf
	WriteLog("Start to fight 1-2-2")
	Fight() ; 呜哇啊啊啊啊啊啊！好帅喔！
	SkipConversation()
	ProceeToNextFight() ;中间经过女神像
	Sleep(3000)
	If IsReadyToSkipExist() = True Then
		TrySkipTutorial()
	EndIf
	WriteLog("Start to fight 1-2-3")
	Fight("img") ; 哼。。。就算没有我，王宫也能顺利运作！
	SkipConversation()
	WriteLog("Click on stage clear arrow until ok button appear")
	ClickPosUntilScreenByMultiPixel($btn_stage_clear, $btn_OK)
	ClickOnRelative($btn_OK_elem1)
	TrySkipTutorial(20) ;回到酒馆界面
	Sleep(2000)
	WriteLog("Click on maoxian button until ui_ready_to_skip.bmp")
	ClickPosUntilScreen($menu_maoxian, "ui_ready_to_skip.bmp")
	TrySkipTutorial()
	WriteLog("Click on renwu button")
	ClickPosUntilScreenByPixel($side_renwu, $side_renwu_clicked)
	Sleep(3000)
	WriteLog("Click on qianwang button until ready to fight button appear")
	ClickPosUntilScreenByPixel($btn_qianwang, $btn_ready_to_fight_elem1)
	WriteLog("Click on ready to fight button until ui_ready_to_skip.bmp")
	ClickPosUntilScreen($btn_ready_to_fight_elem1, "ui_ready_to_skip.bmp", 1000)
EndFunc   ;==>Fight1_2

Func Fight1_3()
	WriteLog("1-3 start")
	SkipConversation()
	ProceeToNextFight()
	WriteLog("Start to fight 1-3-1")
	Fight() ;那，那拉斯大人的神兽长怎样呢？
	SkipConversation()
	ProceeToNextFight()
	WriteLog("Start to fight 1-3-2")
	Fight() ;给我站住！不要逃跑！
	SkipConversation()
	ProceeToNextFight() ;中间经过一个宝箱
	WriteLog("Start to fight 1-3-3")
	Fight() ;哎。。。一到紧要关头就溜的不留人影。。。
	SkipConversation()
	WriteLog("Click on stage clear arrow until ok button appear")
	ClickPosUntilScreenByMultiPixel($btn_stage_clear, $btn_OK)
	WriteLog("Click on ok button")
	ClickOnRelative($btn_OK_elem1)
	TrySkipTutorial(20) ;回到酒馆界面
EndFunc   ;==>Fight1_3

Func PrepareFight()
	WriteLog("Prepare 1-3 repeat fight")
	WriteLog("Click on menu hero until add shenshou screen")
	ClickPosUntilScreenByMultiPixel($menu_hero, $ui_shenshou)
	WriteLog("Click on shenshou circle until green add shenshou button")
	ClickPosUntilScreenByMultiPixel($ui_shenshou_elem1, $ui_shenshoutongxing)
	WriteLog("Click on green add shenshou button")
	ClickOnRelative($ui_shenshoutongxing_elem1)
	Sleep(1000)
	WriteLog("Click on return arrow until bar screen")
	ClickPosUntilScreenByMultiPixel($btn_return_to_bar, $ui_bar)
	WriteLog("Click on menu maoxian until ready to fight button appear")
	ClickPosUntilScreenByMultiPixel($menu_maoxian, $btn_ready_to_fight)
	WriteLog("Click on ready to fight button until fight over flag")
	ClickPosUntilScreenByMultiPixel($btn_ready_to_fight_elem1, $ui_fight_over, Default, 1000)
EndFunc   ;==>PrepareFight

Func Fight1_3_repeat()
	WriteLog("1-3 repeat start")
	ProceeToNextFight()
	WriteLog("Start to fight 1-3-1 repeat")
	Fight()
	ProceeToNextFight()
	WriteLog("Start to fight 1-3-2 repeat")
	Fight()
	ProceeToNextFight()
	WriteLog("Start to fight 1-3-3 repeat")
	Fight()
	WaitPixelList($ui_assist_friend)
	Sleep(1000)
	ClickOnRelative($ui_assist_friend_elem3) ; 取消朋友请求
	WriteLog("Click on stage clear arrow until zailaiyici button appear")
	ClickPosUntilScreenByMultiPixel($btn_stage_clear, $btn_zailaiyici, Default, 1200)
	ProceedToNextEpisode()
	WriteLog("Click on choose team button until $ui_fight_over")
	ClickPosUntilScreenByMultiPixel($ui_1_2_choose_team_elem1, $ui_fight_over)
EndFunc   ;==>Fight1_3_repeat

Func Fight1_4()
	WriteLog("1-4 start")
	ProceeToNextFight()
	WriteLog("Start to fight 1-4-1")
	Fight() ; 前往王城的路有些复杂...
	SkipConversation()
	ProceeToNextFight() ;中间经过宝箱
	WriteLog("Start to fight 1-4-2")
	Fight() ; 战斗结束后没有对话
	ProceeToNextFight() ;中间经过女神像
	TrySkipTutorial()
	WriteLog("Start to fight 1-4-3")
	Fight() ; 。。。该怎么说呢？
	SkipConversation()
	WriteLog("Click on stage clear arrow until ok button appear")
	ClickPosUntilScreenByMultiPixel($btn_stage_clear, $btn_OK)
	WriteLog("Click on ok button")
	ClickOnRelative($btn_OK_elem1)
	WaitImage("ui_ready_to_skip.bmp") ;哇。。。这里就是万物图书馆啊
	SkipConversation()
EndFunc   ;==>Fight1_4

Func DrawFirstCard()
	TrySkipTutorial() ;回到酒馆界面
	WriteLog("Click on zhaohuan menu until shenyuezhaohuan appear")
	ClickPosUntilScreenByMultiPixel($menu_zhaohuan, $btn_shengyuezhaohuan)
	WriteLog("Click on shenyuezhaohuan until zhaohuan button appear")
	ClickPosUntilScreenByMultiPixel($btn_shengyuezhaohuan_elem1, $btn_zhaohuan)
	WriteLog("Click on zhaohuan button until queren zhaohuan button appear")
	ClickPosUntilScreenByMultiPixel($btn_zhaohuan_elem1, $btn_zhaohuan_queren)
	WriteLog("Click on queren zhaohuan button until summon hero tips appear")
	ClickPosUntilScreenByMultiPixel($btn_zhaohuan_queren_elem1, $ui_summon_hero)
EndFunc   ;==>DrawFirstCard

#comments-start
	Double click on skill 1 until
	1. ui_ready_to_skip.bmp appear
	2. fight over flag appear
#comments-end
Func Fight($exitoption = "all", $targetimg = "ui_ready_to_skip.bmp")
	Local $pos = [0, 0]
	Local $exitflag = False
	Do
		DoubleClickOn($btn_skill_1)
		WriteLog("Double click on skill 1")
		Sleep(1500)
		If SearchImageActive("btn_cancel_tutorial.bmp", $pos[0], $pos[1]) = 1 Then
			WriteLog("Skip toturail for 1-4 boss")
			ClickImage("btn_cancel_tutorial.bmp")
		EndIf
		If SearchImageActive($targetimg, $pos[0], $pos[1]) = 1 And ($exitoption = "all" Or $exitoption = "img") Then
			$exitflag = True
			WriteLog("Exit Fight - found " & $targetimg)
		ElseIf FindPixelList($ui_fight_over) = True And ($exitoption = "all" Or $exitoption = "pixel") Then
			$exitflag = True
			WriteLog("Exit Fight - found $ui_fight_over")
		ElseIf FindPixelList($ui_assist_friend) = True And ($exitoption = "all" Or $exitoption = "pixel") Then
			$exitflag = True
			WriteLog("Exit Fight - found $ui_assist_friend")
		EndIf
	Until $exitflag = True
EndFunc   ;==>Fight

#comments-start
	Wait for ui_ready_to_skip.bmp in 10 seconds, if found it, wait and click image btn_skip_tutorial.bmp, else continue
#comments-end
Func TrySkipTutorial($delay = 10)
	WriteLog("TrySkipTutorial begin")
	Local $pos = [0, 0]
	Local $result = "Exit TrySkipTutorial - " & $delay & " seconds timeout"
	Local $delayms = $delay * 1000
	For $x = 0 To $delayms Step 500
		If SearchImageActive("ui_ready_to_skip.bmp", $pos[0], $pos[1]) = 1 Then
			WriteLog("Found ui_ready_to_skip.bmp")
			ClickImage("btn_skip_tutorial.bmp")
			WriteLog("Clicked btn_skip_tutorial.bmp")
			$result = "Exit TrySkipTutorial - clicked ignore button"
			ExitLoop
		EndIf
		Sleep(500)
	Next
	WriteLog($result)
EndFunc   ;==>TrySkipTutorial

Func SkipConversation()
	WriteLog("SkipConversation begin")
	WaitImage("ui_ready_to_skip.bmp")
	ClickOnRelative($btn_ignore)
	WriteLog("SkipConversation end")
EndFunc   ;==>SkipConversation

#comments-start
	Press and hold until
	1. ui_ready_to_skip.bmp appear
	2. fight flag appear
	3. 30 seconds timeout
#comments-end
Func ProceeToNextFight()
	WriteLog("Go Go Go")
	Local $timeout = 30
	Local $pos = [0, 0]
	Local $exitflag = False
	Do
		PressAndHold($btn_go, 1)
		$timeout = $timeout - 1
		If FindPixelList($ui_fight) = True Then
			$exitflag = True
			WriteLog("Exit ProceedToNextFight - found $ui_fight")
		ElseIf $timeout < 0 Then
			$exitflag = True
			WriteLog("Exit ProceedToNextFight - hit 30 seconds timeout")
			Exit
		ElseIf SearchImageActive("ui_ready_to_skip.bmp", $pos[0], $pos[1]) = 1 Then
			$exitflag = True
			WriteLog("Exit ProceedToNextFight - found ui_ready_to_skip.bmp")
		EndIf
	Until $exitflag = True
EndFunc   ;==>ProceeToNextFight

Func IsReadyToSkipExist()
	Local $pos = [0, 0]
	Local $result = SearchImageActive("ui_ready_to_skip.bmp", $pos[0], $pos[1]) = 1
	Return $result
EndFunc   ;==>IsReadyToSkipExist

Func CloseFriendRequestScreen()
	If FindPixelList($ui_assist_friend) = True Then
		ClickOnRelative($ui_assist_friend_elem3)
	EndIf
EndFunc   ;==>CloseFriendRequestScreen

#comments-start
	Press and hold until
	1. choose team flag appear
	2. 30 seconds timeout
#comments-end
Func ProceedToNextEpisode()
	WriteLog("Proceed to next episode begin")
	Local $timeout = 5
	Do
		PressAndHold($btn_go, 1)
		$timeout = $timeout - 1
	Until $timeout < 0
	WriteLog("Proceed to next episode end")
EndFunc   ;==>ProceedToNextEpisode
