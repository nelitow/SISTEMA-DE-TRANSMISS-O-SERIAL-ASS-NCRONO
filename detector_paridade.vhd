LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY detector_paridade IS
	PORT (
		dados_in : IN std_logic_vector(10 DOWNTO 0);
		parity, im_par : in std_logic;
		estado: OUT std_logic
	);
END entity;
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
		estado <= temp;
	END PROCESS;
END behavior;