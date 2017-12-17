LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY altera;
USE altera.altera_standard_functions.ALL;

ENTITY stsass IS
	PORT (
		clk50MHz, sw_rst, ser_in, sw_parity_rx, sw_parity_tx : IN std_logic;
		sw_baud_rx, sw_baud_tx : IN std_logic_vector(1 DOWNTO 0);
		sw_nrb : IN std_logic_vector(2 DOWNTO 0);
		data_in : IN std_logic_vector(7 DOWNTO 0);
		ser_out, ser_by, rx_error : OUT std_logic;
		hex_txa, hex_txb, hex_rxa, hex_rxb : OUT std_logic_vector(6 DOWNTO 0);
		data_out : OUT std_logic_vector(7 DOWNTO 0);
		let_tx, led_rx : OUT std_logic_vector(7 DOWNTO 0)
	);
END stsass;
ARCHITECTURE rtl OF stsass IS
	signal dados_tx: std_logic_vector(10 downto 0);
	COMPONENT uart_tx
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
	END COMPONENT;
	
	COMPONENT uart_rx
		
	END COMPONENT;
	
	COMPONENT entrada_dados
		
	END COMPONENT;
	
	COMPONENT saida_dados
		
	END COMPONENT;
	
BEGIN

inst1: uart_tx
	port map(sw_parity_tx ,clk50MHz, sw_rst, dados_tx, sw_baud_tx,ser_out);
END rtl;