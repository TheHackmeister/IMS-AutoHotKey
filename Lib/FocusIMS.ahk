FocusIMS()
{
	GroupAdd, IMS, IMS - Google Chrome
	GroupAdd, IMSLoading, IMS (Loading) - Google Chrome

	
	If (WinActive("ahk_group IMS") OR WinActive("ahk_group IMSLoading"))
	{
		return True
	} else {
		IfWinExist, ahk_group IMS
		{
			WinActivate
			WinWait ahk_group IMS
			return
		}		
		Alert("This script could not locate an IMS window. Please make sure that the IMS page is the active tab in your browser or that you are using Chrome.")
		exit
	}
}