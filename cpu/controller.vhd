library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(timer:                   in std_logic_vector(2 downto 0);
     instruction:             in std_logic_vector(7 downto 0);  -- 15
     c,z,v,s:                 in std_logic;
     dest_reg,sour_reg:       out std_logic_vector(1 downto 0);  --3
     offset:                  out std_logic_vector(3 downto 0);  --7
     sst,sci,rec:             out std_logic_vector(1 downto 0);
     alu_func,alu_in_sel:     out std_logic_vector(2 downto 0);
     en_reg,en_pc,wr:         out std_logic);
end controller;

architecture behave of controller is
begin
	process(timer,instruction,c,z,v,s)
	variable temp1,temp2 : std_logic_vector(3 downto 0) ;--7
	variable temp3,temp4 : std_logic_vector(1 downto 0) ;--3
	variable alu_out_sel: std_logic_vector(1 downto 0);
	begin
	    for I in 3 downto 0 loop--3
		    temp1(I):=instruction(I+4);--I+8
		    temp2(I):=instruction(I);
	    end loop;
	    for I in 1 downto 0 loop
		    temp3(I):=instruction(I+2);  --I+4
		    temp4(I):=instruction(I);
	    end loop;
		case timer is
		    when "100"=>
				dest_reg<="00";  --0000
				sour_reg<="00";  --0000
				offset<="0000";  --8 ge 0
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="00";
			when "000"=>
				dest_reg<="00";  --0000
				sour_reg<="00";  --0000
				offset<="0000";  --8 ge 0
				sci<="01";
				sst<="11";
				alu_out_sel:="10";
				alu_in_sel<="100";
				alu_func<="000";
				wr<='1';
				rec<="01";
			when "001"=>
				dest_reg<="00";--0000
				sour_reg<="00";--0000
				offset<="0000";--00000000
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="10";
			when "011"=>
				wr<='1';
				rec<="00";
				case temp1 is
					when "0000"=>--add
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";--8 ge 0
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					
					when "0001"=>--and
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";--8 ge 0
					sci<="00";
					sst<="00";
					alu_out_sel:="01";--
					alu_in_sel<="000";--
					alu_func<="010";--001
					when "0010"=> --cmp
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";--8ge0
					sci<="00";
					sst<="00";
					alu_out_sel:="00";--01
					alu_in_sel<="000";
					alu_func<="001";--010
					when "0011"=> --MVRR
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="11";
					alu_out_sel:="01";
					alu_in_sel<="001";
					alu_func<="000";
					when "0100"=> --DEC
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="01";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="001";
					when "0101"=>--shl
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="101";
					when "0110"=>--adc
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="10";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					when "0111"=>--jr
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:="10";
					alu_in_sel<="011";
					alu_func<="000";
					when "1000"=>--jrc
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=c&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "1001"=>--jrnz
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=(not z)&"0";
					alu_in_sel<="011";
					alu_func<="000";
					when "1010"=>--clc
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="01";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="000";
					when "1011"=>--stc
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="10";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="000";
					when others=>
					null;
				end case;
			when "101"=>--B×é
				alu_func<="000";
				wr<='1';
				sst<="11";
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="0000";
				case temp1 is
					when "1100" | "1111"=>  --jmpa mvrd
					sci<="01";
					alu_out_sel:="10";
					alu_in_sel<="100";
					rec<="01";
					when "1101"=> --ldrr 
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="001";
					rec<="11";
					when "1110"=>--strr
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="010";
					rec<="11";
					when others=>
					null;
				end case;
			when "111"=>
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_func<="000";
				rec<="00";
				case temp1 is
					when "1101" | "1111"=>-- ldrr mvrd
					alu_out_sel:="01";
					alu_in_sel<="101";
					wr<='1';
					when "1100"=>  --jmpa
					alu_out_sel:="10";
					alu_in_sel<="101";
					wr<='1';
					when "1110"=>--strr
					alu_out_sel:="00";
					alu_in_sel<="001";
					wr<='0';
					when others=>
					null;
				end case;
			when others=>
			null;
		end case;
		en_reg<=alu_out_sel(0);
		en_pc<=alu_out_sel(1);
	end process;
end behave;