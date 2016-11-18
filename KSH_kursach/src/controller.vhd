library IEEE;
use IEEE.STD_logic_1164.all;	

use IEEE.STD_LOGIC_unsigned.all;	

entity controller is port(
	clk, rst, OP : in std_logic;
	Data1, Data2: in std_logic_vector(7 downto 0) ;
	Result :  out std_logic_vector(15 downto 0)	
	);
end entity controller;

architecture controller of controller is 
signal y_v : std_logic_vector(26 downto 1);
signal x_v: std_logic_vector(4 downto 1);
component UA is port(
		clk, rst: in std_logic;		
		OP:in std_logic;
		x_i : in std_logic_vector(4 downto 1);
		y_o : out std_logic_vector(26 downto 1)
		);
		end component;
		
component 	OA is port(
		clk, rst: in std_logic;			  
		y_i: in std_logic_vector(26 downto 1);
		D1, D2: in std_logic_vector( 7 downto 0);
		x_o: out std_logic_vector(4 downto 1);
		Res1: out std_logic_vector(15 downto 0)
		--Res2: out std_logic_vector(7 downto 0)
		);
		end component;	
		
		begin 													
			CONTROL_UNIT:UA port map(clk => clk, rst => rst, OP => OP, x_i => x_v, y_o => y_v);
			DATA:OA port map(clk => clk, rst => rst, y_i =>y_v, D1 => Data1, D2 => Data2, x_o => x_v, Res1 => Result);
			

end controller;
