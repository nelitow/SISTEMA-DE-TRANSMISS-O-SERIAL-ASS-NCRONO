LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY altera;
USE altera.altera_standard_functions.ALL;

ENTITY stsass IS
	PORT (
		clk50MHz, sw_rst, ser_in, sw_parity_rx, sw_parity_tx, ena_t : IN std_logic;
		sw_baud_rx, sw_baud_tx : IN std_logic_vector(1 DOWNTO 0);
		sw_nrb : IN std_logic_vector(2 DOWNTO 0);
		data_in : IN std_logic_vector(7 DOWNTO 0);
		ser_out, ser_by, rx_error : OUT std_logic;
		hex_txa, hex_txb, hex_rxa, hex_rxb : OUT std_logic_vector(6 DOWNTO 0);
		data_out : OUT std_logic_vector(7 DOWNTO 0);
		led_tx, led_rx : OUT std_logic_vector(7 DOWNTO 0)
	);
END stsass;
ARCHITECTURE rtl OF stsass IS
	signal dados_tx: std_logic_vector(10 downto 0);
	signal saida_par_out: std_logic_vector(10 downto 0);
	COMPONENT uart_tx
		GENERIC
		(
			NUM_DADOS : natural := 10
		);
		port(
			sw_parit_TX, clk50mhz, rst, ena: in std_logic;
			data_in: in std_logic_vector(NUM_DADOS downto 0);
			sw_baund_tx: in std_logic_vector(1 downto 0);
			ser_out: out std_logic
		);
	END COMPONENT;
	
	COMPONENT uart_rx
		GENERIC
		(
			NUM_DADOS : natural := 10
		);
		port(
			SW_PARITY_RX, clk50mhz, rst, ser_in: in std_logic;
			sw_baund_rx: in std_logic_vector(1 downto 0);
			par_out: out std_logic_vector(10 downto 0);
			rx_error: out std_logic
		);
	END COMPONENT;
	
	COMPONENT entrada_dados
		port(
			NRB: in std_logic_vector(2 downto 0);
			dados: in std_logic_vector(7 downto 0);
			ssd_NRA, ssd_NRB: out std_logic_vector(6 downto 0);
			led_dado: out std_logic_vector(7 downto 0);
			dados_tx: out std_logic_vector(10 downto 0)
		);
	END COMPONENT;
	
	COMPONENT saida_dados
		port(
			data_in: in std_logic_vector(10 downto 0);
			ser_in: in std_logic;
			ssd_NRA, ssd_NRB: out std_logic_vector(6 downto 0);
			ser_out: out std_logic;
			led_dado,data_rx: out std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
BEGIN

inst1: uart_tx
	port map(sw_parity_tx ,clk50MHz, sw_rst, ena_t, dados_tx, sw_baud_tx,ser_out);
	
inst2: uart_rx
	port map(sw_parity_rx, clk50MHz, sw_rst, ser_in, sw_baud_rx, saida_par_out, rx_error);

inst3: entrada_dados
	port map(sw_nrb, data_in, hex_txa, hex_txb, led_tx, dados_tx);
	
inst4: saida_dados
	port map(saida_par_out, ser_in, hex_rxa, hex_rxb, ser_by, led_rx, data_out);
	
END rtl;