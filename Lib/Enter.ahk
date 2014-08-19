SetOption(Option1 = "",Option2 = "", Option3 = "") 
{
	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
	} else if (Option2 == LastItemScanned AND Option3) {
		PrintOption = %Option3%
	} else if Option1 {
		PrintOption = %Option1%	
	} 
	LastItemScanned = %PrintOption%
	Return %PrintOption%
}

SetCondition(Option1 = "",Option2 = "", Option3 = "") 
{
	If (Option1 == LastConditionScanned AND Option2)
	{
		PrintOption = %Option2%
	} else if (Option2 == LastConditionScanned AND Option3) {
		PrintOption = %Option3%
	} else if Option1 {
		PrintOption = %Option1%	
	} 
	LastConditionScanned = %PrintOption%
	Return %PrintOption%
}


Enter_Product(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Product(Option)
}

Enter_Win8(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec12", Option)
}



Enter_ProductLineProduct(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_ProductLineProduct(Option)
}

Enter_ProductLineCondition(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_ProductLineCondition(Option)
}

Enter_ProductLineQty(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_TextByID("addProductLineQTY", Option)
}

Enter_ProductLine(Location = "")
{
	FocusIMS()
	Insert_LocationAndEnterOrderLine(Location)
	WaitForIMSLoad()
}



Enter_OrderLine(Location = "")
{
	FocusIMS()
	Insert_LocationAndEnterOrderLine(Location)
	WaitForPrint()
	WaitForIMSLoad()
}


Enter_Webcam()
{
	FocusIMS()
	Insert_Test("test21")
}

Enter_Display()
{
	FocusIMS()
	Insert_Test("test32")
}
Enter_LCD()
{
	FocusIMS()
	Insert_Test("test28")
}



Enter_Notes(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2,Option3)
	Insert_TextByName("spec15",Option)
}

Enter_Save()
{
	FocusIMS()
	Insert_SaveAsset()
	WaitForIMSLoad("True")
	LastConditionScanned =
}	
		
Enter_Condition(Option1 = "", Option2 = "", Option3 = "")
{
	FocusIMS()
	Option := SetCondition(Option1,Option2,Option3)
	Insert_Condition(Option)
}

Enter_CPUType(Option1 = "",Option2 = "", Option3 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2,Option3)
	Insert_CPUType(Option)
}
		
Enter_ScreenSize(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Dropdown("spec43",Option)
}		

Enter_CPUSpeed(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_TextByName("spec5",Option)
}
		
;Would like to use.
Enter_COA(Option1 = "", Option2 = "", Option3 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2, Option3)
	Insert_Dropdown("spec41",Option)
}
	
;Would like to use.
Enter_HDDCaddy(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec24", Option)
}

;Would like to use.
Enter_Battery(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec38", Option)
}				
				
;Not Currently Used.
Enter_RAM(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Dropdown("spec37",Option)
}

	
Enter_Optical(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec39",Option)
}


;Not Currently Used.
Enter_USB(Option1 = "", Option2 = "")
{	
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_TextByName("spec27",Option)
}

;Not Currently Used.
Enter_HDMI(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec28", Option)
}

;Not Currently Used.	
Enter_MemoryCard(Option1 = "", Option2 = "")
{	
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec29", Option)
}

;Not Currently Used.
Enter_OS(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec18", Option)
}

;Not Currently Used.
Enter_HDDAdapter(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec25", Option)
}

;Not Currently Used.
Enter_Adapter(Option1 = "", Option2 = "")
{
	FocusIMS()
	Option := SetOption(Option1,Option2)
	Insert_Checkbox("spec11", Option)
}