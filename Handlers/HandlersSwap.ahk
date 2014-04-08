SwapWebcam()
{
	Global CurrentInsertWebcam
	If(CurrentInsertWebcam == "Yes")
		EnterWebcam("No")
	Else
		EnterWebcam("Yes")
}
SwapOptical()
{
	Global CurrentInsertOptical
	Count := CountSwaps("Optical", 3)

	If(Count == "2")
	{
		EnterOptical("DAMAGED")
		return
	}
	
	If(Count == "3")
	{
		EnterOptical("NONE/MISSING")
		return
	}
	
	If(CurrentInsertOptical == "DVDRW")
	{
		EnterOptical("DVD/CDRW")
	} Else {
		EnterOptical("DVDRW")
	}	
}
SwapUSB()
{
	Global CurrentInsertUSB
	
	Count := CountSwaps("Optical", 3)
	If(Count == 2)
	{
		EnterUSB("5")
		return
	}
	
	If(Count == "3")
	{
		EnterUSB("6")
		return
	}
	
	If(CurrentInsertUSB == "3")
		EnterUSB("4")
	Else 
		EnterUSB("3")
	
	
}
SwapHDMI()
{
	Global CurrentInsertHDMI
	If(CurrentInsertHDMI == "Yes")
		EnterHDMI("No")
	Else
		EnterHDMI("Yes")
}
SwapMemoryCard()
{
	Global CurrentInsertMemoryCard
	If(CurrentInsertMemoryCard == "Yes")
		EnterMemoryCard("No")
	Else
		EnterMemoryCard("Yes")
}
SwapCOA()
{
	Global CurrentInsertCOA
}
SwapHDDCaddy()
{
	Global CurrentInsertHDDCaddy
	If(CurrentInsertHDDCaddy == "Yes")
		EnterHDDCaddy("No")
	Else
		EnterHDDCaddy("Yes")
		
}
SwapBattery()
{
	Global CurrentInsertBattery
	If(CurrentInsertBattery == "Yes")
		EnterBattery("No")
	Else
		EnterBattery("Yes")
}


CountSwaps(Item, Max)
{
	Global LastItemScanned
	Global SwapCount
	LastItemScanned := Item
	
	
	If(SwapCount = Max)
	{
		SwapCount := 1
		return SwapCount
	}
	
	If(LastItemScanned != Item)
	{
		SwapCount := 1
	} else {
		SwapCount += 1
	}
	return SwapCount
}