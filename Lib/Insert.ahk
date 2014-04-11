Insert_Product(Product)
{
	PID := List_ProductIDLookup(Product)

	JSText = ahkInsertProduct('%PID%', '%Product%');
	RunJavascript(JSText)	
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

	JSText = $('input:checkbox[name="%ID%"]').prop('checked', %Setting%)	
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
	JSText = saveAsset(getEditAssetID());
	RunJavaScript(JSText)
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
document.getElementsByName('%Name%')[0].value = %VID%
	)
	RunJavaScript(JSText)
}