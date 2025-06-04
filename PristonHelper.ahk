; ================================================
; Priston Tale Helper - Auto Potion & Auto Click
; ================================================

#SingleInstance, Force
#NoEnv
SetBatchLines, -1
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SetTitleMatchMode, 2
#InstallKeybdHook
#UseHook On

; ================================================
; INI File Initialization
; ================================================
iniFile := A_ScriptDir "\PristonHelper.ini"

IfNotExist, %iniFile%
{
    FileAppend,
    (
[HP]
X=
Y=
Color=

[STM]
X=
Y=
Color=

[MP]
X=
Y=
Color=
    ), %iniFile%
}

; ================================================
; State Variables
; ================================================
Toggle := false
AutoClickEnabled := false
AutoClickMode := "" ; Fast or Slow
HoldingA := false
GameInFocus := false
ConfigModeActive := false
ConfiguringBar := ""

HP_X := "", HP_Y := "", HP_Color := ""
STM_X := "", STM_Y := "", STM_Color := ""
MP_X := "", MP_Y := "", MP_Color := ""

LoadConfig()
SetTimer, CheckGameWindow, 300
Return

CheckGameWindow:
If WinActive("PristonTale") {
    If !GameInFocus {
        GameInFocus := true
        UpdateToolTip()
    }
} Else {
    If GameInFocus {
        GameInFocus := false
        UpdateToolTip()
    }
}
Return

; ================================================
; Control Hotkeys
; ================================================
^Numpad1::
If !AllBarsConfigured() {
    MsgBox, Please configure HP, STM, and MP bars before starting.
    Return
}
Toggle := true
AutoClickEnabled := false
AutoClickMode := ""
SetTimer, MainLoop, 50
SetTimer, AutoClick, Off
UpdateToolTip()
Return

^Numpad0::
Toggle := false
AutoClickEnabled := false
AutoClickMode := ""
SetTimer, MainLoop, Off
SetTimer, AutoClick, Off
SetTimer, ShowMouseConfig, Off
ToolTip
ConfigModeActive := false
Return

^Numpad2:: ; Fast AC
If Toggle {
    if (!AutoClickEnabled || AutoClickMode != "Fast") {
        AutoClickEnabled := true
        AutoClickMode := "Fast"
        SetTimer, AutoClick, 180
    } else {
        AutoClickEnabled := false
        AutoClickMode := ""
        SetTimer, AutoClick, Off
    }
    UpdateToolTip()
}
Return

^Numpad3:: ; Slow AC
If Toggle {
    if (!AutoClickEnabled || AutoClickMode != "Slow") {
        AutoClickEnabled := true
        AutoClickMode := "Slow"
        SetTimer, AutoClick, 1500
    } else {
        AutoClickEnabled := false
        AutoClickMode := ""
        SetTimer, AutoClick, Off
    }
    UpdateToolTip()
}
Return

~a::HoldingA := true
~a up::HoldingA := false

^Numpad7::StartConfig("HP")
Return
^Numpad8::StartConfig("STM")
Return
^Numpad9::StartConfig("MP")
Return

~LButton::
If (ConfigModeActive) {
    MouseGetPos, x, y
    PixelGetColor, color, x, y, RGB
    IniWrite, %x%, %iniFile%, %ConfiguringBar%, X
    IniWrite, %y%, %iniFile%, %ConfiguringBar%, Y
    IniWrite, %color%, %iniFile%, %ConfiguringBar%, Color
    SetTimer, ShowMouseConfig, Off
    ConfigModeActive := false
    ToolTip
    MsgBox, %ConfiguringBar% saved at X:%x% Y:%y% Color:%color%
    LoadConfig()
}
Return

~RButton::
If (ConfigModeActive) {
    SetTimer, ShowMouseConfig, Off
    ConfigModeActive := false
    ToolTip
    MsgBox, Configuration for %ConfiguringBar% cancelled.
}
Return

; ================================================
; Main Potion Logic
; ================================================
MainLoop:
If !Toggle || !GameInFocus
    Return

prioridadeAtendida := false
PixelGetColor, currentColor, %HP_X%, %HP_Y%, RGB
If (currentColor <> HP_Color) {
    SendInput, {1 down}
    Sleep, 50
    SendInput, {1 up}
    prioridadeAtendida := true
}
If !prioridadeAtendida {
    PixelGetColor, currentColor, %STM_X%, %STM_Y%, RGB
    If (currentColor <> STM_Color) {
        SendInput, {2 down}
        Sleep, 50
        SendInput, {2 up}
        prioridadeAtendida := true
    }
}
If !prioridadeAtendida {
    PixelGetColor, currentColor, %MP_X%, %MP_Y%, RGB
    If (currentColor <> MP_Color) {
        SendInput, {3 down}
        Sleep, 50
        SendInput, {3 up}
        prioridadeAtendida := true
    }
}
If !prioridadeAtendida && AutoClickEnabled && !HoldingA && GameInFocus {
    Click, right
}
Return

AutoClick:
If Toggle && AutoClickEnabled && !HoldingA && GameInFocus {
    Click, right
}
Return

ShowMouseConfig:
If (ConfigModeActive) {
    MouseGetPos, x, y
    PixelGetColor, color, x, y, RGB
    ToolTip, Configuring %ConfiguringBar%`nX: %x% | Y: %y% | Color: %color%
}
Return

StartConfig(bar) {
    global ConfigModeActive, ConfiguringBar, Toggle
    if (Toggle) {
        MsgBox, Disable the system before configuring.
        return
    }
    ConfiguringBar := bar
    ConfigModeActive := true
    SetTimer, ShowMouseConfig, 50
}

UpdateToolTip() {
    global Toggle, AutoClickEnabled, AutoClickMode, GameInFocus
    tooltipText := ""
    if (Toggle)
        tooltipText := "Potion"
    if (AutoClickEnabled) {
        if (tooltipText != "")
            tooltipText .= " | "
        tooltipText .= "AC:" AutoClickMode
    }
    If (tooltipText != "" && GameInFocus)
        ToolTip, %tooltipText%
    Else
        ToolTip
}

LoadConfig() {
    global iniFile, HP_X, HP_Y, HP_Color, STM_X, STM_Y, STM_Color, MP_X, MP_Y, MP_Color
    IniRead, HP_X, %iniFile%, HP, X
    IniRead, HP_Y, %iniFile%, HP, Y
    IniRead, HP_Color, %iniFile%, HP, Color
    IniRead, STM_X, %iniFile%, STM, X
    IniRead, STM_Y, %iniFile%, STM, Y
    IniRead, STM_Color, %iniFile%, STM, Color
    IniRead, MP_X, %iniFile%, MP, X
    IniRead, MP_Y, %iniFile%, MP, Y
    IniRead, MP_Color, %iniFile%, MP, Color
}

AllBarsConfigured() {
    global HP_X, HP_Y, HP_Color, STM_X, STM_Y, STM_Color, MP_X, MP_Y, MP_Color
    if (HP_X != "" && HP_Y != "" && HP_Color != "" 
     && STM_X != "" && STM_Y != "" && STM_Color != "" 
     && MP_X != "" && MP_Y != "" && MP_Color != "")
        return true
    return false
}
