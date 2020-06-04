library ieee;
use ieee.std_logic_1164.all;

entity reg_test is
	port(clk,reset   : in std_logic;
	     input_0     : in std_logic;
		 input_1     : in std_logic;
		 input_2     : in std_logic;
		 input_3     : in std_logic;
		 input_4     : in std_logic;
		 input_5     : in std_logic;
	  	 input_6     : in std_logic;
		 input_7     : in std_logic;
		 input_8     : in std_logic;
		 input_9     : in std_logic;
		 input_a     : in std_logic;
		 input_b     : in std_logic;
		 input_c     : in std_logic;
		 input_d     : in std_logic;
		 input_e     : in std_logic;
		 input_f     : in std_logic;
	     q           : out std_logic_vector(15 downto 0));
end reg_test;

architecture behave of reg_test is
begin
	process(clk,reset)
	variable temp: std_logic_vector(15 downto 0);
	begin
	    temp := input_f & input_e & input_d & input_c & input_b & input_a & input_9
	            & input_8 & input_7 & input_6 & input_5 & input_4 & input_3 & input_2
	            & input_1 & input_0;
		if reset = '1' then            
          q <= "0000000000000000";
        elsif clk'event and clk = '1' then
			q <= temp;
        end if;
	end process;
end behave;