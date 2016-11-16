library IEEE;
use IEEE.STD_logic_1164.all;	

use IEEE.STD_LOGIC_unsigned.all;

entity UA is port(
		clk, rst: in std_logic;		
		OP:in std_logic;
		x : in std_logic_vector(4 downto 1);
		y : out std_logic_vector(26 downto 1)
		);
		end ua;
		architecture ua of ua is 
		type TState is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
	signal State: TState;				  
	begin
	process (clk, rst ) is
		begin					  
	y <= (others => '0');
	if rst = '0' then State <= s1;	
	elsif (clk'event and clk='1') then 
	case State is
	when s1 => 	if OP = '1' then State <= s7; y(13) <= '1'; y(14) <= '1'; y(15) <= '1';
	else State <= s1; y(1) <= '1'; y(2) <= '1'; y(3) <= '1'; y(4) <= '1';
	end if;	 									
	
	when s2 => if x(1) = '1' then State <= s3; y(5) <= '1';
	else State <= s4; y(6) <= '1';  y(7) <= '1'; y(8) <= '1';
	end if;	
	
	when s3 => State <=s4; y(6) <= '1';  y(7) <= '1'; y(8) <= '1';
	
	when s4 => if x(2) = '1' then State <= s5; y(9) <= '1';
	else State <= s5; y(10) <= '1';
	end if;	
	
	when s5 => if x(3) = '0' then State <= s2; 
	elsif x(4) = '1' then State <= s6; y(11) <= '1';
	else State <= s1; y(12) <= '1';
	end if;
	
	when s6 => State <= s1; y(12) <= '1';
	
	when s7 => State <= s8; y(16) <= '1';
	
	when s8 => if x(3) = '1' then State <= s1;
	else State <= s9; y(17) <= '1'; y(18) <= '1';
	end if;
	
	when s9 => State <= s10; y(19) <= '1'; y(20) <= '1';
	
	when s10 => State <= s11; y(21) <= '1'; y(22) <= '1';
	
	when s11 => State <= s12; y(23) <= '1'; y(24) <= '1';
	
	when s12 => State <= s7; y(25) <= '1'; y(26) <= '1';
	end case;
	end if;
	end process;
end UA;


