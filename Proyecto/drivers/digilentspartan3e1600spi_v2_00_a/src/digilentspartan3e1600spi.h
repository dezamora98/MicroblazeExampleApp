/*****************************************************************************
* Filename:          Z:\SysEmp\ProyectoFinal\ProyectoFinalSDE\Proyecto/drivers/digilentspartan3e1600spi_v2_00_a/src/digilentspartan3e1600spi.h
* Version:           2.00.a
* Description:       digilentspartan3e1600spi Driver Header File
* Date:              Sat Dec 17 14:34:06 2022 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef DIGILENTSPARTAN3E1600SPI_H
#define DIGILENTSPARTAN3E1600SPI_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 */
#define DIGILENTSPARTAN3E1600SPI_USER_SLV_SPACE_OFFSET (0x00000000)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a DIGILENTSPARTAN3E1600SPI register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the DIGILENTSPARTAN3E1600SPI device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DIGILENTSPARTAN3E1600SPI_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define DIGILENTSPARTAN3E1600SPI_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a DIGILENTSPARTAN3E1600SPI register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the DIGILENTSPARTAN3E1600SPI device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 DIGILENTSPARTAN3E1600SPI_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DIGILENTSPARTAN3E1600SPI_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the DIGILENTSPARTAN3E1600SPI instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus DIGILENTSPARTAN3E1600SPI_SelfTest(void * baseaddr_p);

#endif /** DIGILENTSPARTAN3E1600SPI_H */
