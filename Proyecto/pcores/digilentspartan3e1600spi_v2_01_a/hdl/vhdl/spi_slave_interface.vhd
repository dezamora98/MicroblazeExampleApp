library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity spi_slave_interface is
    port (
        clk, rst: in std_logic;

        Miso :  in std_logic;
		Mosi :  out std_logic;
		Sck :   out std_logic;

		MB_Miso:    out std_logic;
		MB_Mosi:    in std_logic;
		MB_Sck:     in std_logic;

		MB_SS_DAC:      in std_logic;
        MB_SS_ADC:      in std_logic;
        MB_SS_AMP:      in std_logic;
        MB_SS_Flash:    in std_logic;

		CS_DAC:     out std_logic;
		CS_ADC:     out std_logic;
		CS_AMP:     out std_logic;
		CS_Flash:   out std_logic
    ) ;
end spi_slave_interface ; 

architecture arch of spi_slave_interface is

    component rising_edge_detector is
        Port ( clk : in  STD_LOGIC;
               rst : in  STD_LOGIC;
               level : in  STD_LOGIC;
               pulse : out  STD_LOGIC);
    end component; -- rising_edge_detector;

    type state is (StStandby, StConv, StReadData);
    signal NextState, CurrentState: state;
    signal sck_rising_edge: std_logic;

begin

    sck_rising_edge_det: rising_edge_detector 
        Port map (
            clk => clk,
            rst => rst,
            level => MB_Sck,
            pulse => sck_rising_edge
        );
    

    StateMem : process( clk )
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                CurrentState <= StStandBy;
            else
                CurrentState <= NextState;
            end if ;
        end if ;
    end process ; -- StateMem

    NextStateCLC : process( sck_rising_edge, CurrentState ,MB_SS_ADC )
    begin
        NextState <= CurrentState;
        case( CurrentState ) is
            when StStandby =>
                if MB_SS_ADC = '0' then
                    NextState <= StConv;
                end if ;
            when StConv =>
                if sck_rising_edge = '1' then
                    NextState <= stReadData;
                end if ;
            When StReadData =>
                if MB_SS_ADC = '1' then
                    NextState <= StStandby;
                end if ;
            when others => 
                NextState <= StStandby;
        end case ;
    end process ; -- NextStateCLC
    
    Sck <= MB_Sck;
    Mosi <= MB_Mosi;
    MB_Miso <= Miso;

    CS_DAC <= MB_SS_DAC;
    CS_AMP <= MB_SS_AMP;
    CS_Flash <= MB_SS_Flash;
    CS_ADC  <=  '1' when MB_SS_ADC = '0' and currentState = StConv else 
					  '0';

end architecture ;