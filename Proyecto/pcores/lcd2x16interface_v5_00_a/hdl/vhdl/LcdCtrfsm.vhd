LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY LcdCtrFsm IS
    PORT (
        clk, rst : IN STD_LOGIC;
        rdy, ack : IN STD_LOGIC;

        IReg : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
        data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        addr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        wr : OUT STD_LOGIC
    );
END LcdCtrFsm;

ARCHITECTURE arch OF LcdCtrFsm IS

    COMPONENT CtrLcdRam
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            IReg : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
            IAddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            OData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    TYPE lcd_fsm_states IS (WAIT_RDY, WRITE_DATA, wait_ack, next_char);

    SIGNAL lcd_curr_state : lcd_fsm_states;
    SIGNAL lcd_next_state : lcd_fsm_states;

    TYPE ram_type IS ARRAY(15 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram : ram_type;

    SIGNAL counter : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN

    CtrRam : CtrLcdRam
    PORT MAP(
        clk => clk,
        rst => rst,
        IReg => IReg,
        IAddr => counter,
        OData => data
    );

    lcdAddrCounter : PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF (rst = '1') THEN
                counter <= (OTHERS => '0');
            ELSIF lcd_curr_state = next_char THEN
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS; -- lcdAddrCounter
    lcd_fsm_state_transition_logic : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' THEN
                lcd_curr_state <= WAIT_RDY;
            ELSE
                lcd_curr_state <= lcd_next_state;
            END IF;
        END IF;
    END PROCESS;

    lcd_fsm_next_state_logic : PROCESS (lcd_curr_state, rdy, ack)
    BEGIN

        lcd_next_state <= lcd_curr_state;

        CASE lcd_curr_state IS

            WHEN WAIT_RDY =>
                IF rdy = '1' THEN
                    lcd_next_state <= WRITE_DATA;
                END IF;

            WHEN WRITE_DATA =>
                lcd_next_state <= WAIT_ACK;

            WHEN WAIT_ACK =>
                IF ack = '1' THEN
                    lcd_next_state <= next_char;
                END IF;

            WHEN next_char =>
                lcd_next_state <= WRITE_DATA;

            WHEN OTHERS =>
                lcd_next_state <= WAIT_RDY;

        END CASE;
    END PROCESS;

    addr <= counter;
    wr <= '1' WHEN lcd_curr_state = WRITE_DATA ELSE
        '0';
END ARCHITECTURE;