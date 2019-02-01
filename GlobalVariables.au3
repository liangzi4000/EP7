#include-once
#Region General configuration
Global Enum $exitaction_restart, $exitaction_terminatescript, $exitaction_shutdownpc
Global $activewindow = "" ; Store current active window
Global $inactivewindows = [] ; Store inactive windows
Global $debug = False ; Debug falg, turn on to write detail log
Global $exit = False ; Terminate script flag
Global $shutdownpc = False ; Shut down pc after script completed
Global $exitaction = $exitaction_restart ; Action to take upon exit, default is to restart program
Global $winleftready = False ; Align window left flag
Global $winrightready = False ; Align window right flag
Global $timeoutcount = 0 ; Count number of timeout for function that invoking itself
Global Const $lastclickposition = "lastclicked" ; Name const of last clicked position
Global Const $lastimageposition = "lastimage" ; Name const of last image center position
Global Const $pixelinfo_shadow_variation = 5 ; Default PixelSearch shadow variation
Global Const $pixelinfo_half_width = 2 ; Default PixelSearch range half width
Global Const $pixelinfo_half_height = 2 ; Default PixelSearch range half height
Global Const $pixel_empty = [0, 0] ; Default result position of PixelSearch
Global Const $v_winctrlclassname = "subWin1"
Global Const $v_imagepath = @ScriptDir & "\Assets\identifier\"
#EndRegion General configuration

#Region App specific configuration
Global $btn_ignore[2] = [951, 28] ; 跳过
Global $btn_go[2] = [823, 336] ; GO
Global $btn_skill_3[2] = [935, 508] ; 第三技能
Global $btn_skill_2[2] = [856, 488] ; 第二技能
Global $btn_skill_1[2] = [781, 488] ; 第一技能
Global $side_renwu[3] = [939, 148, 0x4AD8D1] ; 任务
Global $side_renwu_clicked[3] = [462, 151, 0x086D73] ; 任务打开之后
Global $btn_qianwang[2] = [912, 257] ; 接受/前往
Global $btn_stage_clear[2] = [950, 516] ; stage clear
Global $btn_guest_login[2] = [481, 493] ; 游客登入
Global $btn_server_asia[2] = [664, 201] ; 亚服
Global $menu_zhaohuan[3] = [176, 499, 0xB5B5B5] ; 召唤
Global $menu_hero[3] = [111, 493, 0xEBEBEB] ; 英雄
Global $menu_maoxian[3] = [927, 517, 0xD4D4D4] ; 冒险
Global $menu_setting[3] = [960, 34, 0x4487EB] ;设置按钮
Global $ui_bar = [$menu_hero, $menu_maoxian, $menu_setting] ; 酒吧界面
Global $btn_queren_guest_login[3] = [544, 335, 0x030F24] ;确认游客登陆
Global $ui_ready_free_draw[3] = [253, 487, 0xDB550B] ;Ready for free draw
Global $btn_mailbox_receive_all[3] = [727, 74, 0x2D2D2D] ;信件->接收 全部领取
Global $btn_mailbox_receive_green[3] = [763, 199, 0x165010] ;信件->接收 绿色领取按钮
Global $btn_mailbox_operation_tab[3] = [291, 119, 0x90641B] ;信件->营运 橘黄色背景
Global $btn_mailbox_operation_receive[3] = [764, 199, 0x165010] ;信件->营运->接收 绿色按钮
Global $btn_mailbox_operation_pop_receive[3] = [494, 456, 0x1D6110] ;信件->营运->pop->接收 绿色按钮


; 战斗开始
Global $ui_fight_elem1[3] = [25, 63, 0xFFFFFF] ; Hourglass
Global $ui_fight_elem2[3] = [33, 20, 0xFFFFFF] ; bag
Global $ui_fight_elem3[3] = [118, 18, 0xFFFFFF] ; sword
Global $ui_fight[3] = [$ui_fight_elem1, $ui_fight_elem2, $ui_fight_elem3]

; 战斗结束
Global $ui_fight_over_elem1[3] = [33, 119, 0xFFFFFF] ; bag - map
Global $ui_fight_over_elem2[3] = [115, 116, 0xFFFFFF] ; sword - map
Global $ui_fight_over_elem3[3] = [86, 49, 0xFFFFFF] ; 当前位置 - 白点
Global $ui_fight_over = [$ui_fight_over_elem1, $ui_fight_over_elem2, $ui_fight_over_elem3]

