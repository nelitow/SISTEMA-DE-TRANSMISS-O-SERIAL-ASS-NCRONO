library ieee;
use ieee.std_logic_1164.all;

entity entrada_dados is
	port(
		NRB: in std_logic_vector(2 downto 0);
		dados: in std_logic_vector(7 downto 0);
		ssd_NRA, ssd_NRB: out std_logic_vector(6 downto 0);
		led_dado: out std_logic_vector(7 downto 0);
		dados_tx: out std_logic_vector(10 downto 0)
	);
end entity;

architecture v1 of entrada_dados is
signal ssd_a,ssd_b: std_logic_vector(3 downto 0);


component to_ssd is
	port(
		dado: in std_logic_vector(3 downto 0);
		ssd_out: out std_logic_vector(6 downto 0)
	);
end component;

begin

led_dado <= dados;
ssd_a <= dados(3 downto 0);
ssd_b <= dados(7 downto 4);

inst1: to_ssd
	port map(ssd_a,ssd_NRA);
	
inst2: to_ssd
	port map(ssd_b,ssd_NRB);
	
dados_tx(10 downto 8) <= NRB;
dados_tx(7 downto 0) <= dados;

end architecture;