library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

end architecture ;
entity InterfaceLct1407 is
    port (
        Clk, Rst, Cs : in std_logic;
        Miso: in std_logic;
        Conv, Sck: out std_logic;
        DataCh0, DataCh1: out std_logic_vector(13 downto 0) 
    );
end InterfaceLct1407 ;

architecture arch of InterfaceLct1407 is
    type state is (StConv,StSckFalling, StStandby);
    signal NextState, CurrentState: state;
    signal Count: integer range 0 to 33;
    signal ClkDiv: std_logic;
begin

    BitCounter : process( Clk, Rst )
    begin
        if Clk'event and Clk = '1' then
            if rst = '1' then
                ClkDiv <= '0'
                Count <= 0;
                NextState <= StStandby;
            elsif Cs = '0' then
                CurrentState <= NextState;
                ClkDiv <= not ClkDiv;
                if div = '1' then
                    count <= count + 1;
                end if ;
            else
                CurrentState <= StStandby;
            end if ;
        end if ;
    end process ; -- BitCounter

    ClcNextState : process(NextState,Cs)
    begin
        if Cs = '0' then
            case( CurrentState ) is
            
                when StConv =>
                    if Count = 1 then
                        NextState <= Stconv 
                    end if ;
            
                when others =>
            
            end case ;
        else
            NextState <= StStandby
        end if ;
        
    end process ; -- ClcNextState

    Conv <= '1' when count = 1 and state = StConv else '0';
    DataCh0(Count-3) <= Miso when state = Stfalling and Count  

end architecture ; -- arch