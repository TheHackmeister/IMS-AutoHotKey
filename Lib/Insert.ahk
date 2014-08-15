Insert_Product(Product)
{
	PID := List_ProductIDLookup(Product)

	JSText = ahkInsertProduct('%PID%', '%Product%');
	RunJavascript(JSText)	
}

;Remove?
Insert_LocationAndEnterProductLine(LocationInput = "")
{
	Global Location

	If(LocationInput)
		Location := LocationInput
	
	If(!Location)
	{
		InputBox, LocationInput, Location number,Enter your location number,,210,120
		Location := LocationInput
	}
	
	If(!Location)
	{
		Alert("You didn't enter any location. Exiting script.")
		exit
	}

	JSText = ahkInsertLocationAndEnterOrderLine("%Location%");
	RunJavaScript(JSText)
}
	
Insert_LocationAndEnterOrderLine(LocationInput = "")
{
	Global Location

	If(LocationInput)
		Location := LocationInput
	
	If(!Location)
	{
		InputBox, LocationInput, Location number,Enter your location number,,210,120
		Location := LocationInput
	}
	
	If(!Location)
	{
		Alert("You didn't enter any location. Exiting script.")
		exit
	}

	JSText = ahkInsertLocationAndEnterOrderLine("%Location%");
	RunJavaScript(JSText)
}
		


Insert_CPUType(CPU)
{
	CPUID := List_CPUIDLookup(CPU)
	JSText = ahkInsertCPUType('%CPUID%', '%CPU%');	
	RunJavascript(JSText)
}

Insert_Radio(ID, Setting)
{
	If(Setting == "Yes" OR Setting == "Pass")
	{
		Setting = 0
	} else if (Setting == "No" OR Setting == "Fail") {
		Setting = 1
	} 

	JSText = $('input:radio[name="%ID%"]:eq(%Setting%)').attr('checked', "checked");
	RunJavaScript(JSText)
}
	
Insert_Checkbox(ID, Setting)
{
	If(Setting == "Yes")
	{
		Setting = true
	} else if (Setting == "No") {
		Setting = false
	} 
	;Consider doing prop('checked', setting). It will allow me to set what I want. Unneeded right now.
	JSText = $('input:checkbox[name="%ID%"]').click();	
	RunJavaScript(JSText)
}		

Insert_TextByID(ID,String)
{
	JSText = $('#%ID%').val("%String%");
	RunJavaScript(JSText)
}

Insert_TextByName(ID, String)
{
	JSText = $('[name="%ID%"]').val("%String%");
	RunJavaScript(JSText)
}

Insert_Condition(cond)
{
	JSText = ahkInsertCondition("%cond%");
	RunJavaScript(JSText)
}		

Insert_SaveAsset()
{
	RunJavaScript("ahkSaveAsset();")
}		



Insert_ProductLineCondition(cond)
{
	JSText = ahkInsertProductLineCondition("%cond%");
	RunJavaScript(JSText)
	Sleep, 500
	WaitForIMSLoad()
}		
					
Insert_ProductLineProduct(Product)
{
	PID := List_ProductIDLookup(Product)

	JSText = ahkInsertProductLineProduct("%pid%", "%Product%");
	RunJavaScript(JSText)
	Sleep, 500
	WaitForIMSLoad()
}		
	

						
;Currently unused.
Insert_AdditionalText(ID, String)
{
	JSText = 
	(	
		document.getElementsByName("%ID%")[0].value = document.getElementsByName("%ID%")[0].value + "%String%\n";
	)
	RunJavaScript(JSText)
}	

;Currently unused.	
Insert_Dropdown(Name, Value)
{
	global DropDownList
	VID := List_LookupID(DropDownList, Value)

	JSText =
	(
document.getElementsByName('%Name%')[0].value = '%VID%';
	)
	RunJavaScript(JSText)
}