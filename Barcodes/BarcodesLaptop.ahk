::;.IOCPUS14::
EnterCPUSpeed("1.4 Ghz", "2.4 Ghz")
return
::;.IOCPUS15::
EnterCPUSpeed("1.5 Ghz", "2.5 Ghz")
return
::;.IOCPUS16::
EnterCPUSpeed("1.6 Ghz", "1.7 Ghz")
return
::;.IOCPUS18::
EnterCPUSpeed("1.8 Ghz", "1.9 Ghz")
return
::;.IOCPUS20::
EnterCPUSpeed("2.0 Ghz")
return
::;.IOCPUS21::
EnterCPUSpeed("2.1 Ghz")
return
::;.IOCPUS22::
EnterCPUSpeed("2.2 Ghz", "2.5 Ghz")
return
::;.IOCPUS25::
EnterCPUSpeed("2.5 Ghz")
return

::;.LapIS::
EnterCPUType("INTEL CORE I3", "INTEL CORE I5", "INTEL CORE I7")
return
::;.LapCore::
EnterCPUType("INTEL CORE 2 DUO", "INTEL CORE DUO", "INTEL CORE SOLO")
return
::;.LapPM::
EnterCPUType("INTEL PENTIUM M", "INTEL CELERON M", "INTEL PENTIUM 4")
return
::;.LapDC::
EnterCPUType("INTEL PENTIUM DUAL-CORE", "INTEL CELERON (POST PENTIUM M)")
return
::;.LapTur::
EnterCPUType("AMD TURION 64 X2", "AMD Turion II", "AMD TURION 64")
return
::;.LapAth::
EnterCPUType("AMD ATHLON 64 X2", "AMD ATHLON II X2", "AMD ATHLON 64")
return
::;.LapPhen::
EnterCPUType("AMD PHENOM II", "AMD PHENOM X3", "AMD PHENOM X4")
return

::;.Lap121::
EnterScreenSize("12.1", "10.1")
return
::;.Lap14::
EnterScreenSize("14.1", "14")
return
::;.Lap154::
EnterScreenSize("15.4", "13.3")
return
::;.Lap156::
EnterScreenSize("15.6", "15")
return
::;.Lap17::
EnterScreenSize("17", "17.3")
return

::;.LapNt1::
EnterNotes("Will not receive power.","BIOS Lock.")
return
::;.LapNt2::
EnterNotes("Will not power on.","Will not remain on.")
return
::;.LapNt3::
EnterNotes("Will Not Display","")
return
::;.LapNt4::
EnterNotes("Cracked LCD.","Does not display correctly.")
return
::;.LapNt5::
EnterNotes("Case damage.")
return
::;.LapNt6::
EnterNotes("Keyboard.")
return



::;.LapGs::
EnterRAM()
EnterWebcam()
EnterOptical()
EnterUSB()
EnterHDMI()
EnterMemoryCard()
EnterCOA()
EnterHDDCaddy()
EnterBattery()
EnterCondition("Pass")
return


::;.IOHP6910P::

EnterProduct("HP COMPAQ 6910P")

KeyWait, Enter, D

EnterOrderLine("16")

KeyWait, Enter, D

EnterCPUType("INTEL CORE 2 DUO")
EnterCPUSpeed("2.2 Ghz")
EnterScreenSize("14")
EnterRAM("2 GB")
EnterWebcam("No")
EnterOptical("DVDRW")
EnterUSB("3")
EnterHDMI("No")
EnterMemoryCard("Yes")
EnterCOA("Windows Vista Business")
EnterHDDCaddy("Yes")
EnterBattery("Yes")
EnterCondition("Pass")
EnterSave()
return



