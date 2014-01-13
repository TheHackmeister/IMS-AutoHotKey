SetupIMSPage() 
{
BlockOff()
	If (!WinActive("ahk_group NOIMS")){
		Alert("Can't set-up IMS; this is not an IMS page. (I'm pretty sure) ")
		BlockOff()
		Exit
	}
BlockOn()	
	FileRead, JSText, SetupIMS.js
	RunJavascriptSafe(JSText)
	
	FileRead, ImproveIMSText, General.js
	StringReplace, ImproveIMSText, ImproveIMSText, `t, ,A
	RunJavaScriptLong(ImproveIMSText)

	FileRead, ImproveIMSText, General-2.js
	StringReplace, ImproveIMSText, ImproveIMSText, `t, ,A
	RunJavaScriptLong(ImproveIMSText)
	
BlockOff()
}
