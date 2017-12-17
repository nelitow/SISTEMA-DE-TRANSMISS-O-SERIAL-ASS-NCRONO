library ieee;
use ieee.std_logic_1164.all;

entity saida_dados is
	port(
		data_in: in std_logic_vector(10 downto 0);
		ser_in: in std_logic;
		ssd_NRA, ssd_NRB: out std_logic_vector(6 downto 0);
		ser_out: out std_logic;
		led_dado,data_rx: out std_logic_vector(7 downto 0)
	);
end entity;

architecture v1 of saida_dados is
signal ssd_a,ssd_b: std_logic_vector(3 downto 0);

component to_ssd is
	port(
		dado: in std_logic_vector(3 downto 0);
		ssd_out: out std_logic_vector(6 downto 0)
	);
end component;

begin

inst1: to_ssd
	port map(ssd_a,ssd_NRA);
	
inst2: to_ssd
	port map(ssd_b,ssd_NRB);
	
ser_out <= ser_in;

data_rx <= data_in(7 downto 0);
led_dado <= data_in(7 downto 0);

end architecture;