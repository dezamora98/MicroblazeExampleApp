-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    fpga_0_clk_1_sys_clk_pin : in std_logic;
    fpga_0_rst_1_sys_rst_pin : in std_logic;
    lcd2x16interface_0_data_pin : out std_logic_vector(7 downto 0);
    lcd2x16interface_0_rs_pin : out std_logic;
    lcd2x16interface_0_en_pin : out std_logic;
    lcd2x16interface_0_rw_pin : out std_logic;
    lcd2x16interface_0_sfce_pin : out std_logic;
    Miso_pin : in std_logic;
    Mosi_pin : out std_logic;
    Sck_pin : out std_logic;
    CS_DAC_pin : out std_logic;
    CS_ADC_pin : out std_logic;
    CS_AMP_pin : out std_logic;
    CS_Flash_pin : out std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      fpga_0_clk_1_sys_clk_pin : in std_logic;
      fpga_0_rst_1_sys_rst_pin : in std_logic;
      lcd2x16interface_0_data_pin : out std_logic_vector(7 downto 0);
      lcd2x16interface_0_rs_pin : out std_logic;
      lcd2x16interface_0_en_pin : out std_logic;
      lcd2x16interface_0_rw_pin : out std_logic;
      lcd2x16interface_0_sfce_pin : out std_logic;
      Miso_pin : in std_logic;
      Mosi_pin : out std_logic;
      Sck_pin : out std_logic;
      CS_DAC_pin : out std_logic;
      CS_ADC_pin : out std_logic;
      CS_AMP_pin : out std_logic;
      CS_Flash_pin : out std_logic
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      fpga_0_clk_1_sys_clk_pin => fpga_0_clk_1_sys_clk_pin,
      fpga_0_rst_1_sys_rst_pin => fpga_0_rst_1_sys_rst_pin,
      lcd2x16interface_0_data_pin => lcd2x16interface_0_data_pin,
      lcd2x16interface_0_rs_pin => lcd2x16interface_0_rs_pin,
      lcd2x16interface_0_en_pin => lcd2x16interface_0_en_pin,
      lcd2x16interface_0_rw_pin => lcd2x16interface_0_rw_pin,
      lcd2x16interface_0_sfce_pin => lcd2x16interface_0_sfce_pin,
      Miso_pin => Miso_pin,
      Mosi_pin => Mosi_pin,
      Sck_pin => Sck_pin,
      CS_DAC_pin => CS_DAC_pin,
      CS_ADC_pin => CS_ADC_pin,
      CS_AMP_pin => CS_AMP_pin,
      CS_Flash_pin => CS_Flash_pin
    );

end architecture STRUCTURE;

