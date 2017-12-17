LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY conv_serial_paralelo IS
	PORT (
		clk, rst, baudrate, ser_in: in std_logic;
		parity: out std_logic;
		par_out: OUT std_logic_vector(10 downto 0)
	);
END entity;

ARCHITECTURE behavior OF conv_serial_paralelo IS
signal rst_t: std_logic;

BEGIN

rst_t <= not rst;

process(baudrate, rst_t)
variable count: integer ;
variable temporario: std_logic_vector(10 downto 0);


begin
	if(rst_t = '1') then
	count := 0;
	elsif(baudrate'event and baudrate = '1') then
		if(count = 0) then
			parity <= ser_in;
			count := count + 1;
		elsif(count = 11) then
		   par_out <= temporario;
			count := 0;
		else
		temporario(count) := ser_in;
		count := count + 1;
		end if;
	end if;
	
end process;

END architecture;