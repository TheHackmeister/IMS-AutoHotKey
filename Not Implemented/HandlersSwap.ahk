SwapWebcam()
{
	Global CurrentInsertWebcam
	If(CurrentInsertWebcam == "Yes")
		Enter_Webcam("No")
	Else
		Enter_Webcam("Yes")
}
SwapOptical()
{
	Global CurrentInsertOptical
	Count := CountSwaps("Optical", 3)

	If(Count == "2")
	{
		Enter_Optical("DAMAGED")
		return
	}
	
	If(Count == "3")
	{
		Enter_Optical("NONE/MISSING")
		return
	}
	
	If(CurrentInsertOptical == "DVDRW")
	{
		Enter_Optical("DVD/CDRW")
	} Else {
		Enter_Optical("DVDRW")
	}	
}
SwapUSB()
{
	Global CurrentInsertUSB
	
	Count := CountSwaps("Optical", 3)
	If(Count == 2)
	{
		Enter_USB("5")
		return
	}
	
	If(Count == "3")
	{
		Enter_USB("6")
		return
	}
	
	If(CurrentInsertUSB == "3")
		Enter_USB("4")
	Else 
		Enter_USB("3")
	
	
}
SwapHDMI()
{
	Global CurrentInsertHDMI
	If(CurrentInsertHDMI == "Yes")
		Enter_HDMI("No")
	Else
		Enter_HDMI("Yes")
}
SwapMemoryCard()
{
	Global CurrentInsertMemoryCard
	If(CurrentInsertMemoryCard == "Yes")
		Enter_MemoryCard("No")
	Else
		Enter_MemoryCard("Yes")
}
SwapCOA()
{
	Global CurrentInsertCOA
}
SwapHDDCaddy()
{
	Global CurrentInsertHDDCaddy
	If(CurrentInsertHDDCaddy == "Yes")
		Enter_HDDCaddy("No")
	Else
		Enter_HDDCaddy("Yes")
		
}
SwapBattery()
{
	Global CurrentInsertBattery
	If(CurrentInsertBattery == "Yes")
		Enter_Battery("No")
	Else
		Enter_Battery("Yes")
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