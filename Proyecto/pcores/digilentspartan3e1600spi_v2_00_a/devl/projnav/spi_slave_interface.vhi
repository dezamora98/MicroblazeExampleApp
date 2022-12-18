
-- VHDL Instantiation Created from source file spi_slave_interface.vhd -- 03:24:54 12/18/2022
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT spi_slave_interface
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		Miso : IN std_logic;
		MB_Mosi : IN std_logic;
		MB_Sck : IN std_logic;
		MB_SS_DAC : IN std_logic;
		MB_SS_ADC : IN std_logic;
		MB_SS_AMP : IN std_logic;
		MB_SS_Flash : IN std_logic;          
		Mosi : OUT std_logic;
		Sck : OUT std_logic;
		MB_Miso : OUT std_logic;
		CS_DAC : OUT std_logic;
		CS_ADC : OUT std_logic;
		CS_AMP : OUT std_logic;
		CS_Flash : OUT std_logic
		);
	END COMPONENT;

	Inst_spi_slave_interface: spi_slave_interface PORT MAP(
		clk => ,
		rst => ,
		Miso => ,
		Mosi => ,
		Sck => ,
		MB_Miso => ,
		MB_Mosi => ,
		MB_Sck => ,
		MB_SS_DAC => ,
		MB_SS_ADC => ,
		MB_SS_AMP => ,
		MB_SS_Flash => ,
		CS_DAC => ,
		CS_ADC => ,
		CS_AMP => ,
		CS_Flash => 
	);


