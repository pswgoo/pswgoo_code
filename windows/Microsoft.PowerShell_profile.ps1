set-alias nt "C:\Program Files (x86)\Notepad++\notepad++.exe"

set-alias ll ListByTime

function ListByTime ($s) {
	ls $s | sort lastwritetime
}

#set git shell 
C:\Users\pswgoo\AppData\Local\GitHub\shell.ps1