SetKeyDelay, 3

#Include Globals\Globals.ahk

;Has to be after globals
;Update the version number in Lib\Check_ForUpdate.ahk and in ../AHK/version.ini
Updater: 
	Check_ForUpdate()
	SetTimer, Updater, 3600000
return

#Include Barcodes\BarcodesGeneral.ahk
#Include Barcodes\BarcodesLaptop.ahk
#Include Barcodes\BarcodesProducts.ahk


;This script is dedicated to John. 