LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY CtrLcdRam IS
    PORT (
        clk, rst : IN STD_LOGIC;
        IReg : IN STD_LOGIC_VECTOR(12 DOWNTO 0);

        IAddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        OData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END CtrLcdRam;

ARCHITECTURE arch OF CtrLcdRam IS
    COMPONENT LcdRam
        PORT (
            clka : IN STD_LOGIC;
            wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            clkb : IN STD_LOGIC;
            addrb : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    --ATTRIBUTE syn_black_box : BOOLEAN;
    --ATTRIBUTE syn_black_box OF LcdRam : COMPONENT IS true;

    TYPE fsm_states IS (checkIReg, saveData);

    SIGNAL fsm_curr_state, fsm_next_state : fsm_states;

    SIGNAL LastIReg : STD_LOGIC_VECTOR(12 DOWNTO 0);
    SIGNAL DataIReg : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL wea : STD_LOGIC_VECTOR(0 DOWNTO 0);

BEGIN

    RAM : LcdRam
    PORT MAP(
        clka => clk,
        wea => wea,
        addra => IReg(12 DOWNTO 8),
        dina => DataIReg,

        clkb => clk,
        addrb => IAddr,
        doutb => OData
    );

    CtrLcdRam_fsm_state_transition_logic : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' THEN
                fsm_curr_state <= checkIReg;
            ELSE
                fsm_curr_state <= fsm_next_state;
                IF fsm_curr_state = saveData THEN
                    LastIReg <= IReg;
                END IF;

            END IF;
        END IF;
    END PROCESS;

    lcd_fsm_next_state_logic : PROCESS (fsm_curr_state, IReg, LastIReg)
    BEGIN

        fsm_next_state <= fsm_curr_state;

        CASE fsm_curr_state IS

            WHEN checkIReg =>
                IF IReg /= LastIReg THEN
                    fsm_next_state <= saveData;
                END IF;

            WHEN saveData =>
                fsm_next_state <= CheckIReg;

            WHEN OTHERS =>
                fsm_next_state <= CheckIReg;

        END CASE;
    END PROCESS;

    DataIReg <= "00100000" WHEN (IReg(7 DOWNTO 4) < 2) OR IReg(7 DOWNTO 4) = "1000" OR IReg(7 DOWNTO 4) = "1001" ELSE
        IReg(7 DOWNTO 0);

    wea <= "0" WHEN fsm_curr_state = saveData ELSE
        "0";

END ARCHITECTURE;