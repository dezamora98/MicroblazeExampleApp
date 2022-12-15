#ifndef LCD2X16SINTERFACE_H
#define LCD2X16SINTERFACE_H

#include "xparameters.h"
#include "lcd2x16interface.h"
#include "string.h"

void printLcd(const char* msg,u8 initaddr);
u32 invertbits(u32 n, u8 size);


#endif /** LCD2X16SINTERFACE_H */