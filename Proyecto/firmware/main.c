#include "xparameters.h"
#include "lcd2x16interface.h"
#include "xuartlite.h"
#include "xspi.h"
#include <stdio.h>
#include <stdlib.h>

#define delay_ms(n) for(i = n*10000; i!=0; --i)
#define SS_DAC 0x80000000
#define SS_ADC 0x40000000
#define SS_AMP 0x20000000

void write_DAC(XSpi *spi,u16 data,u8 addr,u8 comand);
void read_ADC(XSpi *spi,int *ch0, int *ch1);
u8 write_Gain(XSpi *spi,u8 value);



XUartLite uart;
XSpi spi;
u8 rxBuffer[8];
u8 txBuffer[8];

u32 volatile i = 0;

u8 volatile spi_buffer_tx[4];
u8 volatile spi_buffer_rx[4];


int main (void)
{
    int ch0,ch1;
    XUartLite_Initialize(&uart, XPAR_UARTLITE_1_DEVICE_ID); 
    XSpi_Initialize(&spi,XPAR_SPI_0_DEVICE_ID);
    write_Gain(&spi,0);

    while (1)
    {
        read_ADC(&spi,&ch0,&ch1);
        xil_printf("\nch0 = %d\nch1 = %d\n",ch0,ch1);
        delay_ms(500);
    }

    return 0;
}

void write_DAC(XSpi *spi,u16 data,u8 addr,u8 comand)
{
    txBuffer[0]=(data&0xff00)>>8;
    txBuffer[1]=((data&0xFFFe)<<8)|(addr>>4);
    txBuffer[2]=(addr<<5)|comand;
    txBuffer[3]=0;
    XSpi_SetSlaveSelect(spi, SS_DAC);
    XSpi_Transfer(spi,txBuffer,rxBuffer,4);
    XSpi_SetSlaveSelect(spi, 0);
}

u8 write_Gain(XSpi *spi,u8 value)
{
    txBuffer[0] = value;
    XSpi_SetSlaveSelect(spi, SS_AMP);
    XSpi_Transfer(spi,txBuffer,rxBuffer,1);
    XSpi_SetSlaveSelect(spi, 0);
    return rxBuffer[0]; 
}

void read_ADC(XSpi *spi,int *ch0, int *ch1)
{
    XSpi_SetSlaveSelect(spi, SS_ADC);
    XSpi_Transfer(spi,txBuffer,rxBuffer,5);
    XSpi_SetSlaveSelect(spi, 0);
    ch0 = ((rxBuffer[0]&0x1f)<<8)+rxBuffer[1];
    ch1 = ((rxBuffer[2]&0x3f)<<8)+(rxBuffer[1]>>1);
}
