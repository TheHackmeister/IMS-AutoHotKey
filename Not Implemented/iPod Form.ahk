;Move this!


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



;I commented this out because it couldn't find QuickNote. I'm pretty sure it is in the ipod form file.
;#IfWinActive Input iPod
;::;.NHP::
;	QuickNote("HP")
;return
;::;.NDIGI::;
;	QuickNote("DIGI")
;return
;::;.NSCREEN::
;	QuickNote("SCREEN")
;return
;::;.NLCD::
;	QuickNote("LCD")
;return
;::;.NSPEAKER::
;	QuickNote("SPEAKER")
;return
;::;.NHOME::
;	QuickNote("HOME BUTTON")
;return
;::;.NVOL::
;	QuickNote("VOLUME ROCKER")
;return
;::;.NPOWER::
;	QuickNote("POWER BUTTON")
;return
;::;.NHOLD::
;	QuickNote("HOLD SWITCH")
;return
;::;.NWHEEL::
;	QuickNote("CLICK WHEEL")
;return
;::;.NCASE::
;	QuickNote("CASE DAMAGE")
;return
;::;.NWIFI::
;	QuickNote("NO WIFI")
;return
;::;.NFCAM::
;	QuickNote("FRONT CAMERA")
;return
;::;.NRCAM::
;	QuickNote("REAR CAMERA")
;return
;::;.NBAT::
;	QuickNote("BATTERY", true)
;return
;::;.NCHARGE::
;	QuickNote("CHARGE PORT", true)
;return
;::;.NHDD::
;	QuickNote("HDD", true)
;return
;::;.IGSAVE::
;	QuickSave()
;return



;Enter:: Send {Enter}{Tab}{Enter}
;NumpadEnter:: SendInput {Enter}{Tab}{Enter}

#IfWinActive

::IPODLOOP::
EnterIpodLoop()
return

QuickNote(Text, FailWipe = "") 
{
	If(!FailWipe)
	{
		Send !{r}
	} Else {
		Send !{o}
	}
	
	Send !{f}
	
	Send +{Tab}+{Tab}+{Tab}+{Tab}{Right}
	Send %Text% {Enter}
	Send {Tab}
}

QuickSave(){
	
	Send !{r}
	Send !{p}
	Send +{Tab}+{Tab}+{Tab}
}	

FindAndClickButton(Text) 
{
	While !WinActive(,Text) 
	{
		WinWaitActive, iTunes
		SendInput {Tab}
		Sleep, 100
	}
	SendInput {Space}
}

GetSN() {
	WinActivate, iTunes
	
	WinGetActiveStats,name,width,height,x,y
	width := width - 150
	height := 75
	i_w := width - 20
	drag_h := 125
	
	PixelGetColor, Color, %width%, %height%
	If(Color == "0xBDBEBD") ; We're in XP. 
	{
		width := width - 5
		height := 93
		i_w := width - 20
		drag_h := 150
	}
	
	PixelGetColor, Color, %width%, %height%
	While !(Color == "0x696969" || Color == "0x6B696B" )
	{
		Sleep, 1000
		IfWinActive, iTunes, A new iPod software version
		{
			Sleep, 500
			SendInput !{l} 
			WinWaitNotActive, iTunes, A new iPod software version
		}
		PixelGetColor, Color, %width%, %height%
	}
	
	MouseClick, Left, %i_w%, %height%
	WinWaitNotActive,,Music
	IfWinActive, iTunes, A new iPod software version
	{
		Sleep, 500
		SendInput !{l} 
		WinWaitNotActive, iTunes, A new iPod software version
	}
	TempClip = %clipboard%
	
	Sleep, 500
	SendInput ^{c}
	While, (TempClip == clipboard)
	{
		Sleep, 500
		SendInput ^{c}
		Sleep, 333
	}
	FindAndClickButton("Done")
	
	MouseClick,Left, %width%, %height%
	Sleep, 250
	Return %clipboard%		
}


EnterIpodLoop(Loc = "", Product="", Pod="")
{
Global
;	FocusIMS()
;	Global 25INHDDs
;	Global 35INHDDs

	Gui, Destroy
	Gui, Add, Text,, Enter External Asset Number
	Gui, Add, Edit, vEAN,
	Gui, Add, Text,, Enter Notes
	Gui, Add, Edit, R4 vNote, 
	Gui, Add, Text,, Enter Model
	Gui, Add, Edit, vModel, %Product%
	Gui, Add, Button, GSubmitIpod, Submit
	Gui, Add, Text,, Enter iPod Type
	Gui, Add, DropDownList, vIpod AltSubmit Choose%Pod%, Touch|Classic|Nano|Mini|Shuffle|Ipad
	Gui, Add, Text,, Condition
	Gui, Add, Radio, vConditionP, &P Pass
	Gui, Add, Radio, vConditionF, &F Fail
	Gui, Add, Text,, Factory Restored
	Gui, Add, Radio, vRestoreP, &R Pass
	Gui, Add, Radio, vRestoreF, &O Fail
	Gui, Add, Text,, Serial Number
	Gui, Add, Edit, vSN
	Gui, Add, Text,, Location
	Gui, Add, Edit, vLocation, %Loc%

	Gui, Show,, Input iPod
	

} SubmitIpod:
	Gui, Submit

	If(!EAN) {
		Gui, Show
		Send +{Tab}+{Tab}+{Tab}
		return
	}

;	If(!Model)
;	{
;		Gui, Show
;		Send +{Tab}
;		return
;	}
	
	;If Model is not in array
	
	If(!Location) {
		Gui, Show
		Send {Tab}{Tab}{Tab}{Tab}
		return
	}
	
	If(!ConditionF && !ConditionP) {
		Gui, Show
		Send {Tab}
		return
	}
	
	If(!RestoreP && !RestoreF) {
		Gui, Show
		Send {Tab}{Tab}
		return
	}
	
	If (ConditionP == 1) {
		Cond = Pass
	} Else {
		Cond = Fail
	}
	
	If (RestoreP == 1) {
		Rest = Pass
	} Else {
		Cond = Fail
	}
	
	
	If(Ipod == 1) { ;Touches
		Type = %Touches%
	} Else If(Ipod == 2) { ;Classics
		Type = %Classics%
	} Else If(Ipod == 3) { ;Nanos
		Type = %Nanos%
	} Else If(Ipod == 4) { ;Minis
		Type = %Minis%
	} Else If(Ipod == 5) { ;Shuffles
		Type = %Shuffles%
	} Else If(Ipod == 6) { ;iPads
		Type = %Ipads%
	} Else{
		Type = ""
	}
	
	Product := List_LookupID(Type,Model)
	
	If(!Product AND Model)
	{
			
		Gui, Show
		Send +{Tab}
		return
	}
	If(!Model)
		Product =
	
	If(!SN) {
		SN := GetSN()
	}
	



	WinWaitNotActive, Input iPod
	EnterCompleteProductAndConditions(EAN,SN,Cond,Rest,Product,Note)
	EnterIpodLoop(Location,Model,Ipod)
return