; 圣约召唤
Global $btn_shengyuezhaohuan_elem1[3] = [734, 226, 0xFDC043] ;中间黄色十字星
Global $btn_shengyuezhaohuan_elem2[3] = [740, 232, 0x38749F] ;右下加蓝色边框
Global $btn_shengyuezhaohuan_elem3[3] = [756, 214, 0x061620] ;右上角黑色部分
Global $btn_shengyuezhaohuan = [$btn_shengyuezhaohuan_elem1, $btn_shengyuezhaohuan_elem2, $btn_shengyuezhaohuan_elem3]

; 再来一次
Global $btn_zailaiyici_elem1[3] = [902, 510, 0xFFFFFF] ; 再来一次 - 白色文字
Global $btn_zailaiyici_elem2[3] = [946, 509, 0x20160B] ; 再来一次 - 棕色背景
Global $btn_zailaiyici_elem3[3] = [765, 491, 0x231B0A] ; 再来一次 - 棕色背景
Global $btn_zailaiyici = [$btn_zailaiyici_elem1, $btn_zailaiyici_elem2, $btn_zailaiyici_elem3]

; 选择队伍
Global $ui_1_2_choose_team_elem1[4] = [721, 495, 0xF4EEF4, 20] ; 选择队伍 - 白色文字
Global $ui_1_2_choose_team_elem2[4] = [619, 338, 0xEBE4EB, 20] ; 白色背包 - 可获得的奖励
Global $ui_1_2_choose_team_elem3[4] = [197, 41, 0xF5EEF5, 20] ; 选择辅助英雄 - 白色文字
Global $ui_1_2_choose_team = [$ui_1_2_choose_team_elem1, $ui_1_2_choose_team_elem2, $ui_1_2_choose_team_elem3]

; 召唤英雄提示
Global $ui_summon_hero_elem1[3] = [483, 67, 0xFFFFFF] ; 召唤英雄 - 白色文字
Global $ui_summon_hero_elem2[3] = [507, 206, 0x120804] ; 书本
Global $ui_summon_hero_elem3[3] = [631, 444, 0x8C6F4C] ; 黄色文字
Global $ui_summon_hero = [$ui_summon_hero_elem1, $ui_summon_hero_elem2, $ui_summon_hero_elem3]

; 登陆界面 - 白色背景按钮
Global $btn_denglu_elem1[3] = [450, 450, 0xFFFFFF]
Global $btn_denglu_elem2[3] = [496, 452, 0x000000]
Global $btn_denglu = [$btn_denglu_elem1, $btn_denglu_elem2]

; Android Notification Window
Global $btn_ntf_no_elem1[3] = [632, 316, 0xD7D7D7]
Global $btn_ntf_no_elem2[3] = [653, 310, 0x000000]
Global $btn_ntf_no = [$btn_ntf_no_elem1, $btn_ntf_no_elem2]

; 加载完毕，点击开始
Global $ui_startup_elem1[3] = [853, 523, 0x041105]
Global $ui_startup_elem2[3] = [892, 520, 0x838783]
Global $ui_startup = [$ui_startup_elem1, $ui_startup_elem2]

; OK button
Global $btn_OK_elem1[3] = [497, 398, 0xFFFFFF]
Global $btn_OK_elem2[3] = [452, 399, 0x180A03]
Global $btn_OK = [$btn_OK_elem1, $btn_OK_elem2]

;朋友邀请
Global $ui_pengyouyaoqing_elem1[3] = [483, 133, 0xFFFFFF] ;给予协助的朋友 白色文字
Global $ui_pengyouyaoqing_elem2[3] = [583, 396, 0xFDFDFD] ;申请 白色文字
Global $ui_pengyouyaoqing_elem3[3] = [402, 392, 0xFDFDFD] ;取消 白色文字
Global $ui_pengyouyaoqing_elem4[3] = [734, 283, 0xFFFFFF] ;玩家情报 白色文字
Global $ui_pengyouyaoqing = [$ui_pengyouyaoqing_elem1, $ui_pengyouyaoqing_elem2, $ui_pengyouyaoqing_elem3, $ui_pengyouyaoqing_elem4]

;配置神兽界面
Global $ui_shenshou_elem1[3] = [204, 194, 0x3389E1]
Global $ui_shenshou_elem2[3] = [207, 209, 0x346B99]
Global $ui_shenshou = [$ui_shenshou_elem1, $ui_shenshou_elem2]

;选择神兽界面
Global $ui_shenshoutongxing_elem1[3] = [219, 466, 0xFFFFFF]
Global $ui_shenshoutongxing_elem2[3] = [286, 468, 0x072915]
Global $ui_shenshoutongxing = [$ui_shenshoutongxing_elem1, $ui_shenshoutongxing_elem2]

