----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:15 11/07/2022 
-- Design Name: 
-- Module Name:    test_lcdinterface - arch 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY test_lcdinterface IS
    PORT (
        clk, rst : IN STD_LOGIC;
        data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        rs : OUT STD_LOGIC;
        en : OUT STD_LOGIC;
        rw : OUT STD_LOGIC;
        sfce : OUT STD_LOGIC
    );
END test_lcdinterface;

ARCHITECTURE arch OF test_lcdinterface IS
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
    SIGNAL counter : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL IReg : STD_LOGIC_VECTOR(12 DOWNTO 0);
BEGIN
    Inst_cldInterface : cldInterface PORT MAP(
        clk => clk,
        rst => rst,
        IReg => IReg,
        data => data,
        rs => rs,
        en => en,
        rw => rw,
        sfce => sfce
    );

    IReg <= counter & "0011" & counter(3 downto 0);

    PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF rst = '1' THEN
                counter <= (OTHERS => '0');
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;
END arch;