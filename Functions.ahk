;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Input;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
InsertProduct(Product)
{
	PID := ProductIDLookup(Product)

	JSText = 
	( 
document.getElementById("addOrderlineSN").focus();	
var temp = document.createElement('div');
temp.innerHTML = "%Product%";
goods_receipt_addAssetSelectProduct('%PID%', temp);
	)
	
	RunJavascript(JSText)	
}

InsertLocation(LocationInput = "")
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
;Broken. Should use goods_receipt_addLine, but I don't know how to get the needed order number.
	JSText = 
	(
document.getElementById("addOrderlineLocation").value = "%Location%"; 
goods_receipt_addLine('');
addOrderLine();
	)
	BlockOff()
	RunJavaScript(JSText)
}

InsertCPU(CPU)
{
	CPUID := CPUIDLookup(CPU)


	JSText = 
	( 
document.getElementById("spec5").focus();	
var e = document.createElement("div");
e.innerHTML = '%CPU%';
selectOrderlineSpec('%CPUID%', 6, e, getEditAssetID());
	)
	RunJavascript(JSText)
}

InsertRadio(ID, Setting)
{
	If(Setting == "Yes" OR Settin		g == "Pass")
	{
		Setting = 0
	} else if (Setting == "No" OR Setting == "Fail") {
		Setting = 1
	} 

	JSText = 
	(
		$('input:radio[name="%ID%"]:eq(%Setting%)').attr('checked', "checked");
	)

	RunJavaScript(JSText)
}

InsertTextByID(ID,String)
{
	JSText = 
	(
		document.getElementById("%ID%").value = "%String%";
	)
	RunJavaScript(JSText)
}

InsertText(ID, String)
{
	JSText = 
	(
		document.getElementsByName("%ID%")[0].value = "%String%";
	)
	RunJavaScript(JSText)
}

InsertAdditionalText(ID, String)
{
	JSText = 
	(
		document.getElementsByName("%ID%")[0].value = document.getElementsByName("%ID%")[0].value + "%String%\n";
	)
	RunJavaScript(JSText)
}

InsertDropdown(Name, Value)
{
	global DropDownList
	VID := ListLookupID(DropDownList, Value)

	JSText =
	(
document.getElementsByName('%Name%')[0].value = %VID%
	)
	RunJavaScript(JSText)
}

SaveAsset()
{
	JSText =
	(
    saveAsset(getEditAssetID())
	)
	
	RunJavaScript(JSText)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Window Management;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AmIIMS()
{
	GroupAdd, IMSChrome, IMS - Google Chrome
	GroupAdd, IMS, ahk_group IMSChrome
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


;Could use some work. Need to change IMS to IMS loading
WaitForIMSLoad(Expected="")
{
	AmIIMS()
	If(Expected)
		WinWait, ahk_group IMSLoading
	WinWaitActive, ahk_group IMS
}

BlockOn()
{
	BlockInput On
}
BlockOff()
{
	BlockInput Off
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;List Management;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ListLookupID(List,String)
{
	String .= "|"
	Loop, Parse, List,`n
	{
		If InStr(A_LoopField,String)
		{
			return SubStr(A_LoopField, StrLen(String) + 1)
		}
	}
}

ListCompare(List,String)
{
	String .= "|"
	Loop, Parse, List,`n
	{
		If InStr(A_LoopField,String)
		{
			return A_Index
		}
	}
}

CPUIDLookup(CPU) {
	global CPUList
	return ListLookupID(CPUList,CPU)
}

ProductIDLookup(Product) {
	global ProductList
	return ListLookupID(ProductList,Product)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Misc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintLabel()
{
	GroupAdd, Possible, Untitled - Google Chrome
	GroupAdd, Possible, about:blank - Google Chrome
	
	WinWaitActive ahk_group Possible
	WaitForPrint()
	
	WinWaitActive, ahk_group IMS
	
}

;Maybe roll into above.
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

CPUCompare(CPU) {
	global CPUList
	return ListCompare(CPUList,CPU)
}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Not used by Handlers;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RunJavascript(RunText)
{
	Send ^y
	Send ^a
	Send {Backspace}
	SendInput {RAW}%RunText%
	Send ^+y
}


Alert(MsgText)
{
	GUI, Destroy
	Gui, Add, Text,, %MsgText%
	Gui, Show
}

::;.PrintVersion::
	Send Version 5.4
return

;This script is dedicated to John. 




;Remove?


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Navigation;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;If I can roll this into EditOrderLIne() I can remove this. 
;PlaceMouse(Field)
;{
;	JSText = 
;	(
;		document.getElementById("%Field%").focus();	
;	)
;	RunJavaScript(JSText)
;}

;InsertSpec(FindItem,ItemOption,Dropdown="")
;{
;Alert goes here!
;	FindTop()
;	FindSection(FindItem)
;	Send {Tab}
;
;	If (ItemOption == "Yes")
;	{
;		Send {Left}
;	} else if (ItemOption == "Pass") {
;		Send {Left}{Left}
;
;	} else if (ItemOption == "Fail") {
;		Send {Left}
;
;	} else if (ItemOption == "No") {
;	} else if (Dropdown == "Dropdown") {
;		Send %ItemOption%
;	} else {
;		SendInput %ItemOption%
;	}
;}

;SetIMSBrowser()
;{
;	global IMSBrowser
;	If(WinActive("ahk_group IMSChrome"))
;	If(WinActive("ahk_group IMSFirefox"))
;		IMSBrowser = Firefox
;}

;Remove
;FindSection(FindText)
;{;
;	Send ^f
;	Sleep, 100
;	SendInput %FindText%
;	Send {Escape}
;}

;Remove
;FindTop()
;{
;	FindSection("Grading/Receiving")
;}


;Rolled into SaveAsset
;LockAsset(Unlock = "")
;{
;	LockJSText =
;	(
;	var asset = document.getElementById('editAssetID').value;
;	var string = 'id='+asset;
;	var file = 'saveorderlineassetcondition.php';
;   var code = '$("#'+asset+'G").html(response);';
;   ajax(string, file, code, 'po');
;	)
;	UnlockJSText = 
;	(
;   var asset = document.getElementById('editAssetID').value;
;   var string = 'id='+asset;
;   var file = 'removeorderlineassetcondition.php';
;   var code = '$("#'+asset+'G").html(response);'; 
;   ajax(string, file, code, 'po');
;	)
;	
;	If(Unlock)
;	{
;		RunJavascript(UnlockJSText)
;		If(Unlock == "Relock")
;		{
;			RunJavaScript(LockJSText)
;		}
;	} else {
;		RunJavaScript(LockJSText)
;	}
;}

;PrintLabelOldJS()
;{
;	JSText =
;	(
;		function DoStuff(){
;			window.print();
;       		var win=window.open("about:blank","_self");
;      		win.close();}
;		function IsPicLoaded(){
;			var MyImg = document.getElementsByTagName('img')[0];
;			if (typeof MyImg === 'undefined') {
;				setTimeout(IsPicLoaded, 100);
;				return;}
;			if (!MyImg.clientWidth)	{
;				setTimeout(IsPicLoaded, 100);
;		        } else {
;       			DoStuff();}}     
;		function IsJLoaded() {
;			if (!window.jQuery) {
;				setTimeout(IsJLoaded, 100);
;		        } else {
;       			IsPicLoaded();}}
;		IsJLoaded();
;	)
;
;	RunJavascript(JSText)
;}

