WaitForPrint()
{
	GroupAdd, IMSPrint, Print Ready - Google Chrome
	WinWaitActive, ahk_group IMSPrint
	While(WinActive("ahk_group IMSPrint"))
	{
		Send {Enter}
		Sleep, 100
	}
	WinWaitNotActive, ahk_group IMSPrint
}