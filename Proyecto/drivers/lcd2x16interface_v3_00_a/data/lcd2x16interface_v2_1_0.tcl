##############################################################################
## Filename:          Z:\SysEmp\test_MB_LCDCtr\TestLCD_2/drivers/lcd2x16interface_v3_00_a/data/lcd2x16interface_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Nov 06 16:12:08 2022 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "lcd2x16interface" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
