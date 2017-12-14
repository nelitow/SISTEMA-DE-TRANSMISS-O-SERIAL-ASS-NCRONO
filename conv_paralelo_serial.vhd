LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY conv_paralelo_serial IS
    GENERIC (N : INTEGER := 10);
    PORT (
        clk, baudrate, parity, rst : IN STD_LOGIC;
        par_in : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        ser_out, sclk_test : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE conv_paralelo_serial OF conv_paralelo_serial IS
    SIGNAL sclk : STD_LOGIC;
    SIGNAL internal : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    COMPONENT altera_pll IS
        PORT (
            areset : IN STD_LOGIC := '0';
            inclk0 : IN STD_LOGIC := '0';
            c0 : OUT STD_LOGIC;
            locked : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    pll_circuit : altera_pll
    PORT MAP('0', clk, sclk, OPEN);
    sclk_test <= sclk;
    PROCESS (sclk)
    VARIABLE count : INTEGER RANGE 0 TO N;
    BEGIN
        IF (sclk'EVENT AND sclk = '1') THEN
            count := count + 1;
            IF (count = N - 1) THEN
                internal <= din;
            ELSIF (count = N) THEN
                count := 0;
            END IF;
            dout <= internal(count);
        END IF;
    END PROCESS;
END ARCHITECTURE;