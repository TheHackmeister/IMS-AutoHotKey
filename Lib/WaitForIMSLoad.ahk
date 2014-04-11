WaitForIMSLoad(Expected="")
{
	FocusIMS()
	If(Expected)
		WinWait, ahk_group IMSLoading
	WinWaitActive, ahk_group IMS
}
