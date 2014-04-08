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
Enter:: Send {Enter}{Tab}{Enter}
NumpadEnter:: Send {Enter}{Tab}{Enter}
#IfWinActive

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
NumpadEnter:: SendInput {Enter}{Tab}{Enter}

#IfWinActive



::TTTest::
WaitForIMSLoad()
Send Hello
Return

::GID.::
Send document.getElementById("")
Send {Left}{Left}
return


::swapHDForm::
swapHDDFormFactor()
return
::swapHDConnect::
swapHDDConnector()
return

