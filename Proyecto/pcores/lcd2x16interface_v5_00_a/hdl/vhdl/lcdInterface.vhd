LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cldInterface IS
    PORT (
        clk, rst : IN STD_LOGIC;
        IReg : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
        --lcd signals
        data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        rs : OUT STD_LOGIC;
        en : OUT STD_LOGIC;
        --configuration specific signals
        rw : OUT STD_LOGIC;
        sfce : OUT STD_LOGIC
    );
END cldInterface;

ARCHITECTURE arch OF cldInterface IS
    COMPONENT LcdCtrFsm
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            rdy : IN STD_LOGIC;
            ack : IN STD_LOGIC;
            IReg : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            addr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            wr : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT lcd
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            addr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            auto : IN STD_LOGIC;
            wr : IN STD_LOGIC;
            ack : OUT STD_LOGIC;
            rdy : OUT STD_LOGIC;
            data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rs : OUT STD_LOGIC;
            en : OUT STD_LOGIC;
            rw : OUT STD_LOGIC;
            sfce : OUT STD_LOGIC
        );
    END COMPONENT;

    signal rdy,wr, ack: std_logic;
    SIGNAL byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL addr : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

    Inst_LcdCtrFsm : LcdCtrFsm
	PORT MAP(
        clk =>clk,
        rst =>rst,
        rdy =>rdy,
        ack =>ack,
        IReg =>IReg,
        data =>byte,
        addr =>addr,
        wr => wr
    );
	
    Inst_lcd : lcd PORT MAP(
        clk =>clk,
        rst =>rst,
        byte =>byte,
        addr =>addr,
        auto =>'0',
        wr =>wr,
        ack =>ack,
        rdy =>rdy,
        data =>data,
        rs => rs,
        en => en,
        rw => rw,
        sfce => sfce
    );
END ARCHITECTURE;