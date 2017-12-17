LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY conv_paralelo_serial IS
    GENERIC (N : INTEGER := 10);
    PORT (
        clk, baudrate, rst, enable : IN STD_LOGIC;
		  parity: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        par_in : IN STD_LOGIC_VECTOR(N DOWNTO 0);
        ser_out: OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE conv_paralelo_serial OF conv_paralelo_serial IS
	 SIGNAL rst_t: std_logic;
    SIGNAL internal : STD_LOGIC_VECTOR(N DOWNTO 0);
	 
	 
BEGIN
	rst_t <= not rst;

	internal <= par_in when enable = '1';
	
   PROCESS (baudrate, rst_t, enable, par_in, internal)

   VARIABLE count: INTEGER RANGE 0 TO N+1;
	VARIABLE c_data : INTEGER RANGE 0 TO N;
    BEGIN
		  IF(rst_t = '1') THEN
				count := 0;
				c_data := 0;
				ser_out <= '0';
			ELSIF (baudrate'EVENT AND baudrate = '1') THEN
				if(count = N+1) then
					count := 0;
					c_data := 0;
				elsif(count = 0) then
					count := count + 1;
					ser_out <= parity(0);
				else
					ser_out <= internal(c_data);
					c_data := c_data + 1;
				end if;
		  END IF;
    END PROCESS;
END ARCHITECTURE;