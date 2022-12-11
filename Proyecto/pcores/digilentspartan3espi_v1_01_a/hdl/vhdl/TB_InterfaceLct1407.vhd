--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:18:24 12/08/2022
-- Design Name:   
-- Module Name:   Z:/SysEmp/ProyectoFinal/ProyectoFinalSDE/Proyecto/pcores/digilentspartan3espi_v1_00_a/devl/projnav/TB_InterfaceLct1407.vhd
-- Project Name:  digilentspartan3espi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InterfaceLct1407
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
 
ENTITY TB_InterfaceLct1407 IS
END TB_InterfaceLct1407;
 
ARCHITECTURE behavior OF TB_InterfaceLct1407 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InterfaceLct1407
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Cs : IN  std_logic;
		 Ack: out std_logic;
         Miso : IN  std_logic;
         Conv : OUT  std_logic;
         Sck : OUT  std_logic;
         DataCh0 : OUT  std_logic_vector(13 downto 0);
         DataCh1 : OUT  std_logic_vector(13 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '1';
   signal Cs : std_logic := '0';
   signal Miso : std_logic := '0';

 	--Outputs
   signal Ack: std_logic;
   signal Conv : std_logic;
   signal Sck : std_logic;
   signal DataCh0 : std_logic_vector(13 downto 0);
   signal DataCh1 : std_logic_vector(13 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
   constant Frame: std_logic_vector(33 downto 0) := "ZZ10101010101010ZZ01010101010101ZZ" ;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InterfaceLct1407 PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Cs => Cs,
		  Ack => Ack,
          Miso => Miso,
          Conv => Conv,
          Sck => Sck,
          DataCh0 => DataCh0,
          DataCh1 => DataCh1
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      rst <= '0';
      wait for Clk_period*10;
      Cs <= '1';
      wait for Clk_period;
      Cs <= '0';
      
      ADC_Frame : for i in 0 to 33 loop
         wait until Sck = '1';
         Miso <= Frame(i);
      end loop ; -- ADC_Frame
	  
      wait;
   end process;

END;
