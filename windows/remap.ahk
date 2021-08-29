; AutoHotkey remappings


;;;; quick symbol reference:
;; ^ = Ctrl, ! = Alt, 
;; # = Win, + = Shift, 
;; < = left key of pair, > = right key of pair



;;;;;;;;
; thanks to https://autohotkey.com/board/topic/60675-osx-style-command-keys-in-windows
;
; Using arrows to move cursor by word
<!Left::Send {ctrl down}{Left}{ctrl up}
<!Right::Send {ctrl down}{Right}{ctrl up}

; Navigation using of bigger chunks (Skip to start/end of line/paragraph/document)
^Left::Send {Home}
^Right::Send {End}
!Up::Send {ctrl down}{Up}{ctrl up}
!Down::Send {ctrl down}{Down}{ctrl up}

;; Disable Ctrl + Up and Ctrl + Down matching of Mac behavior, because I prefer regular Ctrl + UP and Down on Windows, esp. for Dynalist and others that use Ctrl+Up/Down for moving items in a list.
;^Up::Send {Lctrl down}{Home}{Lctrl up}
;^Down::Send {Lctrl down}{End}{Lctrl up}


; Selection (uses a combination of the above with shift)
<!+Left::Send {ctrl down}{shift down}{Left}{shift up}{ctrl up}
<!+Right::Send {ctrl down}{shift down}{Right}{shift up}{ctrl up}
^+Left::Send {shift down}{Home}}{shift up}
^+Right::Send {shift down}{End}}{shift up}
!+Up::Send {ctrl down}{shift down}{Up}}{shift up}{ctrl up}
!+Down::Send {ctrl down}{shift down}{Down}}{shift up}{ctrl up}
^+Up::Send {Lctrl down}{shift down}{Home}}{shift up}{Lctrl up}
^+Down::Send {Lctrl down}{shift down}{End}}{shift up}{Lctrl up}





; this has to come before remapping caps lock in order to work
; 
+CapsLock::CapsLock

; make capslock do control
CapsLock::Ctrl



;; disabling these as I'm using PowerToys to do it now; it's more reliable for switching out modifier keys
; Alt is Ctrl
;Alt::Ctrl
; LWin is Alt
;LWin::Alt

; Ctrl is LWin
;LCtrl::LWin
; RCtrl is Alt
;RCtrl::Alt


; Ctrl-Space for Windows menu (Alt-space with remap)
; disabling for now [[2021-08-05 Thursday]] to try PowerToys Run instead ... can still use regular Windows key
;^Space::Send ^{Esc}

; and provide a way to Ctrl-Tab as well
; disabling for now, doesn't seem to be needed anymore
;!Tab::^Tab

; Restore default Alt-Tab behavior, but now alt is remapped to Ctrl ... 
;; #todo:2020-03-28 this results in having to press enter or mouse click on destination window ... the alt-tab window switcher stays up after letting go of alt, instead of going away, as normal
;; may find some solution here: https://www.autohotkey.com/docs/Hotkeys.htm#AltTabDetail -- 
; disabling for now, doesn't seem to be needed anymore
;^Tab::!Tab
;<^Tab::AltTab
;<!Tab::AltTab


;; Trying another way ...
; REPLACES ALT-TAB APPLICATION SWITCHING WITH OSX CMD-TAB
;<^Tab::AltTab
;!Tab::return




;;; media keys
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


;;   (then remap on mac as well so it matches, so I can use Cmd-Left and -Right to match Ctrl-Left and -Right on non-Mac, to jump between words?)


; ### text expansions
::hb::haribol

; hour:minute
::hm::
SendInput %A_Hour%:%A_Min%
return

; hour minute minimal (no colon)
;::hmm::
;SendInput %A_Hour%%A_Min%
;return

::ymdm::
SendInput %A_YYYY%%A_MM%%A_DD%
return

::ymd::
SendInput %A_YYYY%-%A_MM%-%A_DD%
return

::ymdd::
SendInput %A_YYYY%-%A_MM%-%A_DD% %A_DDDD%
return


::ymhm::
SendInput %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%
return

::ymhmm::
SendInput %A_YYYY%%A_MM%%A_DD%%A_Hour%%A_Min%
return

::zkidm::
SendInput %A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%
return

::zkidf::
SendInput zkid: %A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%
return

::zkidt::
; old way: 
;SendInput <{!}-- `nzkid: %A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min% `n-->

; going to use YAML frontmatter separators now instead of HTML comments
SendInput ---`nzkid: %A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min% `n---
return
