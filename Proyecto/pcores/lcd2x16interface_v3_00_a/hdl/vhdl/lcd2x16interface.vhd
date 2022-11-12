------------------------------------------------------------------------------
-- lcd2x16interface.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          lcd2x16interface.vhd
-- Version:           3.00.a
-- Description:       Top level design, instantiates library components and user logic.
-- Date:              Sun Nov 06 16:12:05 2022 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY proc_common_v3_00_a;
USE proc_common_v3_00_a.proc_common_pkg.ALL;
USE proc_common_v3_00_a.ipif_pkg.ALL;

LIBRARY plbv46_slave_single_v1_01_a;
USE plbv46_slave_single_v1_01_a.plbv46_slave_single;

LIBRARY lcd2x16interface_v3_00_a;
USE lcd2x16interface_v3_00_a.user_logic;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_BASEADDR                   -- PLBv46 slave: base address
--   C_HIGHADDR                   -- PLBv46 slave: high address
--   C_SPLB_AWIDTH                -- PLBv46 slave: address bus width
--   C_SPLB_DWIDTH                -- PLBv46 slave: data bus width
--   C_SPLB_NUM_MASTERS           -- PLBv46 slave: Number of masters
--   C_SPLB_MID_WIDTH             -- PLBv46 slave: master ID bus width
--   C_SPLB_NATIVE_DWIDTH         -- PLBv46 slave: internal native data bus width
--   C_SPLB_P2P                   -- PLBv46 slave: point to point interconnect scheme
--   C_SPLB_SUPPORT_BURSTS        -- PLBv46 slave: support bursts
--   C_SPLB_SMALLEST_MASTER       -- PLBv46 slave: width of the smallest master
--   C_SPLB_CLK_PERIOD_PS         -- PLBv46 slave: bus clock in picoseconds
--   C_INCLUDE_DPHASE_TIMER       -- PLBv46 slave: Data Phase Timer configuration; 0 = exclude timer, 1 = include timer
--   C_FAMILY                     -- Xilinx FPGA family
--
-- Definition of Ports:
--   SPLB_Clk                     -- PLB main bus clock
--   SPLB_Rst                     -- PLB main bus reset
--   PLB_ABus                     -- PLB address bus
--   PLB_UABus                    -- PLB upper address bus
--   PLB_PAValid                  -- PLB primary address valid indicator
--   PLB_SAValid                  -- PLB secondary address valid indicator
--   PLB_rdPrim                   -- PLB secondary to primary read request indicator
--   PLB_wrPrim                   -- PLB secondary to primary write request indicator
--   PLB_masterID                 -- PLB current master identifier
--   PLB_abort                    -- PLB abort request indicator
--   PLB_busLock                  -- PLB bus lock
--   PLB_RNW                      -- PLB read/not write
--   PLB_BE                       -- PLB byte enables
--   PLB_MSize                    -- PLB master data bus size
--   PLB_size                     -- PLB transfer size
--   PLB_type                     -- PLB transfer type
--   PLB_lockErr                  -- PLB lock error indicator
--   PLB_wrDBus                   -- PLB write data bus
--   PLB_wrBurst                  -- PLB burst write transfer indicator
--   PLB_rdBurst                  -- PLB burst read transfer indicator
--   PLB_wrPendReq                -- PLB write pending bus request indicator
--   PLB_rdPendReq                -- PLB read pending bus request indicator
--   PLB_wrPendPri                -- PLB write pending request priority
--   PLB_rdPendPri                -- PLB read pending request priority
--   PLB_reqPri                   -- PLB current request priority
--   PLB_TAttribute               -- PLB transfer attribute
--   Sl_addrAck                   -- Slave address acknowledge
--   Sl_SSize                     -- Slave data bus size
--   Sl_wait                      -- Slave wait indicator
--   Sl_rearbitrate               -- Slave re-arbitrate bus indicator
--   Sl_wrDAck                    -- Slave write data acknowledge
--   Sl_wrComp                    -- Slave write transfer complete indicator
--   Sl_wrBTerm                   -- Slave terminate write burst transfer
--   Sl_rdDBus                    -- Slave read data bus
--   Sl_rdWdAddr                  -- Slave read word address
--   Sl_rdDAck                    -- Slave read data acknowledge
--   Sl_rdComp                    -- Slave read transfer complete indicator
--   Sl_rdBTerm                   -- Slave terminate read burst transfer
--   Sl_MBusy                     -- Slave busy indicator
--   Sl_MWrErr                    -- Slave write error indicator
--   Sl_MRdErr                    -- Slave read error indicator
--   Sl_MIRQ                      -- Slave interrupt indicator
------------------------------------------------------------------------------

