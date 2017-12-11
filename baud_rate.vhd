library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY baud_rate IS
	--GENERIC (DIV_CLK : NATURAL := 250);
 	PORT (
		clk_in: IN STD_LOGIC;
		rst: in std_LOGIC;
		sw_baud: in std_logic_vector(1 downto 0);
		baudrate: OUT STD_LOGIC
		);
END ENTITY;

architecture v1 of baud_rate is
signal q0,q1,q2,q3: std_logic;

component clk_div IS
 	PORT (
		clk_in: IN STD_LOGIC;
		choice: in std_logic;
		rst: in std_LOGIC;
		clk_out: OUT STD_LOGIC
		);
END component;
begin


 comp: clk_div port map (clk_in,'0',rst,q0); 
 comp1: clk_div port map (q0,'1',rst,q1);
 comp2: clk_div port map (q1,'1',rst,q2);
 comp3: clk_div port map (q2,'1',rst,q3);
 
 baudrate <= q0 when sw_baud = "00" else
 q1 when sw_baud = "01" else
 q2 when sw_baud = "10" else
 q3;
 
end architecture;