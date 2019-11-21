; AutoHotkey remappings

; this has to come before remapping caps lock in order to work
+CapsLock::CapsLock 

; make capslock do control
CapsLock::Ctrl

; Alt is Ctrl
Alt::Ctrl
; LWin is Alt
LWin::Alt

; Ctrl is LWin
LCtrl::LWin
; RCtrl is Alt
RCtrl::Alt


; Ctrl-Space for Windows menu (Alt-space with remap)
^Space::Send ^{Esc}

; and provide a way to Ctrl-Tab as well
!Tab::^Tab
; Restore default Alt-Tab behavior
^Tab::!Tab

^F2::Send {Media_Play_Pause}
^F9::Send {Volume_Up}
^F8::Send {Volume_Down}
^F7::Send {Volume_Mute}

; Try to make Alt-F4 (close window) easier to hit with Ctrl remapped to alt
^F4::!F4

;; Emulate Mac OS switching windows of current program
^`::
	; #PgDn::    ; Next window
	; WinGetClass, ActiveClass, A
	; WinActivate, ahk_class %ActiveClass%

	CurrentWindowId := WinExist("A") 
	CurrentExe := ""
	WinGet, CurrentExe, ProcessName
	; WinSet, Bottom,, A
	WinActivateBottom, ahk_exe %CurrentExe%

	; WindowsOfCurrentExe := ""
	; WinGet, WindowsOfCurrentExe, List, ahk_exe %CurrentExe%

	; index := 1
	; Loop % WindowsOfCurrentExe {
	; 	; MsgBox, % index
	; 	If (CurrentWindowId = WindowsOfCurrentExe%index%) {
	; 		CurrentWindowNumber := index
	; 	}
	; 	index++
	; }

	; NextWindowNumber := CurrentWindowNumber + 1
	; WindowIdToActivate := WindowsOfCurrentExe%NextWindowNumber%
	; ; ListVars
	; ; Pause
	; ; MsgBox, About to activate %WindowIdToActivate%
	; ; TitleOfWindowToActivate := ""
	; ; WinGetTitle, TitleOfWindowToActivate, ahk_id %WindowIdToActivate%
	; ; MsgBox % WinExist("ahk_id " . WindowIdToActivate)
	; ; MsgBox, title should be %TitleOfWindowToActivate%
	; ListVars
	; WinActivate, ahk_id %WindowIdToActivate%
	; ; WinMaximize, ahk_id %WindowIdToActivate%
	; ; GroupAdd % "MyWindows", ahk_exe CurrentExe
	; ; GroupActivate % "MyWindows"
	; ; WinActivate, ahk_exe %CurrentExe%
	; ; MsgBox % "Haribol! Curent window ID " . CurrentWindowId
Return



;; TODO: map alt-f8, alt-f9 to vol+ and vol-  (alt-f7: mute)
;; - map LWin(remapped to alt)-Left and -Right to Home and End, for consistency with Mac
;;   (then remap on mac as well so it matches, so I can use Cmd-Left and -Right to match Ctrl-Left and -Right on non-Mac)


