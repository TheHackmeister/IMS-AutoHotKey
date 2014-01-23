setupBoxing()
{
	global AssetsJS
	global BoxingCreateLocJS
	global BoxingCurrentLocJS
	global BoxingCurrentBoxJS
	global BoxingInitJS
	AMIIMS()
	BlockOn()

	
	RunJavaScriptLong(AssetsJS)
	RunJavaScriptLong(BoxingCreateLocJS)	
	RunJavaScriptLong(BoxingCurrentLocJS)
	RunJavaScriptLong(BoxingCurrentBoxJS)
	RunJavaScriptLong(BoxingInitJS)
	
BlockOff()
}

setupHDTest()
{
	global TestingHDJS
	AMIIMS()
	RunJavaScriptLong(AssetsJS)
	RunJavaScriptLong(TestingHDJS)
}


countInLocation()
{
	global CountInLocationJS
RunJavascriptSafe(CountInLocationJS)
WinWaitActive, Developer Tools
Send !{F4}
WinWaitActive, Developer Tools
Send !{F4}
}


