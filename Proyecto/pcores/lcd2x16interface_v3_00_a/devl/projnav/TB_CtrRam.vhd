--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:47:42 11/07/2022
-- Design Name:   
-- Module Name:   Z:/SysEmp/test_MB_LCDCtr/TestLCD_2/pcores/lcd2x16interface_v3_00_a/devl/projnav/TB_CtrRam.vhd
-- Project Name:  lcd2x16interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CtrLcdRam
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
 
ENTITY TB_CtrRam IS
END TB_CtrRam;
 
ARCHITECTURE behavior OF TB_CtrRam IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CtrLcdRam
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         IReg : IN  std_logic_vector(12 downto 0);
         IAddr : IN  std_logic_vector(4 downto 0);
         OData : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal IReg : std_logic_vector(12 downto 0) := (others => '0');
   signal IAddr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal OData : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CtrLcdRam PORT MAP (
          clk => clk,
          rst => rst,
          IReg => IReg,
          IAddr => IAddr,
          OData => OData
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      rst <= '0';
      wait for clk_period*10;

      IReg <= "00000"& x"20";
      wait for clk_period * 3;
      IReg <= "00001"& x"21";
      wait for clk_period * 3;
      IReg <= "00010"& x"22";
      wait for clk_period * 20;
      IReg <= "00010"& x"22";
      IAddr <= "00010";

      wait for clk_period * 3;
      IAddr <= "00000";
      wait for clk_period * 3;
      IAddr <= "00001";
      wait for clk_period * 3;
      IAddr <= "00010";
      wait for clk_period * 3;
      IAddr <= "00011";

      wait;
   end process;

END;
