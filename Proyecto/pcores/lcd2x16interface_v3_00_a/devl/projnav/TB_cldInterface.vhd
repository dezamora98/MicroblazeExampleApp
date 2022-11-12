--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:50:32 11/07/2022
-- Design Name:   
-- Module Name:   Z:/SysEmp/test_MB_LCDCtr/TestLCD_2/pcores/lcd2x16interface_v3_00_a/devl/projnav/TB_cldInterface.vhd
-- Project Name:  lcd2x16interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cldInterface
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY TB_cldInterface IS
END TB_cldInterface;

ARCHITECTURE behavior OF TB_cldInterface IS

   -- Component Declaration for the Unit Under Test (UUT)

   COMPONENT cldInterface
      PORT (
         clk : IN STD_LOGIC;
         rst : IN STD_LOGIC;
         IReg : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
         data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         rs : OUT STD_LOGIC;
         en : OUT STD_LOGIC;
         rw : OUT STD_LOGIC;
         sfce : OUT STD_LOGIC
      );
   END COMPONENT;
   --Inputs
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL rst : STD_LOGIC := '0';
   SIGNAL IReg : STD_LOGIC_VECTOR(12 DOWNTO 0) := (OTHERS => '0');

   --Outputs
   SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL rs : STD_LOGIC;
   SIGNAL en : STD_LOGIC;
   SIGNAL rw : STD_LOGIC;
   SIGNAL sfce : STD_LOGIC;

   -- Clock period definitions
   CONSTANT clk_period : TIME := 10 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut : cldInterface PORT MAP(
      clk => clk,
      rst => rst,
      IReg => IReg,
      data => data,
      rs => rs,
      en => en,
      rw => rw,
      sfce => sfce
   );

   -- Clock process definitions
   clk_process : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period/2;
      clk <= '1';
      WAIT FOR clk_period/2;
   END PROCESS;
   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- hold reset state for 100 ns.
      WAIT FOR 60 ms;

      IReg <= "00000"& x"20";
      wait for clk_period * 3;
      IReg <= "00001"& x"21";
      wait for clk_period * 3;
      IReg <= "00010"& x"22";
      wait for clk_period * 20;
      IReg <= "00010"& x"22";


      WAIT FOR clk_period * 10;

      -- insert stimulus here 

      WAIT;
   END PROCESS;

END;