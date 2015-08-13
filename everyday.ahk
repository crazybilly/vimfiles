
SetCapsLockState, AlwaysOff

; --------------------------------------------
; GROUPWISE SHORTCUTS 
; --------------------------------------------

; go in inbox
#i::
	KeyWait LWin
	KeyWait RWin
	SetTitleMatchMode 2
	WinActivate Novell 
	Send !e
	Sleep, 150
	Send r
	Sleep, 150
	SendInput Mailbox
	Sleep, 150
	Send {Enter}
return

; go in today in calendar
#c::
	KeyWait LWin
	KeyWait RWin
	SetTitleMatchMode 2
	WinActivate Novell 
	Send !e
	Send r
	Sleep, 100
	SendInput Calendar
	Sleep, 50
	Send {Enter}
	Sleep, 50
	Send, ^g
return



;reply to email
#r::
Send {Alt}ar{enter}
return

; create a new email
^+m::
	SetTitleMatchMode 2	

	IfWinActive, RStudio
	{
		SendInput {Space}`%>`%{Space}
	} 

	IfWinNotActive, RStudio
	{
		IfWinExist, Novell GroupWise
		{
			WinActivate
			Sleep, 500
			Send ^m
		} 
	}
	return



; raise flashing windows
;Gui +LastFound
;hWnd := WinExist() , DllCall( "RegisterShellHookWindow", UInt,hWnd )
;MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
;OnMessage( MsgNum, "ShellMessage" )
;Return ;                                                 // End of Auto-Execute Section //
;ShellMessage( wParam,lParam ) {
;  If ( wParam = 0x8006 ) ;  0x8006 is 32774 as shown in Spy!
;    {
;      WinActivate, ahk_id %lParam%
;    }
;}
DetectHiddenWindows, Off
; Register shell hook to detect flashing windows.
DllCall("RegisterShellHookWindow", "uint", Script_Hwnd)
OnMessage(DllCall("RegisterWindowMessage", "str", "SHELLHOOK"), "ShellEvent")
;...
ShellEvent(wParam, lParam) {
    if (wParam = 0x8006) ; HSHELL_FLASH
    {   ; lParam contains the ID of the window which flashed:
        WinActivate, ahk_id %lParam%
    }
}






; --------------------------------------------
; BANNER SHORTCUTS 
; --------------------------------------------

; double zero key
^NumPad0::
Send 00
return

;go to next form in a QuickFlow
#q::
KeyWait LWin
KeyWait RWin
Send ^q
Sleep, 50
Send ^{PgDn}
return


; move from top name block into the data blocks
; 	ie. ctrl+page down
^+j::
Send ^{PgDn}
return

; move from data blocks back up to the top
; 	ie. shift+F7
^+k::
Send +{F7}
return

; --------------------------------------------
; MISC and VIM SHORTCUTS 
; --------------------------------------------

; get properties quickly
^AppsKey::
Send {AppsKey}
Send r
return

; non-greedy wildcard for vim
#8::
KeyWait LWin
KeyWait RWin
Send \{{}
Send -{}}
return

; send and actual tab character
#Tab::
Send ^q
Send {Tab}
return



; in MapPoint, map unfound addresses to their zip code
#m::
KeyWait LWin
KeyWait RWin
InputBox, unmapped,,numer of unmapped addresses

Loop, %unmapped%
{
	Send {Down}
	Send {Return}
}

return

; --------------------------------------------
; EXCEL SHORTCUTS 
; --------------------------------------------

; select visible cells in Excel
#v::
KeyWait LWin
KeyWait RWin
Send !h
Send fdsy
Send {Enter}
return

; hide columns in Excel
#u::
KeyWait LWin
KeyWait RWin
Send  !h
Send ouc
Send {Enter}
return

; write a vlookup in Excel
#o::
KeyWait LWin
KeyWait RWin
InputBox, table,,lookup table
InputBox, column,,desired column
SendInput {Raw}=
Send VLOOKUP(a2,%table%,%column%,FALSE)
Send {Enter}
return

; automatically close the personal.xlsb is in use dialog
SetTitleMatchMode, 2
ProgramTitle = bosa_sdm_XL9
Settimer, CheckWindow, 1000 ;Check every second
CheckWindow:
  IfWinActive, ahk_class %ProgramTitle%
  {
    Send !r
    Settimer, CheckWindow, Off
  }


;; write TRUE
#t::
SendInput TRUE
Send {Enter}
return

;; write FALSE 
#f::
SendInput FALSE
Send {Enter}
return




; note - the following is an excel macro shortcut in PERSONAL.XLSB
;	ahk doesn't watch for this one
; created a named table in Excel
; ^+l:: 
; calls lib_createTable()
; return


; --------------------------------------------
; QLIKVIEW SHORTCUTS 
; --------------------------------------------

; hotkey to close the edit expression dialog
; #IfWinActive Edit Expression
; ^+o::
; Send 



; --------------------------------------------
; R SHORTCUTS 
; --------------------------------------------

^+-::
SendInput {Space}<-{Space}
return

^+>::
SendInput {Space}`%>`%{Space}
return



^+v::
SendInput View(
return

^+!v::
SendInput `; View(
return


!-::
SendInput {Space}<-{Space}
return


 ^+!r::
 KeyWait Ctrl
 KeyWait Alt
 KeyWait Shift
 Sleep, 100
 Send {Esc}
 Sleep, 100
 Send i
 Sleep, 100
 SendInput {#}{Space}libraries ---------------------------------------{Enter}{Enter}
 SendInput library(muadc); library(dplyr); library(tidyr); {Enter}
 SendInput library(stringr); library(lubridate); library(magrittr); {Enter}
 SendInput {Enter}
 SendInput {Enter}
 SendInput {#}{Space}data --------------------------------------------{Enter}
 Sleep, 100
 SendInput {Enter}
 SendInput initcommitsdb();
 SendInput {Enter}
 SendInput {Enter}

 return
