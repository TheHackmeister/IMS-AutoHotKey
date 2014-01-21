::;.EOrder::
::;.POrder::
EnterOrderLine()
return


::;.ProdSave::
EnterSave()
return

::;.ProdSG::
EnterSave("Pass")
return

::UHHH::
BlockOff()
return

::SAVEME!::
exitApp
return

::LoadIMS::
AmIIMS()
return

::HDDLoop::
EnterHDDLoop()
return
#IfWinActive Input Hard Drive
Enter:: Send {Tab}{Enter}
NumpadEnter:: Send {Enter}{Tab}{Enter}
#IfWinActive

:B0:CountInLocation::
countInLocation()
return


::TTTest::
WaitForIMSLoad()
Send Hello
Return

::GID.::
Send document.getElementById("")
Send {Left}{Left}
return

::IMSBoxing::
setupBoxing()
return

::IMSHDTesting::
setupHDTest()
return

::BoxingSimple::
JSTextB = 
(
	firstAsset.changeCompare("Type");
)

RunJavaScript(JSTextB)

return

::swapHDForm::
swapHDDFormFactor()
return
::swapHDConnect::
swapHDDConnector()
return
