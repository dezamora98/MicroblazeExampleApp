##############################################################################
## Filename:          Z:\SysEmp\ProyectoFinal\ProyectoFinalSDE\Proyecto/drivers/digilentspartan3e1600spi_v2_00_a/data/digilentspartan3e1600spi_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sat Dec 17 14:34:06 2022 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "digilentspartan3e1600spi" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
