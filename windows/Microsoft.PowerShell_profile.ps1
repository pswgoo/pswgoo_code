set-alias nt "C:\Program Files (x86)\Notepad++\notepad++.exe"

set-alias ll ListByTime

function ListByTime ($s) {
	ls $s | sort lastwritetime
}

#set git shell 
.(Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")
$env:TERM = ""
