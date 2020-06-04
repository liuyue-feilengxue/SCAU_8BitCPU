library ieee;
use ieee.std_logic_1164.all;

entity bus_dir is
	port(wr          : in std_logic;
	     data_bus    : inout std_logic_vector(15 downto 0);
	     alu_out     : in std_logic_vector(15 downto 0);
	     mem_data    : out std_logic_vector(15 downto 0));
end bus_dir;

architecture behave of bus_dir is
begin
	process(wr,data_bus,alu_out)
	begin
		case wr is
			when '1'=>
			mem_data<=data_bus;
			when '0'=>
			data_bus<=alu_out;
		end case;
	end process;
end behave;