;返回酒馆按钮
Global $btn_return_to_bar[3] = [23, 24, 0xFFFFFF]

;召唤
Global $btn_zhaohuan_elem1[3] = [398, 511, 0xFFFFFF]
Global $btn_zhaohuan_elem2[3] = [411, 508, 0x092D1C]
Global $btn_zhaohuan = [$btn_zhaohuan_elem1, $btn_zhaohuan_elem2]

;确认召唤
Global $btn_zhaohuan_queren_elem1[3] = [576, 397, 0xFFFFFF]
Global $btn_zhaohuan_queren_elem2[3] = [609, 394, 0x052514]
Global $btn_zhaohuan_queren = [$btn_zhaohuan_queren_elem1, $btn_zhaohuan_queren_elem2]

;关闭公告
Global $btn_close_announcement_elem1[3] = [953, 34, 0xFFFFFF]
Global $btn_close_announcement_elem2[3] = [933, 32, 0xFFFFFF]
Global $btn_close_announcement_elem3[3] = [887, 514, 0xEBE8E8] ;右下角关闭按钮
Global $btn_close_announcement = [$btn_close_announcement_elem1, $btn_close_announcement_elem2]

;
Global $btn_ready_to_fight_elem1[3] = [829, 506, 0xE1E4E1]
Global $btn_ready_to_fight_elem2[3] = [840, 508, 0x113119]
Global $btn_ready_to_fight = [$btn_ready_to_fight_elem1, $btn_ready_to_fight_elem2]

;给与协助的好友
Global $ui_assist_friend_elem1[3] = [412, 133, 0xFFFFFF] ;给与协助的好友 - 白色文字
Global $ui_assist_friend_elem2[3] = [691, 295, 0x311D09] ;玩家情报 - 棕色背景
Global $ui_assist_friend_elem3[3] = [402, 398, 0xFDFDFD] ;取消 - 白色文字
Global $ui_assist_friend_elem4[3] = [578, 393, 0xFFFFFF] ;申请 - 白色文字
Global $ui_assist_friend_elem5[3] = [606, 394, 0x052514] ;申请 - 绿色背景
Global $ui_assist_friend_elem6[3] = [447, 395, 0x150902] ;取消 - 棕色背景
Global $ui_assist_friend_elem7[3] = [369, 317, 0xFDFAF1] ;多指教 - 白色背景
Global $ui_assist_friend_elem8[3] = [446, 301, 0x000000] ;多指教 - 旁边黑色
Global $ui_assist_friend = [$ui_assist_friend_elem1, $ui_assist_friend_elem2, $ui_assist_friend_elem3, $ui_assist_friend_elem4, $ui_assist_friend_elem5, $ui_assist_friend_elem6, $ui_assist_friend_elem7, $ui_assist_friend_elem8]

;更改名称
Global $ui_changename_elem1[3] = [218, 68, 0xFFEFDC] ;左上角 - 人脸
Global $ui_changename_elem2[3] = [388, 473, 0xFFFFFF] ;变更名称
Global $ui_changename_elem3[3] = [766, 407, 0x828283] ;设置齿轮
Global $ui_changename = [$ui_changename_elem1, $ui_changename_elem2, $ui_changename_elem3]

;更改名称 - 小弹窗
Global $ui_changename_pop_elem1[3] = [479, 242, 0xF2F2F2] ;白色文本输入框
Global $ui_changename_pop_elem2[3] = [644, 241, 0x092B15] ;重复检查
Global $ui_changename_pop_elem3[3] = [528, 352, 0x052514] ;变更
Global $ui_changename_pop = [$ui_changename_pop_elem1, $ui_changename_pop_elem2, $ui_changename_pop_elem3]

;名字无重复
Global $ui_changename_pop_elem4[3] = [567, 242, 0x727272] ;确认
Global $ui_changename_pop_name_ok = [$ui_changename_pop_elem1, $ui_changename_pop_elem4, $ui_changename_pop_elem3]

;更改名称 - 完成
Global $ui_changename_done = [$ui_changename_elem1, $ui_changename_elem3]

;设置界面
Global $ui_setting_elem1[3] = [964, 25, 0xFFFFFF] ; 右上角 X
Global $ui_setting_elem2[3] = [732, 185, 0xFFFFFF] ; 好友
Global $ui_setting_elem3[3] = [703, 515, 0xFFFFFF] ; 设定齿轮
Global $ui_setting = [$ui_setting_elem1, $ui_setting_elem2, $ui_setting_elem3]

