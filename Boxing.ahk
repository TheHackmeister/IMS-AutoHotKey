setupBoxing()
{
	AMIIMS()
	BlockOn()
	
;	FileRead, JSText, Boxing-HTML.js
;	StringReplace, JSText, JSText, `t, ,A
;	RunJavaScriptLong(JSText)

	FileRead, JSText, Assets.js
	StringReplace, JSText, JSText, `t, ,A
	RunJavaScriptLong(JSText)

;;	FileRead, JSText, Boxing-HTML.js
;	StringReplace, JSText, JSText, `t, ,A
;	RunJavaScriptLong(JSText)	
	
	FileRead, JSText, Boxing-CreateLoc.js
	StringReplace, JSText, JSText, `t, ,A
	RunJavaScriptLong(JSText)	

	FileRead, JSText, Boxing-CurrentLoc.js
	StringReplace, JSText, JSText, `t, ,A
	RunJavaScriptLong(JSText)
	
	FileRead, JSText, Boxing-CurrentBox.js
	StringReplace, JSText, JSText, `t, ,A
	RunJavaScriptLong(JSText)

	FileRead, JSText, Boxing-Init.js
	StringReplace, JSText, JSText, `t, ,A
	RunJavaScriptLong(JSText)
	
BlockOff()
}

countInLocation()
{

FileRead, runJS, Count-In-Location.js

RunJavascriptSafe(runJS)
WinWaitActive, Developer Tools
Send !{F4}
WinWaitActive, Developer Tools
Send !{F4}
}


