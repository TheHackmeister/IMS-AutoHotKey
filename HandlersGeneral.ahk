EnterProduct(PText)
{
BlockOn()
	AmIIMS()
	InsertProduct(PText)
	
BlockOff()
}

EnterOrderLine(Location = "")
{
BlockOn()
	AmIIMS()
	ResetCurrentInserts()
	InsertLocation(Location)
	PrintLabel()
BlockOff()
	WaitForIMSLoad()
BlockOff()
}

EnterNotes(Option1 = "", Option2 = "")
{
BlockOn()
	AmIIMS()
	global CurrentInsertNotes
	global LastItemScanned
	global LastItemTypeScanned

	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
	} else if Option1 {
		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		
		;PrintOption = %DefaultInsertNotes%
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = Notes
	CurrentInsertNotes = %PrintOption%

	InsertText("spec15",PrintOption)
BlockOff()
}

EnterCondition(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCondition
	PrintOption = ""
	;;;Tracking
	
	If Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		

		If(!CurrentInsertCondition)
		{
			PrintOption = Fail
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = Condition
	CurrentInsertCondition = %PrintOption%

	;;;Actions

	If (PrintOption)
	{
		InsertRadio("test2", PrintOption)
	}
}


EnterSave(Option1 = "", Option2 = "")
{
BlockOn()
	AmIIMS()
	PrintOption = ""
	;	global CurrentInsertLockStatus

	;;;Tracking

;	If (Option1 == LastItemScanned AND Option2)
;	{
;		PrintOption = %Option2%
;		
;	} else if Option1 {
;		PrintOption = %Option1%	
;	} else {
;	;;; Algorithm for guess goes here. 		
;		;Need to check for Condition / lock missmatch.
;		PrintOption = Lock
;	}
;	LastItemScanned = %PrintOption%
;	LastItemTypeScanned = Save
;	CurrentInsertLockStatus = %PrintOption%

	;;;Actions


	EnterCondition(Option1)
	SaveAsset()
	WaitForIMSLoad("True")
;	PlaceMouse("addAssetProductSearchText")
BlockOff()
}

EnterCompleteProduct(ExternalID,SN,Product="")
{
	AmIIMS()
	If(Product)
		EnterProduct(Product)
	InsertTextByID("addOrderlineSN", SN)
	EnterOrderLine()	
	InsertTextByID("editOrderlineExternalAsset", ExternalID)
	WaitForIMSLoad()
	EnterSave("Pass")
}

EnterHDDLoop(Size = "", Product="")
{
;	AmIIMS()
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
	BlockOn()
	Gui, Submit

	If(!SN) {
		BlockOff()
		Exit
	}

	If(HSize == "2.5")	
		HDDTypes = %25INHDDs%
	Else If(HSize == "3.5")	
		HDDTypes = %35INHDDs%
	Else {
		BlockOff()	
		Gui, Show
		WinActivate, Input Hard Drive
		return
	}

	Product := ListLookupID(HDDTypes,HType)

;	If(HType == "None")
;		Product:="None"
	If(!Product AND HType)
	{
		BlockOff()	
		Gui, Show
		Send +{Tab}
		return
	}
	If(!HType)
		Product =
	WinWaitNotActive, Input Hard Drive
	EnterCompleteProduct(EAN,SN,Product)
	BlockOff()
	EnterHDDLoop(HSize,HType)
return

swapConnector: 
AmIIMS()
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

