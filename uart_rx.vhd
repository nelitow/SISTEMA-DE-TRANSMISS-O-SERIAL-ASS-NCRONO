library ieee;
use ieee.std_logic_1164.all;

entity uart_rx is
	GENERIC
	(
		NUM_DADOS : natural := 10
	);
	port(
		SW_PARITY_RX, clk50mhz, rst , ser_in: in std_logic;
		sw_baund_rx: in std_logic_vector(1 downto 0);
		par_out: out std_logic_vector(10 downto 0);
		rx_error: out std_logic
	);
end entity;

architecture v1 of uart_rx is
signal out_baud, parity_p: std_logic;
signal out_par: std_logic_vector(10 downto 0);

component baud_rate IS
	--GENERIC (DIV_CLK : NATURAL := 250);
 	PORT (
		clk_in: IN STD_LOGIC;
		rst: in std_LOGIC;
		sw_baud: in std_logic_vector(1 downto 0);
		baudrate: OUT STD_LOGIC
		);
END component;

component conv_serial_paralelo IS
	PORT (
		clk, rst, baudrate, ser_in: in std_logic;
		parity: out std_logic;
		par_out: OUT std_logic_vector(10 downto 0)
	);
END component;

component detector_paridade IS
	PORT (
		dados_in : IN std_logic_vector(10 DOWNTO 0);
		parity, im_par : in std_logic;
		estado: OUT std_logic
	);
END component;

begin

inst1: baud_rate
	port map(clk50mhz, rst, sw_baund_rx, out_baud);
	
inst2: detector_paridade
	port map(out_par, parity_p, sw_parity_rx, rx_error);
	
inst3: conv_serial_paralelo
	port map(clk50mhz, rst, out_baud, ser_in, parity_p, out_par);
	
par_out <= out_par ;
end architecture;