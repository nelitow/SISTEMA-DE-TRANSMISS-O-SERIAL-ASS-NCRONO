library ieee;
use ieee.std_logic_1164.all;

entity uart_rx is

port(
	sw_parit_rX, clk50mhz, rst: in std_logic;
	ser_in: in std_logic;
	sw_baud_rx: in std_logic_vector(1 downto 0);
	data_out: out std_logic_vector(10 downto 0);
	error: out std_logic
);

end entity;

architecture v1 of uart_tx is

signal out_baud: std_logic;

component baud_rate IS
 	PORT (
		clk_in: IN STD_LOGIC;
		rst: in std_LOGIC;
		sw_baud: in std_logic_vector(1 downto 0);
		baudrate: OUT STD_LOGIC
		);
END component;

--
component gerador_paridade IS

END component;

--
component conv_paralelo_serial is
	
end component;
--

begin

inst1: baud_rate
	port map(clk50mhz, rst , sw_baund_tx , out_baud);
end architecture;