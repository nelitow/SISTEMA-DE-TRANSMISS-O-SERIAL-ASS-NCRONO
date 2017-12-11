------------------------------------
-- IFSC - Instituto Federal de Santa Catarina
-- Curso Engenharia de Telecomunicacoes
-- Projeto  Final de DLP
-------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY clk_div IS
--	GENERIC (
--	DIV_CLK : NATURAL := 250
--	DIV_CLK : NATURAL := 50
--	);
	
 	PORT (
		clk_in: IN STD_LOGIC;
		choice: in std_logic;
		rst: in std_LOGIC;
		clk_out: OUT STD_LOGIC
		);
END ENTITY;

ARCHITECTURE v1 OF clk_div IS
signal rst_1: STD_LOGIC;
signal clk_o1: STD_LOGIC;
signal counter1 : NATURAL RANGE 0 TO 250 := 0;

BEGIN

rst_1 <= not rst;

PROCESS (clk_in, rst_1)
variable clk_div1: integer;
	BEGIN
		IF(rst_1 = '1') THEN
			counter1 <= 0;
		ELSIF (clk_in'EVENT AND clk_in = '1') THEN
			if(choice = '0') then
				clk_div1 :=  250;
			else 
				clk_div1 := 50;
			end if;
			counter1 <= counter1 + 1;
			IF (counter1 = clk_div1) THEN
				counter1 <= 0;
				if(clk_o1 = '0') THEN
					clk_o1 <= '1';
					clk_out <= clk_o1;
				ELSIF(clk_o1 = '1') THEN
					clk_o1 <= '0';
					clk_out <= clk_o1;
				END IF;
			END IF; 
		END IF;
END PROCESS;
END ARCHITECTURE;