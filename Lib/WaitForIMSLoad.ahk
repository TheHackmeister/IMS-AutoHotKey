WaitForIMSLoad(Expected="")
{
	GroupAdd, IMSLoading, IMS (Loading) - Google Chrome
	GroupAdd, IMS, IMS - Google Chrome
	FocusIMS()
	If(Expected)
		WinWaitActive, ahk_group IMSLoading
	WinWaitActive, ahk_group IMS
}
