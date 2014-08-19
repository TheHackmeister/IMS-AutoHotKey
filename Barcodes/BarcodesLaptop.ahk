::;.LapIS::
Enter_CPUType("INTEL CORE I3", "INTEL CORE I5", "INTEL CORE I7")
return
::;.LapCore::
Enter_CPUType("INTEL CORE 2 DUO", "INTEL CORE DUO", "INTEL CORE SOLO")
return
::;.LapPM::
Enter_CPUType("INTEL PENTIUM M", "INTEL CELERON M", "INTEL PENTIUM 4")
return
::;.LapDC::
Enter_CPUType("INTEL PENTIUM DUAL CORE", "INTEL CELERON DUAL CORE")
return
::;.LapTur::
Enter_CPUType("AMD TURION 64 X2", "AMD Turion II", "AMD TURION 64")
return
::;.LapAth::
Enter_CPUType("AMD ATHLON 64 X2", "AMD ATHLON II X2", "AMD ATHLON 64")
return
::;.LapPhen::
Enter_CPUType("AMD PHENOM II", "AMD PHENOM X3", "AMD PHENOM X4")
return

::;.Lap121::
Enter_ScreenSize("10", "12")
return
::;.Lap14::
Enter_ScreenSize("14", "13")
return
::;.Lap154::
Enter_ScreenSize("15", "16")
return
;::;.Lap156::
;Enter_ScreenSize("15.6", "15")
;return
::;.Lap17::
Enter_ScreenSize("17", "18")
return

::;.LapNt1::
Enter_Notes("Will not receive power.","BIOS Lock.")
Sleep 250
Enter_Condition("Broken")
return
::;.LapNt2::
Enter_Notes("Will not power on.","Will not remain on.")
Sleep 250
Enter_Condition("Broken")
return
::;.LapNt3::
Enter_Notes("Will Not Display","Does not display correctly.")
Sleep 250
Enter_Condition("Broken")
return
::;.LapNt4::
Enter_Notes("Cracked LCD.", "Cracked LCD.")
Sleep 250
Enter_Condition("Low Grade","Good Base")
return
::;.LapNt5::
Enter_Notes("No Webcam.")
Sleep 250
Enter_Condition("Broken")
return
::;.LapNt6::
Enter_Notes("Keyboard.", "Case damage.")
return

::;.LCPU10::
Enter_CPUSpeed("1.0 Ghz", "1.2 Ghz")
return
::;.LCPU14::
Enter_CPUSpeed("1.4 Ghz", "1.5 Ghz")
return
::;.LCPU16::
Enter_CPUSpeed("1.6 Ghz", "1.7 Ghz")
return
::;.LCPU18::
Enter_CPUSpeed("1.8 Ghz", "1.9 Ghz")
return
::;.LCPU20::
Enter_CPUSpeed("2.0 Ghz", "2.1 Ghz")
return
::;.LCPU22::
Enter_CPUSpeed("2.2 Ghz", "2.3 Ghz")
return
::;.LCPU24::
Enter_CPUSpeed("2.4 Ghz", "2.5 Ghz")
return

::;.LXP::
Enter_COA("Windows XP Home", "Windows XP Pro", "Windows XP Media Center")
return
::;.LVISTA::
Enter_COA("Windows Vista Home Premium", "Windows Vista Business")
return
::;.LW7::
Enter_COA("Windows 7 Home Premium", "Windows 7 Pro")
return
::;.LCOA::
Enter_COA("None/unreadable")
return
::;.LW8::
Enter_COA("Windows 8", "Windows 8 Pro")
return



::;.LBAT::
Enter_Battery()
return
::;.LOPT::
Enter_Optical()
return


::;.LCAM::
Enter_Webcam()
return
::;.DISPLAY::
Enter_Display()
return

::;.LCD::
Enter_LCD()
return


::;.R<1::
Enter_RAM("LESS THAN 1 GB")
return
::;.R1::
Enter_RAM("1.0 GB / 1024 MB", "1.5 GB / 1536 MB")
return
::;.R2::
Enter_RAM("2.0 GB / 2048 MB")
return
::;.RRem::
Enter_RAM("RAM REMOVED / UNREMOVABLE")
return

::;.WIN8::
Enter_Win8()
return