;选项界面
Global $ui_option_elem1[3] = [380, 92, 0x503D21] ; 账号设定
Global $ui_option_elem2[3] = [429, 412, 0x062615] ; 常见问题
;~ ;;;;;;;;;;;;;;;;;; Global $ui_option_elem3[3] = [436, 469,0x062615] ; 出席奖励
Global $ui_option_elem4[3] = [369, 185, 0xFFFFFF] ; 账号管理
Global $ui_option_elem5[3] = [369, 237, 0xFFFFFF] ; 登出
Global $ui_option = [$ui_option_elem1, $ui_option_elem2]

;角色转移界面
Global $ui_link_elem1[3] = [329, 304, 0xFF5000] ; email
Global $ui_link_elem2[3] = [469, 304, 0x2957A2] ; facebook
Global $ui_link_elem3[3] = [629, 312, 0xE94334] ; google
Global $ui_link = [$ui_link_elem1, $ui_link_elem2, $ui_link_elem3]

;Email UI
Global $ui_email_elem1[3] = [409, 405, 0xFBE2D1] ; 确定按钮
Global $ui_email_elem2[3] = [491, 481, 0xF7C09B] ; 新注册
Global $ui_email = [$ui_email_elem1, $ui_email_elem2]

;使用条款
Global $ui_terms_elem1[3] = [139, 408, 0xD1D1D1] ; 全部同意
Global $ui_terms_elem2[3] = [433, 478, 0xF7AA96] ; 开始
Global $ui_terms_elem3[3] = [133, 128, 0xD1D1D1] ; STOVE服务条款
Global $ui_terms = [$ui_terms_elem1, $ui_terms_elem2, $ui_terms_elem3]

;新注册界面
Global $ui_new_register_elem1[3] = [547, 161, 0xF7F2EE] ; 邮箱
Global $ui_new_register_elem2[3] = [534, 244, 0xF7F2EE] ; 密码
Global $ui_new_register_elem3[3] = [540, 321, 0xF7F2EE] ; 重复密码
Global $ui_new_register_elem4[3] = [528, 405, 0xFBE2D1] ; 确定
Global $ui_new_register = [$ui_new_register_elem1, $ui_new_register_elem2, $ui_new_register_elem3, $ui_new_register_elem4]

;新注册界面 - 完成
Global $ui_register_done_elem1[3] = [499, 249, 0x0A0A09] ; 已完成
Global $ui_register_done_elem2[3] = [546, 307, 0xD4D4D4] ; 确定
Global $ui_register_done = [$ui_register_done_elem1, $ui_register_done_elem2]

;登出界面
Global $ui_logout_elem1[3] = [447, 370, 0x1A0C04] ; 取消
Global $ui_logout_elem2[3] = [610, 369, 0x031025] ; 确认
Global $ui_logout = [$ui_logout_elem1, $ui_logout_elem2]

;登陆选项界面
Global $ui_login_option_elem1[3] = [287, 187, 0xFF5000] ; 橘黄色人头像
Global $ui_login_option_elem2[3] = [320, 243, 0xFFFFFF] ; 白色勾
Global $ui_login_option_elem3[3] = [321, 226, 0xFF5000] ; 橘黄色圆圈
Global $ui_login_option_elem4[3] = [493, 428, 0xFFFFFF] ; 用其它账号开始游戏
Global $ui_login_option = [$ui_login_option_elem1, $ui_login_option_elem2, $ui_login_option_elem3, $ui_login_option_elem4]

; STOVE 登陆界面
Global $ui_stove_login_elem1[3] = [376, 191, 0xFFFFFF] ; 邮箱或ID
Global $ui_stove_login_elem2[3] = [376, 258, 0xFFFFFF] ; 密码
Global $ui_stove_login_elem3[3] = [795, 226, 0xFF5000] ; 登陆按钮
Global $ui_stove_login_elem4[3] = [491, 129, 0xFF5000] ; 橘黄色STOVE
Global $ui_stove_login = [$ui_stove_login_elem1, $ui_stove_login_elem2, $ui_stove_login_elem3, $ui_stove_login_elem4]

; 召唤完成 - 返回箭头
Global $ui_return_after_zhaohuan_elem1[3] = [50, 502, 0xAB8759]
Global $ui_return_after_zhaohuan_elem2[3] = [56, 509, 0xAB8759]
Global $ui_return_after_zhaohuan_elem3[3] = [50, 515, 0xAB8759]
Global $ui_return_after_zhaohuan = [$ui_return_after_zhaohuan_elem1, $ui_return_after_zhaohuan_elem2, $ui_return_after_zhaohuan_elem3]

