; I don't know if these are used, but I think they are.
EnterCompleteProduct(ExternalID,SN,Product="")
{
	FocusIMS()
	If(Product)
		Enter_Product(Product)
	Insert_TextByID("addOrderlineSN", SN)
	Enter_OrderLine()	
	Insert_TextByID("editOrderlineExternalAsset", ExternalID)
	WaitForIMSLoad()
	Enter_Save("Pass")
}

EnterCompleteProductAndConditions(ExternalID,SN, Cond, Restore,Product="",Notes = "")
{
	FocusIMS()
	If(Product)
		Enter_Product(Product)
	Insert_TextByID("addOrderlineSN", SN)
	Enter_OrderLine()	
	Insert_TextByID("editOrderlineExternalAsset", ExternalID)
	WaitForIMSLoad()

	StringReplace, Notes, Notes,`n,\n,All	

	Insert_AdditionalText("spec15",Notes)

	EnterConditionAndSave(Cond, Restore)
}








::HDDLoop::
EnterHDDLoop()
return

#IfWinActive Input Hard Drive
Enter:: Send {Enter}{Tab}{Enter}
NumpadEnter:: Send {Enter}{Tab}{Enter}
#IfWinActive





EnterHDDLoop(Size = "", Product="")
{
;	FocusIMS()
	Global 25INHDDs
	Global 35INHDDs
	Gui, Destroy
	Gui, Add, Text,, Enter External Asset Number
	Gui, Add, Edit, vEAN, 
	Gui, Add, Text,, Enter Serial Number
	Gui, Add, Edit, vSN, 
	Gui, Add, Text,, Enter Hard Drive Type
	Gui, Add, Edit, vHType, %Product%
	Gui, Add, Button, GSubmit, Submit
	Gui, Add, Text,, Enter Hard Drive Size
	Gui, Add, Edit, vHSize, %Size%
	Gui, Add, Button, GswapConnector, Change Connector
	Gui, Show,, Input Hard Drive
	

} Submit:
	
	Gui, Submit

	If(!SN) {
		
		Exit
	}

	If(HSize == "2.5")	
		HDDTypes = %25INHDDs%
	Else If(HSize == "3.5")	
		HDDTypes = %35INHDDs%
	Else {
			
		Gui, Show
		WinActivate, Input Hard Drive
		return
	}

	Product := List_LookupID(HDDTypes,HType)

;	If(HType == "None")
;		Product:="None"
	If(!Product AND HType)
	{
			
		Gui, Show
		Send +{Tab}
		return
	}
	If(!HType)
		Product =
	WinWaitNotActive, Input Hard Drive
	EnterCompleteProduct(EAN,SN,Product)
	
	EnterHDDLoop(HSize,HType)
return

swapConnector: 
FocusIMS()
swapHDDConnector()
WinWaitActive IMS
WinWaitNotActive IMS (Loading)
WinActivate Input Hard Drive
Send {Tab}
return

swapHDDFormFactor() {
	RunJavascript("swapHDDFormFactor();")
}

swapHDDConnector() {
	RunJavascript("swapHDDConnector();")
}