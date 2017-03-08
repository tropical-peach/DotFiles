#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

DetectHiddenWindows, On
hwnd:=WinExist("ahk_pid " . DllCall("GetCurrentProcessId","Uint"))
hwnd+=0x1000<<32

hVirtualDesktopAccessor := DllCall("LoadLibrary", Str, "C:\Users\seppala.steven\Desktop\bin\win_bin\VirtualDesktopAccessor.dll", "Ptr") 
GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")
IsWindowOnCurrentVirtualDesktopProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnCurrentVirtualDesktop", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "MoveWindowToDesktopNumber", "Ptr")
RegisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RegisterPostMessageHook", "Ptr")
UnregisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnregisterPostMessageHook", "Ptr")
IsPinnedWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedWindow", "Ptr")
RestartVirtualDesktopAccessorProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RestartVirtualDesktopAccessor", "Ptr")
; GetWindowDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetWindowDesktopNumber", "Ptr")
activeWindowByDesktop := {}

; Restart the virtual desktop accessor when Explorer.exe crashes, or restarts (e.g. when coming from fullscreen game)
explorerRestartMsg := DllCall("user32\RegisterWindowMessage", "Str", "TaskbarCreated")
OnMessage(explorerRestartMsg, "OnExplorerRestart")
OnExplorerRestart(wParam, lParam, msg, hwnd) {
    global RestartVirtualDesktopAccessorProc
    DllCall(RestartVirtualDesktopAccessorProc, UInt, result)
}

MoveCurrentWindowToDesktop(number) {
    global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc, activeWindowByDesktop
    WinGet, activeHwnd, ID, A
    activeWindowByDesktop[number] := 0 ; Do not activate
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, number)
    DllCall(GoToDesktopNumberProc, UInt, number)
}

GoToPrevDesktop() {
    global GetCurrentDesktopNumberProc, GoToDesktopNumberProc
    current := DllCall(GetCurrentDesktopNumberProc, UInt)
    if (current = 0) {
        GoToDesktopNumber(7)
    } else {
        GoToDesktopNumber(current - 1)      
    }
    return
}

GoToNextDesktop() {
    global GetCurrentDesktopNumberProc, GoToDesktopNumberProc
    current := DllCall(GetCurrentDesktopNumberProc, UInt)
    if (current = 7) {
        GoToDesktopNumber(0)
    } else {
        GoToDesktopNumber(current + 1)    
    }
    return
}

GoToDesktopNumber(num) {
    global GetCurrentDesktopNumberProc, GoToDesktopNumberProc, IsPinnedWindowProc, activeWindowByDesktop

    ; Store the active window of old desktop, if it is not pinned
    WinGet, activeHwnd, ID, A
    current := DllCall(GetCurrentDesktopNumberProc, UInt) 
    isPinned := DllCall(IsPinnedWindowProc, UInt, activeHwnd)
    if (isPinned == 0) {
        activeWindowByDesktop[current] := activeHwnd
    }

    ; Try to avoid flashing task bar buttons, deactivate the current window if it is not pinned
    if (isPinned != 1) {
        WinActivate, ahk_class Shell_TrayWnd
    }

    ; Change desktop
    DllCall(GoToDesktopNumberProc, Int, num)
    return
}

; Windows 10 desktop changes listener
DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
OnMessage(0x1400 + 30, "VWMess")
VWMess(wParam, lParam, msg, hwnd) {
    global IsWindowOnCurrentVirtualDesktopProc, IsPinnedWindowProc, activeWindowByDesktop

    desktopNumber := lParam + 1

    ; Try to restore active window from memory (if it's still on the desktop and is not pinned)
    WinGet, activeHwnd, ID, A 
    isPinned := DllCall(IsPinnedWindowProc, UInt, activeHwnd)
    oldHwnd := activeWindowByDesktop[lParam]
    isOnDesktop := DllCall(IsWindowOnCurrentVirtualDesktopProc, UInt, oldHwnd, UInt)
    if (isOnDesktop == 1 && isPinned != 1) {
        WinActivate, ahk_id %oldHwnd%
    }

}

; Switching desktops:
; Win + Ctrl + 1 = Switch to desktop 1
+#1::GoToDesktopNumber(0)

; Win + Ctrl + 2 = Switch to desktop 2
+#2::GoToDesktopNumber(1)
+#3::GoToDesktopNumber(2)
+#4::GoToDesktopNumber(3)
+#5::GoToDesktopNumber(4)
+#6::GoToDesktopNumber(5)

; Moving windowes:
; Win + Shift + 1 = Move current window to desktop 1, and go there
*#2::MoveCurrentWindowToDesktop(1)

