;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Written by Philipp Otto, Germany
; 	Edits to be more vim-like by crazybilly, http://jaket.is-a-geek.com/blog
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetCapsLockState, AlwaysOff


; l = right
CapsLock & l::
       if getkeystate("alt") = 0
               Send,{Right}
       else
               Send,+{Right}
return


; h = Left 
CapsLock & h::
       if getkeystate("alt") = 0
               Send,{Left}
       else
               Send,+{Left}
return


; j = Down
CapsLock & j::
       if getkeystate("alt") = 0
               Send,{Down}
       else
               Send,+{Down}
return


; k = Up
CapsLock & k::
       if getkeystate("alt") = 0
               Send,{Up}
       else
               Send,+{Up}
return


; 0 = home
CapsLock & 0::
       if getkeystate("alt") = 0
               Send,{Home}
       else
               Send,+{Home}
return

;; gg  go to top of document
; CapsLock & gg::
;       if getkeystate("alt") = 0
;               Send,gg
;       else
;               Send,^{Home}
; return

; G  go to end of document
;CapsLock & G::
;       if getkeystate("alt") = 0
;               Send,G
;       else
;               Send,^{End}
;return

; CapsLock & BS::Send,{Del}
; CapsLock & x::Send ^x
; CapsLock & c::Send ^c
; CapsLock & v::Send ^v


; Vim style yank whole line
CapsLock & y::
 if (foo ="" || foo = 0 )
 	{
		Send {Home}
		Send +{End}
		foo = foo +1
	}
else
	{
		Send ^c
		Send {Home}
		foo := 0
	}
return

; Vim style delete whole line
CapsLock & d::
 if (foo ="" || foo = 0 )
 	{
		Send {Home}
		Send +{End}
		foo = foo +1
	}
else
	{
		Send ^x
		Send {Home}
		foo := 0
	}
return

; Vim style paste (from the clipboard)
Capslock & p::
	Send ^v
return




;Prevents CapsState-Shifting
CapsLock & Space::Send,{Space}

*Capslock::SetCapsLockState, AlwaysOff
+Capslock::SetCapsLockState, On

