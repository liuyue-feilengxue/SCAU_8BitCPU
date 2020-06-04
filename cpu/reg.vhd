library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port(d:            in std_logic_vector(7 downto 0);  --15
	     clk,reset,en: in std_logic;
	     q:out std_logic_vector(7 downto 0));  --15
end reg;
--"¼Ä´æÆ÷£¬Ö»ÓÃ4¸ö"    
architecture behave of reg is
begin
	process(clk,reset,en)
		begin
			if reset = '0' then            
          		q <= "00000000";--16 ge 0
        	elsif clk'event and clk = '1' then
          		if en = '1' then
					q <= d;
		  		end if;
        	end if;
	end process;
end behave;
