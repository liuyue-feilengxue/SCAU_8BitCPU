library ieee;
use ieee.std_logic_1164.all;

entity ar is
	port(alu_out:   in std_logic_vector(7 downto 0);  --15
	     pc:        in std_logic_vector(7 downto 0);  --15
	     rec:       in std_logic_vector(1 downto 0);
	     clk,reset: in std_logic;
	     q:         out std_logic_vector(7 downto 0));  --15
end ar;

architecture behave of ar is
begin
	process(clk,reset)
	begin
		if reset = '0' then            
          q <= "00000000";  --16 ge 0
        elsif clk'event and clk = '1' then
			case rec is
				when "01"=>
				q <= pc;
				when "11"=>
				q <= alu_out;
				when others=>
				null;
			end case;		
        end if;
	end process;
end behave;