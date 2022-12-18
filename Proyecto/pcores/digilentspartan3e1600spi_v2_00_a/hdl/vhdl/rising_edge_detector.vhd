----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:36:45 02/13/2016 
-- Design Name: 
-- Module Name:    rising_edge_detector - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rising_edge_detector is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           level : in  STD_LOGIC;
           pulse : out  STD_LOGIC);
end rising_edge_detector;

architecture Behavioral of rising_edge_detector is
type rising_edge_detector_fsm_states is (ZERO, EDGE, ONE);

signal rising_edge_detector_fsm_curr_st : rising_edge_detector_fsm_states;
signal rising_edge_detector_fsm_next_st : rising_edge_detector_fsm_states;

begin

rising_edge_state_transition_logic: process(clk, rst)
begin
if rising_edge(clk) then
	if rst = '1' then
		rising_edge_detector_fsm_curr_st <= ZERO; 
	else
		rising_edge_detector_fsm_curr_st <= rising_edge_detector_fsm_next_st; 
	end if;
end if;	
end process;

rising_edge_next_state_logic: process(level, rising_edge_detector_fsm_curr_st)
begin
	rising_edge_detector_fsm_next_st <= rising_edge_detector_fsm_curr_st;
	case rising_edge_detector_fsm_curr_st is
	
		when ZERO =>
			if level = '1' then
				rising_edge_detector_fsm_next_st <= EDGE;
			end if;
			
		when EDGE =>
			if level = '1' then
				rising_edge_detector_fsm_next_st <= ONE;
			else
				rising_edge_detector_fsm_next_st <= ZERO;
			end if;			
		
		when ONE =>
			if level = '0' then
				rising_edge_detector_fsm_next_st <= ZERO;
			end if;
		
	end case;
end process;

rising_edge_output_logic: process(rising_edge_detector_fsm_curr_st)
begin
	pulse <= '0';
	if rising_edge_detector_fsm_curr_st = EDGE then
		pulse <= '1';
	end if;
end process;

end Behavioral;

