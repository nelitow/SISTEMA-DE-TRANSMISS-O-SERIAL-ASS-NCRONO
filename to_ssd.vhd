library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity to_ssd is
	port(
		dado: in std_logic_vector(3 downto 0);
		ssd_out: out std_logic_vector(6 downto 0)
	);
end entity;

architecture v1 of to_ssd is

signal bit_int : natural RANGE 0 TO 9 := 0;
signal ssd: std_logic_vector(6 downto 0);
 
begin
 
bit_int <= to_integer(unsigned(dado));
 
ssd <= "0000001" when bit_int = 0 else
	"1001111" when bit_int = 1 else
	"0010010" when bit_int = 2 else
	"0000110" when bit_int = 3 else
	"1001100" when bit_int = 4 else
	"0100100" when bit_int = 5 else
	"0100000" when bit_int = 6 else
	"0001111" when bit_int = 7 else
	"0000000" when bit_int = 8 else
	"0000100";
	


ssd_out <= ssd;

end architecture;
