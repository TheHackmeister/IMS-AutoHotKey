RunJavascript(RunText)
{
	Send ^y
	Send ^a
	Send {Backspace}
	SendInput {RAW}%RunText%
	Send ^+y
}
