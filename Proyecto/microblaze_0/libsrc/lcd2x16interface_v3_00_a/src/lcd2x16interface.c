/*****************************************************************************
* Filename:          Z:\SysEmp\test_MB_LCDCtr\TestLCD_2/drivers/lcd2x16interface_v3_00_a/src/lcd2x16interface.c
* Version:           3.00.a
* Description:       lcd2x16interface Driver Source File
* Date:              Sun Nov 06 16:12:08 2022 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "lcd2x16interface.h"

void printLcd(const char* msg,u8 initaddr)
{
    u32 i;
    u32 size = strlen(msg) + initaddr;
    u32 charLcd;
    u32 addrLcd;
    u32 data;

    for(i = initaddr; i != size; ++i)
    {
        charLcd = invertbits(msg[i-initaddr],8);
        addrLcd = invertbits(i,5);
        data = ((charLcd << 5) | addrLcd);
		data <<= 19; 
        LCD2X16INTERFACE_mWriteReg(XPAR_LCD2X16INTERFACE_0_BASEADDR,1,data);
    }

}
u32 invertbits(u32 n, u8 size)
{
    int pos = size - 1;     // mantiene el turno
 
    // almacenar bits invertidos de `n`. Inicialmente, todos los bits se establecen en 0
    int reverse = 0;
 
    // hacer hasta que se procesen todos los bits
    while (pos >= 0 && n)
    {
        // si el bit actual es 1, establezca el bit correspondiente en el resultado
        if (n & 1) {
            reverse = reverse | (1 << pos);
        }
 
        n >>= 1;                // elimina el bit actual
        pos--;                  // decrementa el turno en 1
    }
 
    return reverse;
}


/************************** Function Definitions ***************************/

