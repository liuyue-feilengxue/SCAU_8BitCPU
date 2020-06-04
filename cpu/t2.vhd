library ieee;
use ieee.std_logic_1164.all;

entity t2 is
port(offset_4:in std_logic_vector(3 downto 0);--7 downto 0(offset_8)
     offset_8:out std_logic_vector(7 downto 0));--15 downto 0(offset_16)
end t2;

architecture behave of t2 is
begin
	process(offset_4)  --4 to 8
	begin--1 add 4 1,0 add 4 0
	if offset_4(3) = '1' then offset_8 <= "1111" & offset_4;
	else offset_8 <= "0000" & offset_4;
	end if;
	end process;
end behave; 