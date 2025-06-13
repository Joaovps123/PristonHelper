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

; ========== INI Configuration Setup ==========
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

; ========== Global State ==========
isActive := false
isAutoClickEnabled := false
autoClickMode := "" ; "Fast" or "Slow"
isHoldingA := false
isGameFocused := false
isConfigMode := false
configTarget := ""
isPaused := false
pauseUntil := 0

hpX := "", hpY := "", hpColor := ""
stmX := "", stmY := "", stmColor := ""
mpX := "", mpY := "", mpColor := ""

lastClickTime := A_TickCount

LoadConfig()
SetTimer, CheckGameFocus, 300
Return

; ========== Game Focus Detection ==========
CheckGameFocus:
If WinActive("PristonTale") {
    If !isGameFocused {
        isGameFocused := true
        UpdateToolTip()
    }
} Else {
    If isGameFocused {
        isGameFocused := false
        UpdateToolTip()
    }
}
Return

; ========== Hotkeys ==========
^Numpad1:: ; Activate system
^1::
    If !IsConfigValid() {
        MsgBox, Please configure HP, STM, and MP before starting.
        Return
    }
    isActive := true
    isAutoClickEnabled := false
    autoClickMode := ""
    SetTimer, MainLoop, 50
    UpdateToolTip()
Return

^Numpad0:: ; Deactivate system
^0::
    isActive := false
    isAutoClickEnabled := false
    autoClickMode := ""
    SetTimer, MainLoop, Off
    SetTimer, ShowMouseTooltip, Off
    ToolTip
    isConfigMode := false
Return

^Numpad2:: ; Toggle Fast Auto Click
^2::
    If isActive {
        if (!isAutoClickEnabled || autoClickMode != "Fast") {
            isAutoClickEnabled := true
            autoClickMode := "Fast"
        } else {
            isAutoClickEnabled := false
            autoClickMode := ""
        }
        UpdateToolTip()
    }
Return

^Numpad3:: ; Toggle Slow Auto Click
^3::
    If isActive {
        if (!isAutoClickEnabled || autoClickMode != "Slow") {
            isAutoClickEnabled := true
            autoClickMode := "Slow"
            lastClickTime := A_TickCount
        } else {
            isAutoClickEnabled := false
            autoClickMode := ""
        }
        UpdateToolTip()
    }
Return

^Numpad7:: 
^7::StartConfig("HP")
Return
^Numpad8:: 
^8::StartConfig("STM")
Return
^Numpad9:: 
^9::StartConfig("MP")
Return

~*a::isHoldingA := true
~*a up::isHoldingA := false

~LButton::
If isConfigMode {
    MouseGetPos, x, y
    PixelGetColor, color, x, y, RGB
    IniWrite, %x%, %iniFile%, %configTarget%, X
    IniWrite, %y%, %iniFile%, %configTarget%, Y
    IniWrite, %color%, %iniFile%, %configTarget%, Color
    SetTimer, ShowMouseTooltip, Off
    isConfigMode := false
    ToolTip
    MsgBox, %configTarget% saved at X:%x% Y:%y% Color:%color%
    LoadConfig()
}
Return

~RButton::
If isConfigMode {
    SetTimer, ShowMouseTooltip, Off
    isConfigMode := false
    ToolTip
    MsgBox, Configuration for %configTarget% cancelled.
}
Return

; ========== Pause on Enter ==========
~*Enter::
~*NumpadEnter::
    isPaused := true
    pauseUntil := A_TickCount + 4000
    SetTimer, CheckPause, 100
Return

CheckPause:
If (A_TickCount >= pauseUntil) {
    isPaused := false
    SetTimer, CheckPause, Off
}
Return

; ========== Main Logic ==========
MainLoop:
If !isActive || !isGameFocused || isPaused
    Return

needsPotion := false

PixelGetColor, currentColor, %hpX%, %hpY%, RGB
If (currentColor <> hpColor) {
    SendInput, {1 down}
    Sleep, 50
    SendInput, {1 up}
    needsPotion := true
}

If !needsPotion {
    PixelGetColor, currentColor, %stmX%, %stmY%, RGB
    If (currentColor <> stmColor) {
        SendInput, {2 down}
        Sleep, 50
        SendInput, {2 up}
        needsPotion := true
    }
}

If !needsPotion {
    PixelGetColor, currentColor, %mpX%, %mpY%, RGB
    If (currentColor <> mpColor) {
        SendInput, {3 down}
        Sleep, 50
        SendInput, {3 up}
        needsPotion := true
    }
}

; Handle AutoClick based on mode
If (!needsPotion && isAutoClickEnabled && !isHoldingA && isGameFocused) {
    If (autoClickMode = "Fast") {
        Click, right
    } Else If (autoClickMode = "Slow") {
        If (A_TickCount - lastClickTime >= 2000) {
            Click, right
            lastClickTime := A_TickCount
        }
    }
}
Return

; ========== Mouse Tooltip During Config ==========
ShowMouseTooltip:
If isConfigMode {
    MouseGetPos, x, y
    PixelGetColor, color, x, y, RGB
    ToolTip, Configuring %configTarget%`nX: %x% | Y: %y% | Color: %color%
}
Return

; ========== Helper Functions ==========
StartConfig(barName) {
    global isActive, isConfigMode, configTarget
    if (isActive) {
        MsgBox, Disable the system before configuring.
        return
    }
    configTarget := barName
    isConfigMode := true
    SetTimer, ShowMouseTooltip, 50
}

UpdateToolTip() {
    global isActive, isAutoClickEnabled, autoClickMode, isGameFocused
    status := ""
    if (isActive)
        status := "Potion"
    if (isAutoClickEnabled) {
        if (status != "")
            status .= " | "
        status .= "AC:" autoClickMode
    }
    If (status != "" && isGameFocused)
        ToolTip, %status%
    Else
        ToolTip
}

LoadConfig() {
    global iniFile, hpX, hpY, hpColor, stmX, stmY, stmColor, mpX, mpY, mpColor
    IniRead, hpX, %iniFile%, HP, X
    IniRead, hpY, %iniFile%, HP, Y
    IniRead, hpColor, %iniFile%, HP, Color
    IniRead, stmX, %iniFile%, STM, X
    IniRead, stmY, %iniFile%, STM, Y
    IniRead, stmColor, %iniFile%, STM, Color
    IniRead, mpX, %iniFile%, MP, X
    IniRead, mpY, %iniFile%, MP, Y
    IniRead, mpColor, %iniFile%, MP, Color
}

IsConfigValid() {
    global hpX, hpY, hpColor, stmX, stmY, stmColor, mpX, mpY, mpColor
    return (hpX != "" && hpY != "" && hpColor != ""
         && stmX != "" && stmY != "" && stmColor != ""
         && mpX != "" && mpY != "" && mpColor != "")
}
