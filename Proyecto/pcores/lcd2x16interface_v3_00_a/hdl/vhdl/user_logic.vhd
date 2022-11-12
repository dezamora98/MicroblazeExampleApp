------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
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
-- Filename:          user_logic.vhd
-- Version:           3.00.a
-- Description:       User logic.
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

-- DO NOT EDIT BELOW THIS LINE --------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY proc_common_v3_00_a;
USE proc_common_v3_00_a.proc_common_pkg.ALL;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--   C_NUM_REG                    -- Number of software accessible registers
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

ENTITY user_logic IS
  GENERIC (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_SLV_DWIDTH : INTEGER := 32;
    C_NUM_REG : INTEGER := 1
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
    Bus2IP_Clk : IN STD_LOGIC;
    Bus2IP_Reset : IN STD_LOGIC;
    Bus2IP_Data : IN STD_LOGIC_VECTOR(0 TO C_SLV_DWIDTH - 1);
    Bus2IP_BE : IN STD_LOGIC_VECTOR(0 TO C_SLV_DWIDTH/8 - 1);
    Bus2IP_RdCE : IN STD_LOGIC_VECTOR(0 TO C_NUM_REG - 1);
    Bus2IP_WrCE : IN STD_LOGIC_VECTOR(0 TO C_NUM_REG - 1);
    IP2Bus_Data : OUT STD_LOGIC_VECTOR(0 TO C_SLV_DWIDTH - 1);
    IP2Bus_RdAck : OUT STD_LOGIC;
    IP2Bus_WrAck : OUT STD_LOGIC;
    IP2Bus_Error : OUT STD_LOGIC
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  ATTRIBUTE SIGIS : STRING;
  ATTRIBUTE SIGIS OF Bus2IP_Clk : SIGNAL IS "CLK";
  ATTRIBUTE SIGIS OF Bus2IP_Reset : SIGNAL IS "RST";

END ENTITY user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

ARCHITECTURE IMP OF user_logic IS

  --USER signal declarations added here, as needed for user logic

  COMPONENT cldInterface
    PORT (
      clk, rst : IN STD_LOGIC;
      addr_char : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      char : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_char : IN STD_LOGIC;

      --lcd signals
      data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      rs : OUT STD_LOGIC;
      en : OUT STD_LOGIC;
      --configuration specific signals
      rw : OUT STD_LOGIC;
      sfce : OUT STD_LOGIC
    );
  END COMPONENT;

  SIGNAL Bus2P_WrCE_end : STD_LOGIC;
  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  SIGNAL slv_reg0 : STD_LOGIC_VECTOR(0 TO C_SLV_DWIDTH - 1);
  SIGNAL slv_reg_write_sel : STD_LOGIC_VECTOR(0 TO 0);
  SIGNAL slv_reg_read_sel : STD_LOGIC_VECTOR(0 TO 0);
  SIGNAL slv_ip2bus_data : STD_LOGIC_VECTOR(0 TO C_SLV_DWIDTH - 1);
  SIGNAL slv_read_ack : STD_LOGIC;
  SIGNAL slv_write_ack : STD_LOGIC;

BEGIN

  --USER logic implementation added here

  Inst_cldInterface : cldInterface PORT MAP(
    clk => Bus2IP_Clk,
    rst => Bus2IP_Reset,

    addr_char(0) => slv_reg0(8),
    addr_char(1) => slv_reg0(9),
    addr_char(2) => slv_reg0(10),
    addr_char(3) => slv_reg0(11),
    addr_char(4) => slv_reg0(12),

    char(0) => slv_reg0(0),
    char(1) => slv_reg0(1),
    char(2) => slv_reg0(2),
    char(3) => slv_reg0(3),
    char(4) => slv_reg0(4),
    char(5) => slv_reg0(5),
    char(6) => slv_reg0(6),
    char(7) => slv_reg0(7),

    wr_char => Bus2P_WrCE_end,

    data => data,
    rs => rs,
    en => en,
    rw => rw,
    sfce => sfce
  );
  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(0 TO 0);
  slv_reg_read_sel <= Bus2IP_RdCE(0 TO 0);
  slv_write_ack <= Bus2IP_WrCE(0);
  slv_read_ack <= Bus2IP_RdCE(0);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : PROCESS (Bus2IP_Clk) IS
  BEGIN
    IF Bus2IP_Clk'event AND Bus2IP_Clk = '1' THEN

      IF Bus2IP_Reset = '1' THEN
        slv_reg0 <= (OTHERS => '0');

      ELSIF slv_reg_write_sel = "1" THEN

        FOR byte_index IN 0 TO (C_SLV_DWIDTH/8) - 1 LOOP
          IF (Bus2IP_BE(byte_index) = '1') THEN
            slv_reg0(byte_index * 8 TO byte_index * 8 + 7) <= Bus2IP_Data(byte_index * 8 TO byte_index * 8 + 7);
          END IF;
        END LOOP;

        Bus2P_WrCE_end <= '1';
      ELSE
        Bus2P_WrCE_end <= '0';
      END IF;
    END IF;
  END PROCESS SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : PROCESS (slv_reg_read_sel, slv_reg0) IS
  BEGIN

    CASE slv_reg_read_sel IS
      WHEN "1" => slv_ip2bus_data <= slv_reg0;
      WHEN OTHERS => slv_ip2bus_data <= (OTHERS => '0');
    END CASE;

  END PROCESS SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data <= slv_ip2bus_data WHEN slv_read_ack = '1' ELSE
    (OTHERS => '0');

  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';

END IMP;