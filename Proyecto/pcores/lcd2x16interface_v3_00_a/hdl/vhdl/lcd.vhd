----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:31:55 02/27/2019 
-- Design Name: 
-- Module Name:    lcd - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY lcd IS
	PORT (
		--system signals
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		--host signals
		byte : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		addr : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		auto : IN STD_LOGIC;
		wr : IN STD_LOGIC;
		ack : OUT STD_LOGIC;
		rdy : OUT STD_LOGIC;
		--lcd signals
		data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		rs : OUT STD_LOGIC;
		en : OUT STD_LOGIC;
		--configuration specific signals
		rw : OUT STD_LOGIC;
		sfce : OUT STD_LOGIC
	);
END lcd;

ARCHITECTURE Behavioral OF lcd IS

	COMPONENT lcd_host_if
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			addr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			auto : IN STD_LOGIC;
			wr : IN STD_LOGIC;
			done : IN STD_LOGIC;
			ack : OUT STD_LOGIC;
			byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			mode : OUT STD_LOGIC;
			stb : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT lcd_init_fsm
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			done : IN STD_LOGIC;
			rdy : OUT STD_LOGIC;
			byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			mode : OUT STD_LOGIC;
			stb : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT lcd_tx_fsm
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			stb : IN STD_LOGIC;
			mode : IN STD_LOGIC;
			done : OUT STD_LOGIC;
			data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			rs : OUT STD_LOGIC;
			en : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL lcdrdy : STD_LOGIC;

	SIGNAL txstb : STD_LOGIC;
	SIGNAL hstb : STD_LOGIC;
	SIGNAL istb : STD_LOGIC;
	SIGNAL txmode : STD_LOGIC;
	SIGNAL hmode : STD_LOGIC;
	SIGNAL imode : STD_LOGIC;
	SIGNAL txdone : STD_LOGIC;

	SIGNAL txbyte : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL hbyte : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ibyte : STD_LOGIC_VECTOR(7 DOWNTO 0);

	CONSTANT LCD_WRITE_ONLY : STD_LOGIC := '0';
	CONSTANT SF_DISABLED : STD_LOGIC := '1';

BEGIN

	rw <= LCD_WRITE_ONLY;
	sfce <= SF_DISABLED;

	rdy <= lcdrdy;

	txstb <= istb WHEN lcdrdy = '0' ELSE
		hstb;
	txmode <= imode WHEN lcdrdy = '0' ELSE
		hmode;
	txbyte <= ibyte WHEN lcdrdy = '0' ELSE
		hbyte;

	Inst_lcd_tx_fsm : lcd_tx_fsm PORT MAP(
		clk => clk,
		rst => rst,
		byte => txbyte,
		stb => txstb,
		mode => txmode,
		done => txdone,
		data => data,
		rs => rs,
		en => en
	);

	Inst_lcd_init_fsm : lcd_init_fsm PORT MAP(
		clk => clk,
		rst => rst,
		rdy => lcdrdy,
		byte => ibyte,
		stb => istb,
		mode => imode,
		done => txdone
	);

	Inst_lcd_host_if : lcd_host_if PORT MAP(
		clk => clk,
		rst => rst,
		data => byte,
		addr => addr,
		auto => auto,
		wr => wr,
		ack => ack,
		byte => hbyte,
		stb => hstb,
		mode => hmode,
		done => txdone
	);

END Behavioral;