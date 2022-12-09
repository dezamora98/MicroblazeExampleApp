##############################################################################
## Filename:          Z:\SysEmp\ProyectoFinal\ProyectoFinalSDE\Proyecto/drivers/digilentspartan3espi_v1_00_a/data/digilentspartan3espi_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Thu Dec 08 12:42:05 2022 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "digilentspartan3espi" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
