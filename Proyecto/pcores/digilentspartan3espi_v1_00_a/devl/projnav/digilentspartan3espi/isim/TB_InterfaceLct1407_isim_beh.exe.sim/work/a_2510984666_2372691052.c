/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xcb73ee62 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//VBoxSvr/WorkArea/SysEmp/ProyectoFinal/ProyectoFinalSDE/Proyecto/pcores/digilentspartan3espi_v1_00_a/hdl/vhdl/TB_InterfaceLct1407.vhd";



static void work_a_2510984666_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 2124U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 2508);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 40U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 1500U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 2024);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2508);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 40U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(95, ng0);
    t2 = (t0 + 1500U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 2024);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_2510984666_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int64 t8;
    int t9;
    int t10;
    unsigned char t11;
    unsigned char t12;
    int t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    t1 = (t0 + 2268U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(103, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 2168);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(104, ng0);
    t2 = (t0 + 2544);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(105, ng0);
    t2 = (t0 + 1500U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t8 = (t3 * 10);
    t2 = (t0 + 2168);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(106, ng0);
    t2 = (t0 + 2580);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(107, ng0);
    t2 = (t0 + 1500U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 2168);
    xsi_process_wait(t2, t3);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(108, ng0);
    t2 = (t0 + 2580);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(110, ng0);
    t2 = (t0 + 5958);
    *((int *)t2) = 0;
    t4 = (t0 + 5962);
    *((int *)t4) = 33;
    t9 = 0;
    t10 = 33;

LAB16:    if (t9 <= t10)
        goto LAB17;

LAB19:    xsi_set_current_line(115, ng0);

LAB27:    *((char **)t1) = &&LAB28;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB17:    xsi_set_current_line(111, ng0);

LAB22:    t5 = (t0 + 2464);
    *((int *)t5) = 1;
    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB18:    t2 = (t0 + 5958);
    t9 = *((int *)t2);
    t4 = (t0 + 5962);
    t10 = *((int *)t4);
    if (t9 == t10)
        goto LAB19;

LAB24:    t13 = (t9 + 1);
    t9 = t13;
    t5 = (t0 + 5958);
    *((int *)t5) = t9;
    goto LAB16;

LAB20:    t6 = (t0 + 2464);
    *((int *)t6) = 0;
    xsi_set_current_line(112, ng0);
    t2 = (t0 + 1568U);
    t4 = *((char **)t2);
    t2 = (t0 + 5958);
    t13 = *((int *)t2);
    t14 = (t13 - 33);
    t15 = (t14 * -1);
    xsi_vhdl_check_range_of_index(33, 0, -1, *((int *)t2));
    t16 = (1U * t15);
    t17 = (0 + t16);
    t5 = (t4 + t17);
    t11 = *((unsigned char *)t5);
    t6 = (t0 + 2616);
    t7 = (t6 + 32U);
    t18 = *((char **)t7);
    t19 = (t18 + 40U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t11;
    xsi_driver_first_trans_fast(t6);
    goto LAB18;

LAB21:    t6 = (t0 + 1144U);
    t7 = *((char **)t6);
    t11 = *((unsigned char *)t7);
    t12 = (t11 == (unsigned char)3);
    if (t12 == 1)
        goto LAB20;
    else
        goto LAB22;

LAB23:    goto LAB21;

LAB25:    goto LAB2;

LAB26:    goto LAB25;

LAB28:    goto LAB26;

}


extern void work_a_2510984666_2372691052_init()
{
	static char *pe[] = {(void *)work_a_2510984666_2372691052_p_0,(void *)work_a_2510984666_2372691052_p_1};
	xsi_register_didat("work_a_2510984666_2372691052", "isim/TB_InterfaceLct1407_isim_beh.exe.sim/work/a_2510984666_2372691052.didat");
	xsi_register_executes(pe);
}
