library IEEE;
use IEEE.STD_logic_1164.all;	

use IEEE.STD_LOGIC_signed.all;

entity UA is port(
		clk, rst: in std_logic;		
		OP:in std_logic;
		x_i : in std_logic_vector(4 downto 1);
		y_o : out std_logic_vector(26 downto 1)
		);
		end entity UA;
		architecture ua of ua is 
		type TState is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
	signal State: TState;				  
	begin
	process (clk, rst ) is
		begin					  
	y_o <= (others => '0');
	if rst = '0' then State <= s1;	
	--elsif (clk'event and clk='1') then 
		elsif rising_edge(clk)then
	case State is
	when s1 => 	if OP = '1' then State <= s7; y_o(13) <= '1'; y_o(14) <= '1'; y_o(15) <= '1';
	else State <= s2; y_o(1) <= '1'; y_o(2) <= '1'; y_o(3) <= '1'; y_o(4) <= '1';
	end if;	 									
	
	when s2 => if x_i(1) = '1' then State <= s3; y_o(5) <= '1';
	else State <= s4; y_o(6) <= '1';  y_o(7) <= '1'; y_o(8) <= '1';
	end if;	
	
	when s3 => State <=s4; y_o(6) <= '1';  y_o(7) <= '1'; y_o(8) <= '1';
	
	when s4 => if x_i(2) = '1' then State <= s5; y_o(9) <= '1';
	else State <= s5; y_o(10) <= '1';
	end if;	
	
	when s5 => if x_i(3) = '0' then State <= s2; 
	elsif x_i(4) = '1' then State <= s6; y_o(11) <= '1';
	else State <= s1; y_o(12) <= '1';
	end if;
	
	when s6 => State <= s1; y_o(12) <= '1';
	
	when s7 => State <= s8; y_o(16) <= '1';
	
	when s8 => if x_i(3) = '1' then State <= s1;
	else State <= s9; y_o(17) <= '1'; y_o(18) <= '1';
	end if;
	
	when s9 => State <= s10; y_o(19) <= '1'; y_o(20) <= '1';
	
	when s10 => State <= s11; y_o(21) <= '1'; y_o(22) <= '1';
	
	when s11 => State <= s12; y_o(23) <= '1'; y_o(24) <= '1';
	
	when s12 => State <= s7; y_o(25) <= '1'; y_o(26) <= '1';
	end case;
	end if;
	end process;
end UA;


