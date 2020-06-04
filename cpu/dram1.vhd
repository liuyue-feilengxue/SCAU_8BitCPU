library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dram1 is
port(reset,wr : in std_logic;
         addr : in std_logic_vector(7 downto 0);
         data : inout std_logic_vector(7 downto 0));
end dram1;

architecture b_dram of dram1 is
type MEMORY is array(0 to 11) of std_logic_vector(7 downto 0);
signal mem : MEMORY;
begin
  process(reset,wr,addr,data)
  begin
    if reset='0' then            
	   mem<=( --others ЦёБо 
	          -- we need to calculate and write here
	          "11110000",
			  "00000101",
			  "11110100",
			  "00010011",
			  "11111000",
			  "00000000",
			  "11111100",
			  "00000100",
			  "00000100",
			  "01001100",
			  "00101110",
			  "10011101"
	        );
	end if;
    if wr='1' then
       data<=mem(conv_integer(addr));
    elsif wr='0' then
       mem(conv_integer(addr))<=data;
    end if;
  end process;
end b_dram;
