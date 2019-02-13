#cs ----------------------------------------------------------------------------
    AutoIt Version: 3.3.12.0
    Author: Chimaera

    Script Function: Desktop Resolution
#ce ----------------------------------------------------------------------------
#include-once
; #include <MsgBoxConstants.au3> ; Only required for the MsgBox constant
; MsgBox($MB_SYSTEMMODAL, "Desktop Resolution", _Desktop_Resolution() & " @ " & @DesktopRefresh & " Hertz. Bit depth: " & @DesktopDepth)

Func _Desktop_Resolution()
    Local $iDesktopWidth = @DesktopWidth, $iDesktopHeight = @DesktopHeight ; Slight speed increase by storing in variables
    Select
        Case $iDesktopWidth = 640 And $iDesktopHeight = 480 ; Video Graphics Array
            Return "640 x 480 (4:3) VGA"
        Case $iDesktopWidth = 800 And $iDesktopHeight = 480 ; Wide Video Graphics Array
            Return "800 x 480 (4:3) WVGA"
        Case $iDesktopWidth = 854 And $iDesktopHeight = 480 ; Full Wide Video Graphics Array
            Return "854 x 480 (4:3) FWVGA"
        Case $iDesktopWidth = 800 And $iDesktopHeight = 600 ; Super Video Graphics Array
            Return "800 x 600 (4:3) SVGA"
        Case $iDesktopWidth = 960 And $iDesktopHeight = 540 ; Quarter Full HD
            Return "960 x 540 (16:9) qHD"
        Case $iDesktopWidth = 1024 And $iDesktopHeight = 576; Wide Super Video Graphics Array
            Return "1024 x 576 (5:3) WSVGA"
        Case $iDesktopWidth = 1024 And $iDesktopHeight = 600 ; Wide Super Video Graphics Array
            Return "1024 x 600 (5:3) WSVGA"
        Case $iDesktopWidth = 1024 And $iDesktopHeight = 768; eXtended Graphics Array
            Return "1024 x 768 (4:3) XGA"
        Case $iDesktopWidth = 1152 And $iDesktopHeight = 864; eXtended Graphics Array Plus
            Return "1152 x 864 (4:3) XGA+"
        Case $iDesktopWidth = 1280 And $iDesktopHeight = 720 ; Wide eXtended Graphics Array
            Return "1280 x 720 (16:9) HD Ready"
        Case $iDesktopWidth = 1280 And $iDesktopHeight = 768; Wide eXtended Graphics Array
            Return "1280 x 768 (15:9) WXGA"
        Case $iDesktopWidth = 1280 And $iDesktopHeight = 800 ; Wide eXtended Graphics Array
            Return "1280 x 800 (16:10) WXGA"
        Case $iDesktopWidth = 1280 And $iDesktopHeight = 960 ; Super eXtended Graphics Array
            Return "1280 x 960 (4:3) SXGA"
        Case $iDesktopWidth = 1280 And $iDesktopHeight = 1024; Super eXtended Graphics Array
            Return "1280 x 1024 (5:4) SXGA"
        Case $iDesktopWidth = 1360 And $iDesktopHeight = 768; Wide eXtended Graphics Array
            Return "1360 x 768 (16:9) WXGA"
        Case $iDesktopWidth = 1366 And $iDesktopHeight = 768; High Definition (720p)
            Return "1366 x 768 (16:9) HD [720p]"
        Case $iDesktopWidth = 1440 And $iDesktopHeight = 900 ; Wide Super eXtended Graphics Array
            Return "1440 x 900 (16:10) WSXGA"
        Case $iDesktopWidth = 1400 And $iDesktopHeight = 1050 ; Wide Super eXtended Graphics Array
            Return "1440 x 900 (16:10) WSXGA"
        Case $iDesktopWidth = 1600 And $iDesktopHeight = 900 ; High Definition Plus (900p)
            Return "1600 x 900 (16:9) HD+ [900p]"
        Case $iDesktopWidth = 1600 And $iDesktopHeight = 1200 ; Ultra eXtended Graphics Array
            Return "1600 x 1200 (4:3) UXGA"
        Case $iDesktopWidth = 1680 And $iDesktopHeight = 1050 ; Wide Super eXtended Graphics Array Plus
            Return "1680 x 1050 (16:10) WSXGA+"
        Case $iDesktopWidth = 1920 And $iDesktopHeight = 1080 ; Full High Definition (1080p)
            Return "1920 x 1080 (16:9) HD [1080p]"
        Case $iDesktopWidth = 1920 And $iDesktopHeight = 1200 ; Wide Ultra eXtended Graphics Array
            Return "1920 x 1200 (16:10) WUXGA"
        Case $iDesktopWidth = 1920 And $iDesktopHeight = 1400 ; Tesselar eXtended Graphics Array
            Return "1920 x 1400 (48:35) TXGA"
        Case $iDesktopWidth = 2048 And $iDesktopHeight = 1080 ; Digital Film Projection
            Return "2048 x 1080 (19:10) 2K"
        Case $iDesktopWidth = 2048 And $iDesktopHeight = 1152; Quad Wide eXtended Graphics Array
            Return "2048 x 1152 (4:3) QWXGA"
        Case $iDesktopWidth = 2048 And $iDesktopHeight = 1536 ; Quad eXtended Graphics Array
            Return "2048 x 1536 (4:3) QXGA"
        Case $iDesktopWidth = 2538 And $iDesktopHeight = 1080 ; Wide Projector
            Return "2538 x 1080 (47:20) Wide Projector"
        Case $iDesktopWidth = 2560 And $iDesktopHeight = 1080 ; Cinema TV
            Return "2560 x 1080 (64:27) Cinema TV"
        Case $iDesktopWidth = 2560 And $iDesktopHeight = 1440 ; Wide Quad High Definition
            Return "2560 x 1440 (16:9) WQHD"
        Case $iDesktopWidth = 2560 And $iDesktopHeight = 1600 ; Wide Quad eXtended Graphics Array
            Return "2560 x 1600 (16:10) WQXGA"
        Case $iDesktopWidth = 2560 And $iDesktopHeight = 2048 ; Quad Super eXtended Graphics Array
            Return "2560 x 2048 (5:4) QSXGA"
        Case $iDesktopWidth = 2880 And $iDesktopHeight = 900 ; Dell Alienware
            Return "2880 x 900 (16:5) Curved Display"
        Case $iDesktopWidth = 3200 And $iDesktopHeight = 2048 ; Wide Quad Super eXtended Graphics Array
            Return "3200 x 2048 (25:16) WQSXGA"
        Case $iDesktopWidth = 3200 And $iDesktopHeight = 2400 ; Quad Ultra eXtended Graphics Array
            Return "3200 x 2048 (4:3) QUXGA"
        Case $iDesktopWidth = 3840 And $iDesktopHeight = 2160 ; Quad Full High Definition
            Return "3840 x 2160 (16:9) QFHD"
        Case $iDesktopWidth = 3840 And $iDesktopHeight = 2400 ; Wide Quad Ultra eXtended Graphics Array
            Return "3840 x 2048 (16:10) WQUXGA"
        Case $iDesktopWidth = 4096 And $iDesktopHeight = 1716 ; Digital Film Projection
            Return "4096 x 1716 (2:39) 4K"
        Case $iDesktopWidth = 4096 And $iDesktopHeight = 3072 ; Hex[adecatuple] eXtended Graphics Array
            Return "4096 x 3072 (4:3) HXGA"
        Case $iDesktopWidth = 5120 And $iDesktopHeight = 3200 ; Wide Hex[adecatuple] Extended Graphics Array
            Return "5120 x 3200 (16:10) WHXGA"
        Case $iDesktopWidth = 5120 And $iDesktopHeight = 4096 ; Hex[adecatuple] Super eXtended Graphics Array
            Return "5120 x 4096 (5:4) HSXGA"
        Case $iDesktopWidth = 6400 And $iDesktopHeight = 4096 ; Wide Hex[adecatuple] Super eXtended Graphics Array
            Return "6400 x 4096 (25:16) WHSXGA"
        Case $iDesktopWidth = 6400 And $iDesktopHeight = 4800 ; Hex[adecatuple] Ultra eXtended Graphics Array
            Return "6400 x 4800 (4:3) HUXGA"
        Case $iDesktopWidth = 7680 And $iDesktopHeight = 4320 ; Ultra High Definition Television
            Return "7680 x 4320 (16:9) UHDT"
        Case $iDesktopWidth = 7680 And $iDesktopHeight = 4800 ; Wide Hex[adecatuple] Ultra eXtended Graphics Array
            Return "7680 x 4800 (16:10) WHUXGA"
        Case Else ; If nothing matches then return the following
            Return SetError(1, 0, "")
    EndSelect
EndFunc   ;==>_Desktop_Resolution