library ieee;
use ieee.std_logic_1164.all;

entity t3 is
port(wr          : in std_logic;
     alu_out     : in std_logic_vector(7 downto 0);--15
     output      : out std_logic_vector(7 downto 0));--15
end t3;

architecture behave of t3 is
begin
	process(wr,alu_out)
	begin
		case wr is
		when '1'=>
			output<="ZZZZZZZZ";--16 ge z
		when '0'=>
			output<=alu_out;
		end case;
	end process;
end behave;