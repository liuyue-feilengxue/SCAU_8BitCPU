library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg_out is
    port(ir,pc,reg_in:        in std_logic_vector(7 downto 0);  --delet(only in reg_in)  15 downto 0
         offset,alu_a,alu_b:  in std_logic_vector(7 downto 0);  --15
         alu_out:             in std_logic_vector(7 downto 0); --15
         reg_testa:           in std_logic_vector(7 downto 0);  --15
         reg_sel:             in std_logic_vector(1 downto 0);  --3
         sel:                 in std_logic_vector(1 downto 0);
		 reg_data:            out std_logic_vector(7 downto 0));
end reg_out;

architecture behave of reg_out is
begin
	process(ir,pc,reg_in,sel,reg_sel,offset,alu_a,alu_b,alu_out,reg_testa)
	variable temp: std_logic_vector(3 downto 0) ;
	begin
	    temp := sel & reg_sel;
		case sel is
			when "00"=>
				reg_data<=reg_in;
			when others=>
				reg_data<="00000000";
		end case;
	end process;
end behave;
