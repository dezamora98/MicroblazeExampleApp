##############################################################################
## Filename:          Z:\SysEmp\ProyectoFinal\ProyectoFinalSDE\Proyecto/drivers/digilentspartan3espi_v1_01_a/data/digilentspartan3espi_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Dec 11 06:55:27 2022 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "digilentspartan3espi" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
