
-- VHDL Instantiation Created from source file InterfaceLct1407.vhd -- 06:13:24 12/11/2022
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT InterfaceLct1407
	PORT(
		Clk : IN std_logic;
		Rst : IN std_logic;
		Cs : IN std_logic;
		Miso : IN std_logic;          
		ack : OUT std_logic;
		Conv : OUT std_logic;
		Sck : OUT std_logic;
		DataCh0 : OUT std_logic_vector(13 downto 0);
		DataCh1 : OUT std_logic_vector(13 downto 0)
		);
	END COMPONENT;

	Inst_InterfaceLct1407: InterfaceLct1407 PORT MAP(
		Clk => ,
		Rst => ,
		Cs => ,
		ack => ,
		Miso => ,
		Conv => ,
		Sck => ,
		DataCh0 => ,
		DataCh1 => 
	);


