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
    type state is (StStandby, StConv, StReadData);
    signal NextState, CurrentState: state;
    signal Count: integer range 0 to 34;
    signal ClkDiv: std_logic;
begin

    BitCounter : process( Clk, Rst )
    begin
        if Clk'event and Clk = '1' then
            if rst = '1' or Cs = '1' then
                ClkDiv <= '0'
                Count <= 0;
                NextState <= StStandby;
            elsif Cs = '0' then
                CurrentState <= NextState;
                ClkDiv <= not ClkDiv;
                if ClkDiv = '0' then
                    count <= count + 1;
                end if ;
            else
                CurrentState <= StStandby;
            end if ;
        end if ;
    end process ; -- BitCounter

    ClcNextState : process(NextState,Count)
    begin
        case( CurrentState ) is
        
            when StStandby =>
                if Cs = '0' then
                    NextState <= StConv
                end if ;

            when StConv =>
                if Count = 1 then
                    NextState <= StReadData
                end if ;

            When StReadData =>
                if Count > 2 and Count < 17 then
                    DataCh0(Count - 3) <= Miso; 
                elsif Count > 18 and Count < 32 then
                    DataCh1(Count - 19) <= Miso;
                elsif Count = 34 then
                    NextState <= StStandby                    
                end if ;
        
            when others =>
        
        end case ;
        
    end process ; -- ClcNextState

end architecture ; -- arch