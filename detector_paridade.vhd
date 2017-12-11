LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY detector_paridade IS
	GENERIC (bits : POSITIVE := 10);
	PORT (
		dados_in : IN std_logic_vector(bits - 1 DOWNTO 0);
		parity, im_par : in std_logic;
		output: OUT std_logic
	);
END detector_paridade;
ARCHITECTURE behavior OF detector_paridade IS
BEGIN
	PROCESS (dados_in)
	VARIABLE temp : std_logic;
	BEGIN
		temp := parity;
		FOR i IN dados_in'RANGE LOOP
			temp := temp XOR dados_in(i);
		END LOOP;
		--temp := temp xor im_par;
		output <= temp;
	END PROCESS;
END behavior;