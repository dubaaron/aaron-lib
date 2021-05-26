

; Ctrl-Space for Windows menu (Alt-space with remap)
^Space::Send ^{Esc}

; Restore default Alt-Tab behavior
^Tab::!Tab
; and provide a way to Ctrl-Tab as well
!Tab::^Tab


;; Emulate Mac OS switching windows of current program
^`::
	; TODO: add a popup GUI with list of windows and highlight one being switched to; or even just a splash something to show something is happening
	CurrentWindowId := WinExist("A") 
	CurrentExe := ""
	WinGet, CurrentExe, ProcessName
	; WinSet, Bottom,, A
	WinActivateBottom, ahk_exe %CurrentExe%

Return
