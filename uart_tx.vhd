library ieee;
use ieee.std_logic_1164.all;

entity uart_tx is
	GENERIC
	(
		NUM_DADOS : natural := 10
	);
port(
	sw_parit_TX, clk50mhz, rst: in std_logic;
	data_in: in std_logic_vector(NUM_DADOS downto 0);
	sw_baund_tx: in std_logic_vector(1 downto 0);
	ser_out: out std_logic
);

end entity;

architecture v1 of uart_tx is

signal out_baud: std_logic;
signal out_parity: std_logic_vector(0 downto 0);

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
	GENERIC
	(
		NUM_DADOS : natural := 10
	);

	PORT
	(
		DATA_IN : IN STD_LOGIC_VECTOR (NUM_DADOS DOWNTO 0);
		SW_PARITY_TX : IN STD_LOGIC;
		PARITY : OUT STD_LOGIC_vector(0 downto 0)
	);
END component;

--
component conv_paralelo_serial is
	 GENERIC (N : INTEGER := 10);
    PORT (
        clk, baudrate, rst : IN STD_LOGIC;
		  parity: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        par_in : IN STD_LOGIC_VECTOR(N DOWNTO 0);
        ser_out: OUT STD_LOGIC
    );
end component;
--

begin

inst1: baud_rate
	port map(clk50mhz, rst , sw_baund_tx , out_baud);
inst2: gerador_paridade
	port map(data_in, sw_parit_TX, out_parity);
inst3: conv_paralelo_serial
	port map(clk50mhz,out_baud,rst,out_parity, data_in, ser_out);
end architecture;