--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:58:16 12/18/2022
-- Design Name:   
-- Module Name:   Z:/SysEmp/ProyectoFinal/ProyectoFinalSDE/Proyecto/pcores/digilentspartan3e1600spi_v2_00_a/devl/projnav/TB_spi_slave_interface.vhd
-- Project Name:  digilentspartan3e1600spi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spi_slave_interface
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
 
ENTITY TB_spi_slave_interface IS
END TB_spi_slave_interface;
 
ARCHITECTURE behavior OF TB_spi_slave_interface IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spi_slave_interface
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Miso : IN  std_logic;
         Mosi : OUT  std_logic;
         Sck : OUT  std_logic;
         MB_Miso : OUT  std_logic;
         MB_Mosi : IN  std_logic;
         MB_Sck : IN  std_logic;
         MB_SS_DAC : IN  std_logic;
         MB_SS_ADC : IN  std_logic;
         MB_SS_AMP : IN  std_logic;
         MB_SS_Flash : IN  std_logic;
         CS_DAC : OUT  std_logic;
         CS_ADC : OUT  std_logic;
         CS_AMP : OUT  std_logic;
         CS_Flash : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal Miso : std_logic := '0';
   signal MB_Mosi : std_logic := '0';
   signal MB_Sck : std_logic := '0';
   signal MB_SS_DAC : std_logic := '1';
   signal MB_SS_ADC : std_logic := '1';
   signal MB_SS_AMP : std_logic := '1';
   signal MB_SS_Flash : std_logic := '1';

 	--Outputs
   signal Mosi : std_logic;
   signal Sck : std_logic;
   signal MB_Miso : std_logic;
   signal CS_DAC : std_logic;
   signal CS_ADC : std_logic;
   signal CS_AMP : std_logic;
   signal CS_Flash : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;

   constant Frame: std_logic_vector(33 downto 0) := "ZZ10101010101010ZZ01010101010101ZZ" ;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_slave_interface PORT MAP (
          clk => clk,
          rst => rst,
          Miso => Miso,
          Mosi => Mosi,
          Sck => Sck,
          MB_Miso => MB_Miso,
          MB_Mosi => MB_Mosi,
          MB_Sck => MB_Sck,
          MB_SS_DAC => MB_SS_DAC,
          MB_SS_ADC => MB_SS_ADC,
          MB_SS_AMP => MB_SS_AMP,
          MB_SS_Flash => MB_SS_Flash,
          CS_DAC => CS_DAC,
          CS_ADC => CS_ADC,
          CS_AMP => CS_AMP,
          CS_Flash => CS_Flash
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   sck_process :process
   begin
      MB_sck <= '0';
		wait for clk_period*2;
		MB_sck <= '1';
		wait for clk_period*2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      rst <= '0';
      wait for clk_period*10;
      MB_SS_ADC <= '0';

      ADC_Frame : for i in 0 to 33 loop
         wait until Sck = '1';
         Miso <= Frame(i);
      end loop ; -- ADC_Frame

      wait for (clk_period*2)*6;
      MB_SS_ADC <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
