
SetCapsLockState, AlwaysOff
SetTitleMatchMode 2

; Desktop List View
#1::
{
    DesktopToggle := !DesktopToggle
    ToggleDesktopView( DesktopToggle )
}
Return
 
ToggleDesktopView( _Toggle )
{
    LV_VIEW_ICON      := 0 ; Default
    LV_VIEW_DETAILS   := 1 ; Flat font and columns don't work right.
    LV_VIEW_SMALLICON := 2 ; Correct font, columns are okay.
    LV_VIEW_LIST      := 3 ; Flat font and columns are too far apart.
    LV_VIEW_TILE      := 4 ; Flat font, columns are okay, and there is extra text detail.
    LVM_SETVIEW       := 0x108E
    LVM_GETVIEW       := 0x108F
    If ( _Toggle ) ; LV_VIEW_SMALLICON & LV_VIEW_TILE work the best.
    {
        ControlGet, myDesktopWindow, HWND,, SysListView321, ahk_class Progman
        SendMessage, % LVM_SETVIEW, % LV_VIEW_SMALLICON, 0, , % "ahk_id " . myDesktopWindow

    }
    Else ; Set back to default.
    {
        ControlGet, myDesktopWindow, HWND,, SysListView321, ahk_class Progman
        SendMessage, % LVM_SETVIEW, % LV_VIEW_ICON, 0, , % "ahk_id " . myDesktopWindow
    }
}


; WinSplit Tiling Keys
;   gotta work around Windows' hotkeys 
;   (no clue what win+arrow is SUPPOSED to do)
#Left::
Send #{Numpad4}
Return

#Right::
Send #{Numpad6}
Return

#Up::
Send #{Numpad8}
Return

#Down::
Send #{Numpad2}
Return



; Fake PgUp and PgDn
^Up::
Send {PgUp}
return

^Down::
Send {PgDn}
return




; +F9::
;   Send {Media_Play_Pause}
; return
; 
; +F10::
;   Send {Volume_Mute}
; return
; 
; +F11::
;   Send {Volume_Down}
; return
; 
; +F12::
;   Send {Volume_Up}
; return
; 
; Launch_Media::
;    IfWinNotExist, Spotify
;    {
; 	Run, C:\Users\jtolbert\AppData\Roaming\Spotify\Spotify.exe
;    } else
;    {
; 	WinActivate Spotify
;    }
; return
; 
; ; Launch_mail
; 
; Browser_home::
; 	WinActivate Chrome
; return
; 
; Launch_App2::
; 	WinActivate Rstudio
; return
; 



; --------------------------------------------
; OUTLOOK SHORTCUTS 
; --------------------------------------------

; ; a function to determine if you're in a particular ClassNN within a window
; ControlActive(ClassNN, WinTitle) {
;     ControlGetFocus, CurCon, % WinTitle
;     Return (CurCon=ClassNN)
; }
; 
; 
; ; in Outlook, map Delete to Archiving instead of deleting
; ;      but only do it when you're on the list of messages, not within a reply
; ; #If ControlActive("OutlookGrid3", "Outlook") 	; params: ControlActive( ClassNN , WinTitle)
; ; Delete::
; ;     Send ^+1
; ; #If
; ; Return
; 
; 
; ; create a new email from anywhere
; #n::
; 	SetTitleMatchMode 2	
; 
; 	IfWinExist, jtolbert@millikin.edu - Outlook
; 		{
; 			WinActivate
; 			Sleep, 250
;             Send ^1
; 			Sleep, 250
;             Send !5
; 		} 
; return
; 
; 
; ; go in today in calendar
; #c::
; 	KeyWait LWin
; 	KeyWait RWin
; 	SetTitleMatchMode 2
; 	WinActivate  jtolbert@millikin.edu - Outlook
; 	Send ^2 
; return


; go in inbox
#i::
chrome := "- Google Chrome"
found := "false"
tabSearch := "jaketolbert@berkeley.edu"
curWinNum := 0
    
SetTitleMatchMode, 2
    
WinGet, numOfChrome, Count, %chrome% ; Get the number of chrome windows
    
WinActivateBottom, %chrome% ; Activate the least recent window
    
WinWaitActive %chrome% ; Wait until the window is active
SendInput ^1   ; go to the first tab b/c thats where I like to keep it
Sleep, 200
    
ControlFocus, Chrome_RenderWidgetHostHWND1 ; Set the focus to tab control ???
    
; Loop until all windows are tried, or until we find it
while (curWinNum < numOfChrome and found = "false") { 
   WinGetTitle, firstTabTitle, A ; The initial tab title
   title := firstTabTitle
   Loop
        {
            if(InStr(title, tabSearch)>0){
                found := "true"
                break
            }
            Send {Ctrl down}{Tab}{Ctrl up}
            Sleep, 50
            WinGetTitle, title, A  ;get active window title
            if(title = firstTabTitle){
                break
            }
        }
        WinActivateBottom, %chrome%
        curWinNum := curWinNum + 1
    }
    
    ; If we did not find it, start it
    if(found = "false"){
        Run "http://bmail.berkeley.edu/"
    }
    
return

;#i::
;	KeyWait LWin
;	KeyWait RWin
;	SetTitleMatchMode RegEx 
;	WinActivate jtolbert.*Outlook
;	Send ^1 
;return


; paste Excel table into Outlook message
^+v::
	Send !7
	Sleep 500
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

; send .Rproj for searching
#y::
Send Rproj
return


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
; ^+m::
 
;  SendInput {Tab}
;  Sleep, 350
;  SendInput 98110
;  Sleep, 350
;  SendInput {Tab}
;  Sleep, 350
;  SendInput 52032 
;  Sleep, 350
;  SendInput {Tab}
;  Sleep, 350
;  SendInput 00
; Send {Tab}{Tab}{Tab}
; 
;  return




; --------------------------------------------
; EXCEL SHORTCUTS 
; --------------------------------------------

; format as college RFC
#IfWinActive, ahk_class XLMAIN
^+y::
SetTitleMatchMode, 2

    KeyWait LWin
    KeyWait RWin
    Send {Alt}
    Sleep, 200
    Send y2
    Sleep, 200
    Send yl
    Sleep, 500
    Send ^{Home}
return

; write RFC file name
#IfWinActive, ahk_class XLMAIN
^+r::
SetTitleMatchMode, 2
    InputBox, filename, subname of file
    rfcstring = Cash-Giving-Report-
    Send {F12} 
    Send !n
    Sleep, 750
    Send %rfcstring%%filename%
    Sleep, 500
    Send {Up}
    Sleep, 500
    Send {End}
    Send {Delete}{Delete}{Delete}{Delete}
    Sleep, 500
    Send {Tab}
    Send {Down}{Home}{Enter}
return



#IfWinActive

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
