library ieee;
use ieee.std_logic_1164.all;

entity controllertest is
port(
	 --节拍
	 timer:                   in std_logic_vector(2 downto 0);
	 --节拍内容
     instruction:             in std_logic_vector(7 downto 0);
     --标志位
     c,z,v,s:                 in std_logic;
     dest_reg,sour_reg:       out std_logic_vector(1 downto 0);
     --偏移地址
     offset:                  out std_logic_vector(3 downto 0);
     --输出控制信号
     sst,sci,rec:             out std_logic_vector(1 downto 0);
     alu_func,alu_in_sel:     out std_logic_vector(2 downto 0);
     en_reg,en_pc,wr:         out std_logic);
end controllertest;

architecture behave of controllertest is
begin
	process(timer,instruction,c,z,v,s)
	--暂存指令高4位(temp1)、低4位(temp2)
	variable temp1,temp2 : std_logic_vector(3 downto 0) ;
	--暂存指令低4位中的高2位(temp3)、低2位(temp4)
	variable temp3,temp4 : std_logic_vector(1 downto 0) ;
	variable alu_out_sel: std_logic_vector(1 downto 0);
	begin
		--暂存指令高4位、低4位
	    for I in 3 downto 0 loop
		    temp1(I):=instruction(I+4); --暂存指令高4位
		    temp2(I):=instruction(I); 	--暂存指令低4位
	    end loop;
	    --暂存指令低4位的高2位、低2位
	    for I in 1 downto 0 loop
		    temp3(I):=instruction(I+2);	--暂存低4位中的高2位
		    temp4(I):=instruction(I);	--暂存低4位中的低2位
	    end loop;

		case timer is
			--初始状态
		    when "100"=>
				dest_reg<="00";
				sour_reg<="00";
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="00";
			--读取指令第一拍
			--AR<-PC, PC<-PC+1
			when "000"=>
				dest_reg<="00";
				sour_reg<="00";
				offset<="0000";
				sci<="01";
				sst<="11";
				alu_out_sel:="10";
				alu_in_sel<="100";
				alu_func<="000";
				wr<='1';
				rec<="01";
			--读内存，放到指令寄存器
			--IR<-MEM
			when "001"=>
				dest_reg<="00";
				sour_reg<="00";
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_out_sel:="00";
				alu_in_sel<="000";
				alu_func<="000";
				wr<='1';
				rec<="10";

			--A组指令
			when "011"=>
				wr<='1';
				rec<="00";
				--temp1：指令高4位，OP码
				case temp1 is
					--ADD
					when "0000"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="000";
					--SUB
					when "0001"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="001";
					--AND
					when "0010"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="000";
					alu_func<="010";
					--NEG
					when "0011"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="111";
					--ROL
					when "0100"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="011";
					--ROR
					when "0101"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="00";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="100";
					--RCL
					when "0110"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="10";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="101";
					--RCR
					when "0111"=>
					dest_reg<=temp3;
					sour_reg<=temp4;
					offset<="0000";
					sci<="10";
					sst<="00";
					alu_out_sel:="01";
					alu_in_sel<="010";
					alu_func<="110";
					--JR
					when "1000"=>
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:="10";
					alu_in_sel<="011";
					alu_func<="000";
					--JRC
					when "1001"=>
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="11";
					alu_out_sel:=c&"0";
					alu_in_sel<="011";
					alu_func<="000";
					--STC
					when "1010"=>
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="10";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="000";
					--CLC
					when "1011"=>
					dest_reg<="00";
					sour_reg<="00";
					offset<=temp2;
					sci<="00";
					sst<="01";
					alu_out_sel:="00";
					alu_in_sel<="000";
					alu_func<="000";
					--其他
					when others=>
					null;
				end case;

			--B组指令
			when "101"=>
				alu_func<="000";
				wr<='1';
				sst<="11";
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="0000";
				--temp1：指令高4位，OP码
				case temp1 is
					--JMPA、MVRD
					--读取双字指令的后一半
					when "1100" | "1101"=>
					sci<="01";
					alu_out_sel:="10";
					alu_in_sel<="100";
					rec<="01";
					--LDRR
					--目的地址送地址寄存器
					when "1110"=> 
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="001";
					rec<="11";
					--STRR
					when "1111"=>
					sci<="00";
					alu_out_sel:="00";
					alu_in_sel<="010";
					rec<="11";
					when others=>
					null;
				end case;
			--读写内存
			when "111"=>
				dest_reg<=temp3;
				sour_reg<=temp4;
				offset<="0000";
				sci<="00";
				sst<="11";
				alu_func<="000";
				rec<="00";
				case temp1 is
					--LDRR、MVRD
					when "1110" | "1101"=>
					alu_out_sel:="01";
					alu_in_sel<="101";
					wr<='1';
					--JMPA
					when "1100"=> 
					alu_out_sel:="10";
					alu_in_sel<="101";
					wr<='1';
					--STRR
					when "1111"=>
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
