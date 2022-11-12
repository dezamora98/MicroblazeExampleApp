LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    use ieee.std_logic_unsigned.all;

ENTITY DisRAM IS
    PORT (
        clk : IN STD_LOGIC;
        wea : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

        addrb : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END DisRAM;

ARCHITECTURE arch OF DisRAM IS
    TYPE ram_type IS ARRAY(31 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram : ram_type := (x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",
							  x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20");
BEGIN
    memory : process(clk)
    begin
        if(clk'event and clk = '1') then
            if (wea = '1') then
                   ram(conv_integer(addra)) <= dina; 
            end if;    
        end if;
    end process ; -- memory

    doutb <= ram(conv_integer(addrb));
END ARCHITECTURE;