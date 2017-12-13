LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY gerador_paridade IS

	GENERIC
	(
		NUM_DADOS : natural := 9
	);

	PORT
	(
		DATA_IN : IN STD_LOGIC_VECTOR (NUM_DADOS DOWNTO 0);
		SW_PARITY_TX : IN STD_LOGIC;
		PARITY : OUT STD_LOGIC_vector(0 downto 0)
	);

END ENTITY;

ARCHITECTURE v1 OF gerador_paridade IS

SIGNAL NUM_1: INTEGER;

BEGIN

	process(DATA_IN)
	variable cont1, RESTO, paridade: natural;
	begin
		cont1 := 0;
		resto := 0;
		for i in DATA_IN'range loop
			if (DATA_IN(i) = '1') then
				cont1 := cont1 + 1;
			end if;
		end loop;
		
		RESTO := NUM_DADOS rem cont1;
		
		if(SW_PARITY_TX = '0') then 
			if(RESTO = 0) then
				paridade := 0;
			else
				paridade := 1;
			end if;
		elsif(SW_PARITY_TX = '1') then
			if(resto = 0) then
				paridade := 1;
			else 
				paridade := 0;
			end if;
		end if;
		
		parity <= std_logic_vector(to_unsigned(paridade,1));
	
	end process;

END ARCHITECTURE;