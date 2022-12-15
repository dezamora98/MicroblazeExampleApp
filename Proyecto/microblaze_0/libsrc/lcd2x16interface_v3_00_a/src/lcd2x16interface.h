/*****************************************************************************
* Filename:          Z:\SysEmp\test_MB_LCDCtr\TestLCD_2/drivers/lcd2x16interface_v3_00_a/src/lcd2x16interface.h
* Version:           3.00.a
* Description:       lcd2x16interface Driver Header File
* Date:              Sun Nov 06 16:12:08 2022 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef LCD2X16INTERFACE_H
#define LCD2X16INTERFACE_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

#include "xparameters.h"
#include "lcd2x16interface.h"
#include "string.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 */
#define LCD2X16INTERFACE_USER_SLV_SPACE_OFFSET (0x00000000)
#define LCD2X16INTERFACE_SLV_REG0_OFFSET (LCD2X16INTERFACE_USER_SLV_SPACE_OFFSET + 0x00000000)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a LCD2X16INTERFACE register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the LCD2X16INTERFACE device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void LCD2X16INTERFACE_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define LCD2X16INTERFACE_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a LCD2X16INTERFACE register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the LCD2X16INTERFACE device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 LCD2X16INTERFACE_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define LCD2X16INTERFACE_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from LCD2X16INTERFACE user logic slave registers.
 *
 * @param   BaseAddress is the base address of the LCD2X16INTERFACE device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void LCD2X16INTERFACE_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 LCD2X16INTERFACE_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define LCD2X16INTERFACE_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (LCD2X16INTERFACE_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))

#define LCD2X16INTERFACE_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (LCD2X16INTERFACE_SLV_REG0_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the LCD2X16INTERFACE instance to be worked on.
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
XStatus LCD2X16INTERFACE_SelfTest(void * baseaddr_p);

void printLcd(const char* msg,u8 initaddr);
u32 invertbits(u32 n, u8 size);

#endif /** LCD2X16INTERFACE_H */