; 每日登陆奖励
Global $ui_daily_award_elem1[3] = [840, 504, 0xFFFFFF] ; 确认按钮 白色文字
Global $ui_daily_award_elem2[3] = [820, 503, 0x041025] ; 确认按钮 蓝色背景
Global $ui_daily_award = [$ui_daily_award_elem1, $ui_daily_award_elem2]

; 下次再次召唤
Global $ui_next_summon_elem1[3] = [434, 463, 0xFCF9F0] ; X小时候可免费召唤 白色背景
Global $ui_next_summon_elem2[3] = [22, 25, 0xFFFFFF] ; 左上角-返回箭头
Global $ui_next_summon_elem3[3] = [583, 510, 0xFFFFFF] ; 底部-圣约召唤白色图标
Global $ui_next_summon_elem4[3] = [638, 511, 0xFFFFFF] ; 底部-图鉴白色图标
Global $ui_next_summon_elem5[3] = [738, 371, 0x7DBB17] ; 右侧-友情召唤绿色图标
Global $ui_next_summon_elem6[3] = [864, 33, 0xFFFFFF] ; 右上角-信件白色图标
Global $ui_next_summon_elem7[3] = [967, 23, 0x4487EB] ; 右上角-设置蓝色图标1
Global $ui_next_summon_elem8[3] = [966, 37, 0x4487EB] ; 右上角-设置蓝色图标2
Global $ui_next_summon_elem9[3] = [948, 37, 0x4487EB] ; 右上角-设置蓝色图标3
Global $ui_next_summon = [$btn_zhaohuan_elem1, $btn_zhaohuan_elem2, $ui_next_summon_elem1, $ui_next_summon_elem2, $ui_next_summon_elem3, $ui_next_summon_elem4, $ui_next_summon_elem5, $ui_next_summon_elem6,$ui_next_summon_elem7,$ui_next_summon_elem8,$ui_next_summon_elem9]

; 信件界面
Global $ui_mailbox_elem1[3] = [184, 78, 0xFFFFFF] ; 信件-白色文字-信
Global $ui_mailbox_elem2[3] = [207, 70, 0xFFFFFF] ; 信件-白色文字-件
Global $ui_mailbox_elem3[3] = [229, 108, 0x4D3C22] ; 一般-黄色背景
;~ Global $ui_mailbox_elem4[3] = [147, 297, 0x634F34] ; 左边-黄色边框
;~ Global $ui_mailbox_elem5[3] = [477, 508, 0x91795A] ; 下边-黄色边框
;~ Global $ui_mailbox_elem6[3] = [838, 299, 0x634F34] ; 右边-黄色边框
;~ Global $ui_mailbox_elem7[3] = [299, 108, 0xCFCFCF] ; 营运-白色文字
Global $ui_mailbox = [$ui_mailbox_elem1, $ui_mailbox_elem2, $ui_mailbox_elem3]

; 再召唤一次
Global $btn_summon_again_elem1[3] = [701, 505, 0xFCC146] ; 再召唤一次-圣约召唤图标
Global $btn_summon_again_elem2[3] = [801, 505, 0x092518] ; 再召唤一次-绿色背景
Global $btn_summon_again_elem3[3] = [869, 501, 0xFEFEFE] ; 再召唤一次-白色文字
Global $btn_summon_again = [$btn_summon_again_elem1,$btn_summon_again_elem2,$btn_summon_again_elem3]

; 没有可领取的信件
Global $ui_no_mail_elem1[4] = [492, 273, 0x555555,2] ; 中间i
Global $ui_no_mail_elem2[4] = [516, 282, 0x121212,2] ; 黑色部分
Global $ui_no_mail_elem3[4] = [459, 303, 0x4E4E4E,2] ; 灰色文字
Global $ui_no_mail_elem4[4] = [528, 302, 0x545454,2] ; 灰色文字
Global $ui_no_mail = [$ui_no_mail_elem1,$ui_no_mail_elem2,$ui_no_mail_elem3,$ui_no_mail_elem4]

; 新春出席活动-蓝色确认按钮
Global $btn_new_year_ok_elem1[3] = [649, 483, 0x041025] ; 左边蓝色
Global $btn_new_year_ok_elem2[3] = [738, 486, 0x041026] ; 右边蓝色
Global $btn_new_year_ok = [$btn_new_year_ok_elem1,$btn_new_year_ok_elem2]

#EndRegion App specific configuration

#Region General Function Configuration
Global Const $g_fn_closeapp = "CloseApp"
#EndRegion General Function Configuration

#include <Configuration.au3>
