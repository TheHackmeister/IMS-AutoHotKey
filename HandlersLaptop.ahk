EnterCPUType(Option1 = "",Option2 = "", Option3 = "")
{
BlockOn()
	AmIIMS()
	global CurrentInsertCPUType
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if (Option2 == LastItemScanned AND Option3) {
		PrintOption = %Option3%
	} else if Option1 {
		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		

	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = CPUType
	CurrentInsertCPUType = %PrintOption%
	
	InsertCPU(PrintOption)
BlockOff()
}

EnterCPUSpeed(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCPUSpeed
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	

	} else {
	;;; Algorithm for guess goes here. 		

	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = CPUSPeed
	CurrentInsertCPUSpeed = %PrintOption%

	;;;Actions

	InsertText("spec5",PrintOption)
}
EnterRAM(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCPUType
	global CurrentInsertRAM

	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2) {
		PrintOption = %Option2%
	} else if Option1 {
		PrintOption = %Option1%	
	} else {
		;DefaultInsertRAM = 2 GB
		If (CPUCompare("StartISeries") < CPUCompare(CurrentInsertCPUType)) {
			PrintOption = 4 GB
		} else if (CPUCompare("StartOldDC") < CPUCompare(CurrentInsertCPUType)) {
			PrintOption = 2 GB
		} else {	
			PrintOption = 512 MB
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = RAM
	CurrentInsertRAM = %ItemOption%


	;;;Actions
;ModJS, Do Dropdown. Either loop or create table. 
	InsertDropdown("spec7",PrintOption)
}

EnterScreenSize(Option1 = "", Option2 = "")
{
BlockOn()
	AmIIMS()
	global CurrentInsertScreenSize
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		
		PrintOption = 14.1
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = ScreenSize
	CurrentInsertScreenSize = %PrintOption%


	;;;Actions
	InsertText("spec3",PrintOption)
BlockOff()
}
EnterWebcam(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCPUType
	global CurrentInsertWebcam



	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		If (CPUCompare("StartOldDC") > CPUCompare(CurrentInsertCPUType)) {
			PrintOption = No
		} else {	
			PrintOption = Yes
		}
	}
	CurrentInsertWebcam = %PrintOption%
	LastItemScanned = %PrintOption%
	LastItemTypeScanned = Webcam


	;;;Actions
	InsertRadio("spec8", PrintOption)
}
EnterOptical(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertOptical
	global CurrentInsertScreenSize
	global CurrentInsertCPUType
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		If (CurrentInsertScreenSize <= 12.1 AND CurrentInserScreenSize)
		{
			PrintOption := "N/A"
		} else if (CPUCompare("DC") > CPUCompare(CurrentInsertCPUType)) 
		{
			PrintOption := "DVD/CDRW"
		} else {
			PrintOption = DVDRW
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = Optical
	CurrentInsertOptical = %PrintOption%


	;;;Actions
;ModJS
	InsertDropDown("spec9",PrintOption)
}

EnterUSB(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertUSB
	global CurrentInsertScreenSize
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		If (CurrentInsertScreenSize >= 17)
		{
			PrintOption = 4
		} else {		
			PrintOption = 3
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = USB
	CurrentInsertUSB = %PrintOption%

	;;;Actions
;ModJS
	InsertText("spec27",PrintOption)
}
EnterHDMI(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCPUType
	global CurrentInsertHDMI

	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		If (CPUCompare("StartHDMI") < CPUCompare(CurrentInsertCPUType))
		{
			PrintOption = Yes
		} else {
			PrintOption = No
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = HDMI
	CurrentInsertHDMI = %PrintOption%

	;;;Actions
	InsertRadio("spec28", PrintOption)
}

EnterMemoryCard(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCPUType
	global CurrentInsertMemoryCard
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		If (CPUCompare(CurrentInsertCPUType) > CPUCompare("StartOldDC"))
		{
			PrintOption = Yes
		} else {
			PrintOption = No
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = MemoryCard
	CurrentInsertMemoryCard = %PrintOption%

	;;;Actions
	InsertRadio("spec29", PrintOption)
}

EnterCOA(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertCOA
	global CurrentInsertCPUType
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		If (CPUCompare(CurrentInsertCPUType) > CPUCompare("StartWin7")) {
			PrintOption = Windows 7 Home Premium
		} else If (CPUCompare(CurrentInsertCPUType) > CPUCompare("StartOldDC")) {	
			PrintOption = Windows Vista Home Premium
		} else {
			PrintOption = Windows XP Pro
		}
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = COA
	CurrentInsertCOA = %PrintOption%


	;;;Actions
	InsertDropDown("spec14",PrintOption)
}

EnterOS(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertOS
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		
		PrintOption = %DefaultInsertOS%
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = OS
	CurrentInsertOS = %PrintOption%


	;;;Actions
	InsertRadio("spec18", PrintOption)
}

EnterHDDAdapter(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertHDDAdapter
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		
		PrintOption = %DefaultInsertHDDAdapter%
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = HDDAdapter
	CurrentInsertHDDAdapter = %PrintOption%

	;;;Actions
	InsertRadio("spec25", PrintOption)
}

EnterHDDCaddy(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertHDDCaddy
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		
		PrintOption = Yes
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = HDDCaddy
	CurrentInsertHDDCaddy = %PrintOption%

	;;;Actions
	InsertRadio("spec24", PrintOption)
}

EnterBattery(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertBattery
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		PrintOption = Yes
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = Battery
	CurrentInsertBattery = %PrintOption%

	;;;Actions
	InsertRadio("spec20", PrintOption)
}

EnterAdapter(Option1 = "", Option2 = "")
{
	AmIIMS()
	global CurrentInsertAdapter
	PrintOption = ""
	;;;Tracking

	If (Option1 == LastItemScanned AND Option2)
	{
		PrintOption = %Option2%
		
	} else if Option1 {

		PrintOption = %Option1%	
	} else {
	;;; Algorithm for guess goes here. 		
		
		PrintOption = %DefaultInsertAdapter%
	}

	LastItemScanned = %PrintOption%
	LastItemTypeScanned = Adapter
	CurrentInsertAdapter = %PrintOption%

	;;;Actions
	InsertRadio("spec11", PrintOption)
}