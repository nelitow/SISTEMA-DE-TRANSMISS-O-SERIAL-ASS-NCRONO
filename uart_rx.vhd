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

signal out_baud, out_parity: std_logic;
signal out_par_out: std_logic(10 downto 0);

component baud_rate IS
 	PORT (
		clk_in: IN STD_LOGIC;
		rst: in std_LOGIC;
		sw_baud: in std_logic_vector(1 downto 0);
		baudrate: OUT STD_LOGIC
		);
END component;

component detector_paridade IS
	GENERIC (bits : POSITIVE := 10);
	PORT (
		dados_in : IN std_logic_vector(bits - 1 DOWNTO 0);
		parity, im_par : in std_logic;
		output: OUT std_logic
	);
END component;

component conv_serial_paralelo_rx IS
	GENERIC (bits : POSITIVE := 14);
	PORT (
		clk, rst, baudrate, ser_in: in std_logic;
		parity: out std_logic;
		par_out: OUT std_logic_vector(n-1 downto 0)
	);
END component;
begin

inst1: baud_rate
	port map(clk50mhz, rst , sw_baund_tx , out_baud);
detec: detector_paridade
	port map(out_par_out, out_parity, sw_parit_rX, error);
deseri: conv_paralelo_serial
	port map(clk50mhz, rst, out_baud, ser_in,out_parity, out_par_out);
end architecture;