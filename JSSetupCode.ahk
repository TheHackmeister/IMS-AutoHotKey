

SetupIMSPage() 
{
BlockOff()
	If (!WinActive("ahk_group NOIMS")){
		Alert("Can't set-up IMS; this is not an IMS page. (I'm pretty sure) ")
		BlockOff()
		Exit
	}
BlockOn()	
	global SetupIMSJS
	global GeneralJS

	RunJavascriptSafe(SetupIMSJS)
	
	RunJavaScriptLong(GeneralJS)
BlockOff()
}
