library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dram is
port(reset,wr : in std_logic;
         addr : in std_logic_vector(15 downto 0);
         data : inout std_logic_vector(15 downto 0));
end dram;

architecture b_dram of dram is
type MEMORY is array(0 to 17) of std_logic_vector(15 downto 0);
signal mem : MEMORY;
begin
  process(reset,wr,addr,data)
  begin
    if reset='0' then            
	   mem<=( --others ЦёБо 
	          -- we need to calculate and write here
	          x"8100",--"1000000100000000",
	          x"0019",--"0000000000011001",
	          x"8110",--"1000000100010000",
	          x"0006",--"0000000000000110",
	          x"8120",--"1000000100100000",
	          x"0000",--"0000000000000000",
	          x"8130",--"1000000100110000",
	          x"0008",--"0000000000001000",
	
	          x"8140",--"1000000101000000",
	          x"0001",--"0000000000000001",
	          x"0241",--"0000001001000001",
	          x"4601",--"0100011000000001",
	          x"0020",--"0000000000100000",
	          x"0A00",--"0000101000000000",
	          x"0B10",--"0000101100010000",
	          x"0830",--"0000100000110000",
	          x"47F7",--"01000111 1111 0111",
	          x"40FF"--"0100000011111111"
	        );
	end if;
    if wr='1' then
       data<=mem(conv_integer(addr));
    elsif wr='0' then
       mem(conv_integer(addr))<=data;
    end if;
  end process;
end b_dram;
