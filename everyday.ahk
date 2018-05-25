
SetCapsLockState, AlwaysOff
SetTitleMatchMode 2

; --------------------------------------------
; OUTLOOK SHORTCUTS 
; --------------------------------------------

; a function to determine if you're in a particular ClassNN within a window
ControlActive(ClassNN, WinTitle) {
    ControlGetFocus, CurCon, % WinTitle
    Return (CurCon=ClassNN)
}


; in Outlook, map Delete to Archiving instead of deleting
;      but only do it when you're on the list of messages, not within a reply
#If ControlActive("OutlookGrid3", "Outlook") 	; params: ControlActive( ClassNN , WinTitle)
Delete::
    Send ^+1
#If
Return


; create a new email from anywhere
#n::
	SetTitleMatchMode 2	

	IfWinExist, jtolbert@millikin.edu - Outlook
		{
			WinActivate
			Sleep, 250
            Send !4
		} 
return


; go in today in calendar
#c::
	KeyWait LWin
	KeyWait RWin
	SetTitleMatchMode 2
	WinActivate  jtolbert@millikin.edu - Outlook
	Send ^2 
return


; go in inbox
#i::
	KeyWait LWin
	KeyWait RWin
	SetTitleMatchMode RegEx 
	WinActivate jtolbert.*Outlook
	Send ^1 
return


; paste Excel table into Outlook message
^+v::
	Send !7
	Sleep 200
	Send {Home}
	Send {Enter}
return





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


; send an actual tab character
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
	;Send {Down}
	Send {Return}
}

return

; enter default fund code stuff while creating a desgination
; ^+v::
; 
; SendInput {Tab}
; SendInput 98110
; SendInput {Tab}
; SendInput 52032 
; SendInput {Tab}
; SendInput 00
; Send {Tab}{Tab}{Tab}
; 
; return




; --------------------------------------------
; EXCEL SHORTCUTS 
; --------------------------------------------

; format as college RFC
^+y::
SetTitleMatchMode, 2
IfWinActive Excel 
{
    KeyWait LWin
    KeyWait RWin
    Send {Alt}
    Sleep, 200
    Send y2
    Sleep, 200
    Send yl
    Sleep, 500
    Send ^{Home}
}
return

; write RFC file name
^+r::
SetTitleMatchMode, 2
IfWinActive Excel 
{
    InputBox, filename, subname of file
    rfcstring = Cash-Giving-Report-
    Send {F12} 
    Send !n
    Sleep, 500
    Send %rfcstring%%filename%
    Sleep, 500
    Send {Up}
    Sleep, 500
    Send {End}
    Send {Delete}{Delete}{Delete}{Delete}
    Sleep, 500
    Send {Tab}
    Send {Down}{Home}{Enter}
}
return





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
; SetTitleMatchMode, 2
; ProgramTitle = bosa_sdm_XL9
; Settimer, CheckWindow, 1000 ;Check every second
; CheckWindow:
;   IfWinActive, ahk_class %ProgramTitle%
;   {
;     Send !r
;     Settimer, CheckWindow, Off
;   }


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

^+>::
SendInput {Space}`%>`%{Space}
return


; ^+v::
; SendInput View(
; return

; ^+!v::
; SendInput `; View(
; return


!-::
SendInput {Space}<-{Space}
return


#b::
SendInput by = 'pidm', copy = T
return


#w::
SendInput write.clip(excel = T)
return


; ^+!r::
; KeyWait Ctrl
; KeyWait Alt
; KeyWait Shift
; Sleep, 100
; Send {Esc}
; Sleep, 100
; Send i
; Sleep, 100
; SendInput {#}{Space}libraries ---------------------------------------{Enter}{Enter}
; SendInput library(muadc); library(dplyr); library(tidyr); {Enter}
; SendInput library(stringr); library(lubridate); library(magrittr); {Enter}
; SendInput {Enter}
; SendInput {Enter}
; SendInput {#}{Space}data --------------------------------------------{Enter}
; Sleep, 100
; SendInput {Enter}
; SendInput initcommitsdb();
; SendInput {Enter}
; SendInput {Enter}
;
; return
