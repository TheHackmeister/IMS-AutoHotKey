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
addAssetSelectProduct('%PID%', temp);
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
		BlockOff()
		InputBox, LocationInput, Location number,Enter your location number,,210,120
		Location := LocationInput
		BlockOn()
	}
	
	If(!Location)
	{
		Alert("You didn't enter any location. Exiting script.")
		BlockOff()
		exit
	}

	JSText = 
	(
document.getElementById("addOrderlineLocation").value = "%Location%"; 
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
selectOrderlineSpec('%CPUID%', 6, "", getEditAssetID());
	)
	RunJavascript(JSText)
}

InsertRadio(ID, Setting)
{
	If(Setting == "Yes" OR Setting == "Pass")
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

InsertTextByID(ID,SN)
{
	JSText = 
	(
		document.getElementById("%ID%").value = "%SN%";
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

;Test
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
	global IMSBrowser
	GroupAdd, NOIMSChrome, 63.253.103.78/ims/dashboard.php - Google Chrome
	GroupAdd, NOIMSChrome, 63.253.103.78/ims/dashboard.php# - Google Chrome
	GroupAdd, NOIMSChrome, 63.253.103.78/ims/login.php# - Google Chrome
	GroupAdd, NOIMSChrome, 63.253.103.78/ims/login.php - Google Chrome
	GroupAdd, IMSChrome, IMS - Google Chrome
	GroupAdd, IMSFirefox, IMS - Mozilla Firefox
	GroupAdd, IMS, ahk_group IMSChrome
	GroupAdd, IMS, ahk_group IMSFirefox
	GroupAdd, NOIMS, ahk_group NOIMSChrome
	GroupAdd, NOIMSFirefox, Mozilla Firefox
	GroupAdd, NOIMS, ahk_group NOIMSFirefox
	GroupAdd, IMSLoading, IMS (Loading) - Mozilla Firefox
	GroupAdd, IMSLoading, IMS (Loading) - Google Chrome

	
	If (WinActive("ahk_group IMS"))
	{
;		SetIMSBrowser()
		return True
	} else If (WinActive("ahk_group NOIMS")) {
		SetupIMSPage()
;		SetIMSBrowser()
		return
		
	} else {
		IfWinExist, ahk_group IMS
		{
			WinActivate
			WinWait ahk_group IMS
;			SetIMSBrowser()
			return
		}		
		BlockOff()
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
	
	;	Sleep, 750
;	PixelGetColor, PColor, 12, 250
;	While (PColor == "0x7F7F7F")
;	{
;	PixelGetColor, PColor, 12, 250
;	;Coounter += 1
;	Sleep, 100
;	}
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
	GroupAdd, Possible, 404 Not Found - Mozilla Firefox
	GroupAdd, Possible, Mozilla Firefox
	GroupAdd, Possible, Untitled - Google Chrome
	GroupAdd, Possible, about:blank - Google Chrome
	
	WinWaitActive ahk_group Possible
BlockOff()
	WaitForPrint()
	
;	If (WinActive("Mozilla Firefox")) {
;		WaitForPrint()
;		WinWaitActive, Mozilla Firefox
;	} else {
;		WaitForPrint()
;	}

	Send !{F4}
	WinWaitActive, ahk_group IMS
	
}

;Maybe roll into above.
WaitForPrint()
{

	GroupAdd, IMSPrint, Print
	GroupAdd, IMSPrint, ,Print
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

RunJavascriptLong(RunText)
{
	Send ^y
	Send ^a
	Send {Backspace}
	TempClip := clipboard
	Sleep, 400
	clipboard = %RunText%
	Sleep, 400
	Send ^v
	Sleep, 50
	Send ^+y
	clipboard := TempClip
	Sleep, 400
}

RunJavascriptSafe(JSText)
{
	SetTitleMatchMode, 2
	TempClip := clipboard
	Sleep, 300
	clipboard = %JSText%
	Sleep, 300
	If(WinActive("Chrome"))
	{
		If (!WinActive(,"Developer Tools - http://63.253.103.78/ims/dashboard.php"))
			Send ^+j
		BlockOff()
		WinWait,,Developer Tools - http://63.253.103.78/ims/dashboard.php
		Sleep, 1000
		BlockOn()
		Send ^v
		Send {Enter}
		Send ^+j
		WinWaitNotActive,,Developer Tools - http://63.253.103.78/ims/dashboard.php
	} Else {
		Send +{F4}
		BlockOff()
		WinWaitActive, Scratchpad
		BlockOn()
		Sleep, 1000
		Send ^v
		Send ^r
		
		WinWaitActive, *Scratchpad
		Send !{F4}
		WinWaitActive, Unsaved Changes
		Send !n
		WinWaitNotActive, Unsaved Changes
		WinWaitActive, IMS - Mozilla Firefox
		Sleep, 1000
	}
	clipboard := TempClip
	Sleep, 300
	SetTitleMatchMode, 1
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

