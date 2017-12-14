library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_standard_functions.all;
entity stsass is
    port (
        clk50MHz, sw_rst, ser_in, sw_parit_rx, sw_parit_tx : in std_logic;
        sw_baud_rx, sw_baud_tx : in std_logic_vector(1 downto 0);
        sw_nrb : in std_logic_vector(2 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        ser_out, ser_by, rx_error : out std_logic;
        hex_txa, hex_txb, hex_rxa, hex_rxb : out std_logic_vector(6 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        let_tx, led_rx : out std_logic_vector(7 downto 0)
    );
end stsass;
architecture rtl of stsass is

    signal baud_rate_seri: std_LOGIC;
	 signal baud_rate_deseri: std_LOGIC;
    signal parity_seri: std_logic;
	 signal parity_deseri: std_logic;
	 signal par_out_deseri: std_LOGIC_VECTOR(n-1 downto 0);
	 
    component conv_paralelo_serial is
        generic (N : integer := 10);
        port (
            clk, baudrate, parity, rst : in STD_LOGIC;
            par_in : in STD_LOGIC_VECTOR(N - 1 downto 0);
            ser_out, sclk_test : out STD_LOGIC
        );
    end component;
    component conv_serial_paralelo_rx is
        generic (bits : positive := 14);
        port (
            clk, rst, baudrate, ser_in : in std_logic;
            parity : out std_logic;
            par_out : out std_logic_vector(n - 1 downto 0)
        );
    end component;

    component baud_rate is
        port (
            clk_in : in STD_LOGIC;
            rst : in std_LOGIC;
            sw_baud : in std_logic_vector(1 downto 0);
            baudrate : out STD_LOGIC
        );
    end component;

    component gerador_paridade is
        generic (
            NUM_DADOS : natural := 9
        );
        port (
            DATA_IN : in STD_LOGIC_VECTOR (NUM_DADOS downto 0);
            SW_PARITY_TX : in STD_LOGIC;
            PARITY : out STD_LOGIC_vector(0 downto 0)
        );
    end component;

    component detector_paridade is
        generic (bits : positive := 10);
        port (
            dados_in : in std_logic_vector(bits - 1 downto 0);
            parity, im_par : in std_logic;
            output : out std_logic
        );
    end component;

    component uart_rx is
        port (
            sw_parit_rX, clk50mhz, rst : in std_logic;
            ser_in : in std_logic;
            sw_baud_rx : in std_logic_vector(1 downto 0);
            data_out : out std_logic_vector(10 downto 0);
            error : out std_logic
        );
    end component;
	 
    component uart_tx is
        port (
            sw_parit_TX, clk50mhz, rst : in std_logic;
            data_in : in std_logic_vector(10 downto 0);
            sw_baund_tx : in std_logic_vector(1 downto 0);
            ser_out : out std_logic
        );
    end component;
begin
    serializador: conv_paralelo_serial
	 port map(clk50MHz, baud_rate_seri, parity_seri, sw_rst, data_in, ser_out, open);
	 deserializador: conv_paralelo_serial
	 port map(clk50MHz, sw_rst, baud_rate_deseri, datA_IN, parity_deseri, par_out_deseri);
end rtl;