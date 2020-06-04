library ieee;
use ieee.std_logic_1164.all;

entity flag_reg is
	port(sst:                         in std_logic_vector(1 downto 0);
	     c,z,v,s,clk,reset:           in std_logic;
	     flag_c,flag_z,flag_v,flag_s: out std_logic);
end flag_reg;

architecture behave of flag_reg is
begin
	process(clk,reset)
	begin
		if reset = '0' then
			flag_c<='0';
			flag_z<='0';
			flag_v<='0';
			flag_s<='0';
		elsif clk'event and clk = '1' then
			case sst is
				when "00"=>
				flag_c<=c;
				flag_z<=z;
				flag_v<=v;
				flag_s<=s;
				when "01"=>
				flag_c<='0';
				when "10"=>
				flag_c<='1';
				when "11"=>
				null;
			end case;
		end if;
	end process;
end behave;