setupBoxing()
{
	global AssetsJS
	global BoxingCreateLocJS
	global BoxingCurrentLocJS
	global BoxingCurrentBoxJS
	global BoxingInitJS
	global LocationsJS
	AMIIMS()
	BlockOn()

	
	RunJavaScriptLong(AssetsJS)
	RunJavaScriptLong(LocationsJS)
	RunJavaScriptLong(BoxingCreateLocJS)	
	RunJavaScriptLong(BoxingCurrentLocJS)
	RunJavaScriptLong(BoxingCurrentBoxJS)
	RunJavaScriptLong(BoxingInitJS)
	
BlockOff()
}

setupHDTest()
{
	global TestingHDJS
	global AssetsJS
	global LocationsJS
	AMIIMS()
	RunJavaScriptLong(AssetsJS)
	RunJavaScriptLong(LocationsJS)
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