ENTITY lcd2x16interface IS
  GENERIC (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR : STD_LOGIC_VECTOR := X"FFFFFFFF";
    C_HIGHADDR : STD_LOGIC_VECTOR := X"00000000";
    C_SPLB_AWIDTH : INTEGER := 32;
    C_SPLB_DWIDTH : INTEGER := 128;
    C_SPLB_NUM_MASTERS : INTEGER := 8;
    C_SPLB_MID_WIDTH : INTEGER := 3;
    C_SPLB_NATIVE_DWIDTH : INTEGER := 32;
    C_SPLB_P2P : INTEGER := 0;
    C_SPLB_SUPPORT_BURSTS : INTEGER := 0;
    C_SPLB_SMALLEST_MASTER : INTEGER := 32;
    C_SPLB_CLK_PERIOD_PS : INTEGER := 10000;
    C_INCLUDE_DPHASE_TIMER : INTEGER := 0;
    C_FAMILY : STRING := "virtex5"
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  PORT (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rs : OUT STD_LOGIC;
    en : OUT STD_LOGIC;
    rw : OUT STD_LOGIC;
    sfce : OUT STD_LOGIC;
    --USER ports added here
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    SPLB_Clk : IN STD_LOGIC;
    SPLB_Rst : IN STD_LOGIC;
    PLB_ABus : IN STD_LOGIC_VECTOR(0 TO 31);
    PLB_UABus : IN STD_LOGIC_VECTOR(0 TO 31);
    PLB_PAValid : IN STD_LOGIC;
    PLB_SAValid : IN STD_LOGIC;
    PLB_rdPrim : IN STD_LOGIC;
    PLB_wrPrim : IN STD_LOGIC;
    PLB_masterID : IN STD_LOGIC_VECTOR(0 TO C_SPLB_MID_WIDTH - 1);
    PLB_abort : IN STD_LOGIC;
    PLB_busLock : IN STD_LOGIC;
    PLB_RNW : IN STD_LOGIC;
    PLB_BE : IN STD_LOGIC_VECTOR(0 TO C_SPLB_DWIDTH/8 - 1);
    PLB_MSize : IN STD_LOGIC_VECTOR(0 TO 1);
    PLB_size : IN STD_LOGIC_VECTOR(0 TO 3);
    PLB_type : IN STD_LOGIC_VECTOR(0 TO 2);
    PLB_lockErr : IN STD_LOGIC;
    PLB_wrDBus : IN STD_LOGIC_VECTOR(0 TO C_SPLB_DWIDTH - 1);
    PLB_wrBurst : IN STD_LOGIC;
    PLB_rdBurst : IN STD_LOGIC;
    PLB_wrPendReq : IN STD_LOGIC;
    PLB_rdPendReq : IN STD_LOGIC;
    PLB_wrPendPri : IN STD_LOGIC_VECTOR(0 TO 1);
    PLB_rdPendPri : IN STD_LOGIC_VECTOR(0 TO 1);
    PLB_reqPri : IN STD_LOGIC_VECTOR(0 TO 1);
    PLB_TAttribute : IN STD_LOGIC_VECTOR(0 TO 15);
    Sl_addrAck : OUT STD_LOGIC;
    Sl_SSize : OUT STD_LOGIC_VECTOR(0 TO 1);
    Sl_wait : OUT STD_LOGIC;
    Sl_rearbitrate : OUT STD_LOGIC;
    Sl_wrDAck : OUT STD_LOGIC;
    Sl_wrComp : OUT STD_LOGIC;
    Sl_wrBTerm : OUT STD_LOGIC;
    Sl_rdDBus : OUT STD_LOGIC_VECTOR(0 TO C_SPLB_DWIDTH - 1);
    Sl_rdWdAddr : OUT STD_LOGIC_VECTOR(0 TO 3);
    Sl_rdDAck : OUT STD_LOGIC;
    Sl_rdComp : OUT STD_LOGIC;
    Sl_rdBTerm : OUT STD_LOGIC;
    Sl_MBusy : OUT STD_LOGIC_VECTOR(0 TO C_SPLB_NUM_MASTERS - 1);
    Sl_MWrErr : OUT STD_LOGIC_VECTOR(0 TO C_SPLB_NUM_MASTERS - 1);
    Sl_MRdErr : OUT STD_LOGIC_VECTOR(0 TO C_SPLB_NUM_MASTERS - 1);
    Sl_MIRQ : OUT STD_LOGIC_VECTOR(0 TO C_SPLB_NUM_MASTERS - 1)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  ATTRIBUTE SIGIS : STRING;
  ATTRIBUTE SIGIS OF SPLB_Clk : SIGNAL IS "CLK";
  ATTRIBUTE SIGIS OF SPLB_Rst : SIGNAL IS "RST";

END ENTITY lcd2x16interface;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

ARCHITECTURE IMP OF lcd2x16interface IS

  ------------------------------------------
  -- Array of base/high address pairs for each address range
  ------------------------------------------
  CONSTANT ZERO_ADDR_PAD : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');
  CONSTANT USER_SLV_BASEADDR : STD_LOGIC_VECTOR := C_BASEADDR;
  CONSTANT USER_SLV_HIGHADDR : STD_LOGIC_VECTOR := C_HIGHADDR;

  CONSTANT IPIF_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
  (
  ZERO_ADDR_PAD & USER_SLV_BASEADDR, -- user logic slave space base address
  ZERO_ADDR_PAD & USER_SLV_HIGHADDR -- user logic slave space high address
  );

  ------------------------------------------
  -- Array of desired number of chip enables for each address range
  ------------------------------------------
  CONSTANT USER_SLV_NUM_REG : INTEGER := 1;
  CONSTANT USER_NUM_REG : INTEGER := USER_SLV_NUM_REG;

  CONSTANT IPIF_ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE :=
  (
  0 => pad_power2(USER_SLV_NUM_REG) -- number of ce for user logic slave space
  );

  ------------------------------------------
  -- Ratio of bus clock to core clock (for use in dual clock systems)
  -- 1 = ratio is 1:1
  -- 2 = ratio is 2:1
  ------------------------------------------
  CONSTANT IPIF_BUS2CORE_CLK_RATIO : INTEGER := 1;

  ------------------------------------------
  -- Width of the slave data bus (32 only)
  ------------------------------------------
  CONSTANT USER_SLV_DWIDTH : INTEGER := C_SPLB_NATIVE_DWIDTH;

  CONSTANT IPIF_SLV_DWIDTH : INTEGER := C_SPLB_NATIVE_DWIDTH;

  ------------------------------------------
  -- Index for CS/CE
  ------------------------------------------
  CONSTANT USER_SLV_CS_INDEX : INTEGER := 0;
  CONSTANT USER_SLV_CE_INDEX : INTEGER := calc_start_ce_index(IPIF_ARD_NUM_CE_ARRAY, USER_SLV_CS_INDEX);

  CONSTANT USER_CE_INDEX : INTEGER := USER_SLV_CE_INDEX;

  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations
  ------------------------------------------
  SIGNAL ipif_Bus2IP_Clk : STD_LOGIC;
  SIGNAL ipif_Bus2IP_Reset : STD_LOGIC;
  SIGNAL ipif_IP2Bus_Data : STD_LOGIC_VECTOR(0 TO IPIF_SLV_DWIDTH - 1);
  SIGNAL ipif_IP2Bus_WrAck : STD_LOGIC;
  SIGNAL ipif_IP2Bus_RdAck : STD_LOGIC;
  SIGNAL ipif_IP2Bus_Error : STD_LOGIC;
  SIGNAL ipif_Bus2IP_Addr : STD_LOGIC_VECTOR(0 TO C_SPLB_AWIDTH - 1);
  SIGNAL ipif_Bus2IP_Data : STD_LOGIC_VECTOR(0 TO IPIF_SLV_DWIDTH - 1);
  SIGNAL ipif_Bus2IP_RNW : STD_LOGIC;
  SIGNAL ipif_Bus2IP_BE : STD_LOGIC_VECTOR(0 TO IPIF_SLV_DWIDTH/8 - 1);
  SIGNAL ipif_Bus2IP_CS : STD_LOGIC_VECTOR(0 TO ((IPIF_ARD_ADDR_RANGE_ARRAY'length)/2) - 1);
  SIGNAL ipif_Bus2IP_RdCE : STD_LOGIC_VECTOR(0 TO calc_num_ce(IPIF_ARD_NUM_CE_ARRAY) - 1);
  SIGNAL ipif_Bus2IP_WrCE : STD_LOGIC_VECTOR(0 TO calc_num_ce(IPIF_ARD_NUM_CE_ARRAY) - 1);
  SIGNAL user_Bus2IP_RdCE : STD_LOGIC_VECTOR(0 TO USER_NUM_REG - 1);
  SIGNAL user_Bus2IP_WrCE : STD_LOGIC_VECTOR(0 TO USER_NUM_REG - 1);
  SIGNAL user_IP2Bus_Data : STD_LOGIC_VECTOR(0 TO USER_SLV_DWIDTH - 1);
  SIGNAL user_IP2Bus_RdAck : STD_LOGIC;
  SIGNAL user_IP2Bus_WrAck : STD_LOGIC;
  SIGNAL user_IP2Bus_Error : STD_LOGIC;

BEGIN

  ------------------------------------------
  -- instantiate plbv46_slave_single
  ------------------------------------------
  PLBV46_SLAVE_SINGLE_I : ENTITY plbv46_slave_single_v1_01_a.plbv46_slave_single
    GENERIC MAP
    (
      C_ARD_ADDR_RANGE_ARRAY => IPIF_ARD_ADDR_RANGE_ARRAY,
      C_ARD_NUM_CE_ARRAY => IPIF_ARD_NUM_CE_ARRAY,
      C_SPLB_P2P => C_SPLB_P2P,
      C_BUS2CORE_CLK_RATIO => IPIF_BUS2CORE_CLK_RATIO,
      C_SPLB_MID_WIDTH => C_SPLB_MID_WIDTH,
      C_SPLB_NUM_MASTERS => C_SPLB_NUM_MASTERS,
      C_SPLB_AWIDTH => C_SPLB_AWIDTH,
      C_SPLB_DWIDTH => C_SPLB_DWIDTH,
      C_SIPIF_DWIDTH => IPIF_SLV_DWIDTH,
      C_INCLUDE_DPHASE_TIMER => C_INCLUDE_DPHASE_TIMER,
      C_FAMILY => C_FAMILY
    )
    PORT MAP
    (
      SPLB_Clk => SPLB_Clk,
      SPLB_Rst => SPLB_Rst,
      PLB_ABus => PLB_ABus,
      PLB_UABus => PLB_UABus,
      PLB_PAValid => PLB_PAValid,
      PLB_SAValid => PLB_SAValid,
      PLB_rdPrim => PLB_rdPrim,
      PLB_wrPrim => PLB_wrPrim,
      PLB_masterID => PLB_masterID,
      PLB_abort => PLB_abort,
      PLB_busLock => PLB_busLock,
      PLB_RNW => PLB_RNW,
      PLB_BE => PLB_BE,
      PLB_MSize => PLB_MSize,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_lockErr => PLB_lockErr,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrBurst => PLB_wrBurst,
      PLB_rdBurst => PLB_rdBurst,
      PLB_wrPendReq => PLB_wrPendReq,
      PLB_rdPendReq => PLB_rdPendReq,
      PLB_wrPendPri => PLB_wrPendPri,
      PLB_rdPendPri => PLB_rdPendPri,
      PLB_reqPri => PLB_reqPri,
      PLB_TAttribute => PLB_TAttribute,
      Sl_addrAck => Sl_addrAck,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_wrDAck => Sl_wrDAck,
      Sl_wrComp => Sl_wrComp,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdComp => Sl_rdComp,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_MBusy => Sl_MBusy,
      Sl_MWrErr => Sl_MWrErr,
      Sl_MRdErr => Sl_MRdErr,
      Sl_MIRQ => Sl_MIRQ,
      Bus2IP_Clk => ipif_Bus2IP_Clk,
      Bus2IP_Reset => ipif_Bus2IP_Reset,
      IP2Bus_Data => ipif_IP2Bus_Data,
      IP2Bus_WrAck => ipif_IP2Bus_WrAck,
      IP2Bus_RdAck => ipif_IP2Bus_RdAck,
      IP2Bus_Error => ipif_IP2Bus_Error,
      Bus2IP_Addr => ipif_Bus2IP_Addr,
      Bus2IP_Data => ipif_Bus2IP_Data,
      Bus2IP_RNW => ipif_Bus2IP_RNW,
      Bus2IP_BE => ipif_Bus2IP_BE,
      Bus2IP_CS => ipif_Bus2IP_CS,
      Bus2IP_RdCE => ipif_Bus2IP_RdCE,
      Bus2IP_WrCE => ipif_Bus2IP_WrCE
    );

  ------------------------------------------
  -- instantiate User Logic
  ------------------------------------------
  USER_LOGIC_I : ENTITY lcd2x16interface_v3_00_a.user_logic
    GENERIC MAP
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_SLV_DWIDTH => USER_SLV_DWIDTH,
      C_NUM_REG => USER_NUM_REG
    )
    PORT MAP
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------
      data => data,
      rs => rs,
      en => en,
      rw => rw,
      sfce => sfce,
      --USER ports mapped here
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      Bus2IP_Clk => ipif_Bus2IP_Clk,
      Bus2IP_Reset => ipif_Bus2IP_Reset,
      Bus2IP_Data => ipif_Bus2IP_Data,
      Bus2IP_BE => ipif_Bus2IP_BE,
      Bus2IP_RdCE => user_Bus2IP_RdCE,
      Bus2IP_WrCE => user_Bus2IP_WrCE,
      IP2Bus_Data => user_IP2Bus_Data,
      IP2Bus_RdAck => user_IP2Bus_RdAck,
      IP2Bus_WrAck => user_IP2Bus_WrAck,
      IP2Bus_Error => user_IP2Bus_Error
    );

  ------------------------------------------
  -- connect internal signals
  ------------------------------------------
  ipif_IP2Bus_Data <= user_IP2Bus_Data;
  ipif_IP2Bus_WrAck <= user_IP2Bus_WrAck;
  ipif_IP2Bus_RdAck <= user_IP2Bus_RdAck;
  ipif_IP2Bus_Error <= user_IP2Bus_Error;

  user_Bus2IP_RdCE <= ipif_Bus2IP_RdCE(USER_CE_INDEX TO USER_CE_INDEX + USER_NUM_REG - 1);
  user_Bus2IP_WrCE <= ipif_Bus2IP_WrCE(USER_CE_INDEX TO USER_CE_INDEX + USER_NUM_REG - 1);

END IMP;