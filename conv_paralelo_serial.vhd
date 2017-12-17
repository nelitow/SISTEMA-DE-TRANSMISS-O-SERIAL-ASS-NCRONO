LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY conv_paralelo_serial IS
    GENERIC (N : INTEGER := 10);
    PORT (
        clk, baudrate, rst : IN STD_LOGIC;
		  parity: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        par_in : IN STD_LOGIC_VECTOR(N DOWNTO 0);
        ser_out: OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE conv_paralelo_serial OF conv_paralelo_serial IS
    SIGNAL sclk : STD_LOGIC;
	 SIGNAL rst_t: std_logic;
    SIGNAL internal : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
	 
--    COMPONENT altera_pll IS
--        PORT (
--            areset : IN STD_LOGIC := '0';
--            inclk0 : IN STD_LOGIC := '0';
--            c0 : OUT STD_LOGIC;
--            locked : OUT STD_LOGIC
--        );
--    END COMPONENT;
	 
BEGIN
--    pll_circuit : altera_pll
--	 
--    PORT MAP('0', clk, sclk, OPEN);	
	rst_t <= not rst;
	 
    PROCESS (clk, rst_t)
    VARIABLE count: INTEGER RANGE 0 TO N+2;
	  VARIABLE c_data : INTEGER RANGE 0 TO N;
    BEGIN
		  IF(rst_t = '1') THEN
				count := 0;
				c_data := 0;
				ser_out <= '0';
		  elsIF (clk'EVENT AND clk = '1') THEN
				if(count = N+2) then
					count := 0;
					c_data := 0;
				elsif(count = 0) then
					count := count + 1;
					ser_out <= baudrate;
				elsif(count = 1) then
					ser_out <= parity(0);
					count := count + 1;
				else
            ser_out <= par_in(c_data);
				c_data := c_data + 1;
				end if;
        END IF;
    END PROCESS;
END ARCHITECTURE;