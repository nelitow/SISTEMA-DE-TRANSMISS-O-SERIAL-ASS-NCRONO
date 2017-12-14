LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY conv_serial_paralelo_rx IS
	GENERIC (bits : POSITIVE := 14);
	PORT (
		clk, rst, baudrate, ser_in: in std_logic;
		parity: out std_logic;
		par_out: OUT std_logic_vector(n-1 downto 0)
	);
END conv_serial_paralelo_rx;
ARCHITECTURE behavior OF conv_serial_paralelo_rx IS
BEGIN
	PROCESS (input)
	VARIABLE n : integer := 0;
	BEGIN
		if
	END PROCESS;
	END behavior;
END conv_serial_paralelo_rx;