library IEEE;
use IEEE.STD_logic_1164.all;	

use IEEE.STD_LOGIC_unsigned.all;	

entity OA is port(
		clk, reset: in std_logic;			  
		
		y: in std_logic_vector(26 downto 1);
		x: out std_logic_vector(4 downto 1);
		D1, D2: in std_logic_vector( 7 downto 0);

		Res1: out std_logic_vector(15 downto 0)
		--Res2: out std_logic_vector(7 downto 0)
		);
end entity;		
architecture OA of OA is  
signal A, ARes, B, BRes, C, CRes : std_logic_vector(7 downto 0); 
signal F1, F2,  F4, temp: std_logic_vector(7 downto 0);	 
signal CnT, F5: std_logic_vector(2 downto 0);
signal F3, CF, O_F, TgB: std_logic;
begin
process (clk, reset) is
begin
	if(reset = '0') then x <= (others => 'Z');
		ARes <= (others => 'Z');
		BRes <= (others => 'Z');
		CRes <= (others => 'Z');
	elsif (clk'event and clk='1')then 
		A <= ARes; B <= BRes; C <= CRes; 
	end if;
end process; 

F1 <= A(7 downto 0) when y(5) = '1' else
	not(A(7 downto 0)) when y(11) = '1' else
	A(7 downto 4)&"0000" when y(16) = '1' else
	B(7 downto 0) when y(25) = '1';	

temp <= C(7 downto 0) + A(7 downto 0);
CF <= C(7);
O_F <= CF xor temp(7) xor A(7);
F2 <= "00000001" when y(11) = '1' else "00000000";
	
F3 <= CF when y(9) = '1' else C(7);
	
F4 <= D2 when y(2) = '1'  else
	C(7 downto 0) when y(1) = '1';
	
F5 <= "111" when y(4) = '1' else
	"111" when y(15) = '1';
	
ARes <= D1 when y(1) = '1' or y(14) = '1' else
	A(6 downto 0)&'0' when y(18) = '1' or y(20) = '1' or y(22) = '1'or  y(24) = '1';
BRes <= F4 when y(2) = '1' or y(19) = '1' else
	C(0)&B(7 downto 1);


CRes <= (others => '0') when y(3) = '1' or y(13) = '1' else
	C(7 downto 0) + F1 + F2 when y(5) = '1' or y(11) = '1' or y(16) = '1' or y(25) = '1' else	  
	F3&C(7 downto 1) when y(9) = '1' or y(10) = '1' else
		C(6 downto 0)&'0' when y(17) = '1' or y(21) = '1' or y(23) = '1';

CnT <= F5 when y(4) = '1' or y(15) = '1' else 	 
	CnT - 1 when y(8) = '1' or y(26) = '1';	   
Res1 <= C(7 downto 0)&B(7 downto 0);
TgB <= B(0) when y(6) = '1';

x(1) <= B(0);
x(2) <= O_F;
x(3) <= '1' when CnT = "000" else '0';
x(4) <= TgB; 
end OA;
