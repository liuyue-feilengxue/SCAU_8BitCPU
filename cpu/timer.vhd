library ieee;
use ieee.std_logic_1164.all;

entity timer is
   port(
      clk      : in std_logic;
      reset    : in std_logic;
      ins      : in std_logic_vector(7 downto 0);--15 
      output   : out std_logic_vector(2 downto 0));
end timer;

architecture behave of timer is
	type state_type is(s0,s1,s2,s3,s4,s5);
	signal state:state_type;
begin
	process(clk,reset,ins)
	begin
		if reset='0' then state<=s0;
		elsif (clk'event and clk='1') then
			case state is
				when s0=>
					state<=s1;
				when s1=>
					state<=s2;
				when s2=>
					if ins(7)='1' and ins(6)='1' then --if ins(15)='0' then
					state<=s4;--A  s3
					else state<=s3;--B  s4
					end if;
				when s3=>
					state<=s1;
				when s4=>
					state<=s5;
				when s5=>
					state<=s1;
			end case;
        end if;
	end process;
	process(state)
	begin
		case state is
			when s0=>
			output<="100"; 
			when s1=>
			output<="000"; 
			when s2=>
			output<="001"; 
			when s3=>
			output<="011"; 
			when s4=>
			output<="101"; 
			when s5=>
			output<="111";
		end case;
	end process;
end behave;	