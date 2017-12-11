LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY conv_serial_paralelo_rx IS
	GENERIC (bits : POSITIVE);
	PORT (
		input : IN BIT_VECTOR(bits - 1 DOWNTO 0);
		output : OUT BIT
	);
END conv_serial_paralelo_rx;
ARCHITECTURE behavior OF conv_serial_paralelo_rx IS
BEGIN
	PROCESS (input)
	VARIABLE temp : BIT;
	BEGIN
		temp := '0';
		FOR i IN input'RANGE LOOP
			temp := temp XOR input(i);
		END LOOP;
		output <= temp;
	END PROCESS;
	END behavior;
END conv_serial_paralelo_rx;