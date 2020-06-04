library ieee;
use ieee.std_logic_1164.all;

entity t1 is
	port(flag_c:in std_logic;
	     sci:in std_logic_vector(1 downto 0);
	     alu_cin:out std_logic);
end t1;

architecture behave of t1 is
begin
	process(sci,flag_c)
	begin
		case sci is
		when "00"=>
		alu_cin<='0';
		when "01"=>
		alu_cin<='1';
		when "10"=>
		alu_cin<=flag_c;
		when others=>
		alu_cin<='0';
		end case;
	end process;
end behave;