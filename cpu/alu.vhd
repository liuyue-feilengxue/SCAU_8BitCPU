library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu is
port(cin:in std_logic;
     alu_a,alu_b:in std_logic_vector(7 downto 0);  --15 to 0 
     alu_func:in std_logic_vector(2 downto 0);
     alu_out:out std_logic_vector(7 downto 0);  --15 to 0
     c,z,v,s:out std_logic);
end alu;

architecture behave of alu is
begin
	process(alu_a,alu_b,cin,alu_func)
	variable temp1,temp2,temp3 : std_logic_vector(7 downto 0) ;  --15 to 0  
	begin
		temp1 := "0000000"&cin;  --16 ge 0  进位扩展 
		case alu_func is   --运算结果都暂存为temp2  
			when "000"=>
			temp2 := alu_b+alu_a+temp1;
			when "001"=>
			temp2 := alu_b-alu_a-temp1;
			when "010"=>
			temp2 := alu_a and alu_b;
			when "011"=>
			temp2 := alu_a or alu_b;
			when "100"=>
			temp2 := alu_a xor alu_b;
			--B left move
			when "101"=>
			temp2(0) := '0';
			for I in 7 downto 1 loop  --15 downto 1
			temp2(I) := alu_b(I-1);
			end loop;
			--B right move
			when "110"=>
			temp2(7) := '0';  --temp2(15)
			for I in 6 downto 0 loop  -- 14 downto 0
			temp2(I) := alu_b(I+1);
			end loop;
			when others=>
			temp2 := "00000000";  --16 ge 0
		end case;
		alu_out <= temp2;  --将temp2赋给输出alu_out 
		
		--置标志位Z，判断运算结果是否为0     
		if temp2 = "00000000" then z<='1';  --16 ge 0
		else z<='0';
		end if;
		
		--置标志位S，判断运算结果的符号位（最高位）     
		if temp2(7) = '1' then s<='1';  --temp2(15)
		else s<='0';
		end if;
		
		--置标志位V，判断运算结果是否溢出    
		case alu_func is
			when "000" | "001"=>
			if (alu_a(7)= '1' and alu_b(7)= '1' and temp2(7) = '0') or  --all () is 15
			   (alu_a(7)= '0' and alu_b(7)= '0' and temp2(7) = '1') then  --all () is 15
			v<='1';
			else v<='0';
			end if;
			when others=>
			v<='0';
		end case;
		
		--置标志位C，判断运算结果是否有进位      
		case alu_func is
			when "000"=>
			temp3 := "11111111"-alu_b-temp1;  --16 ge 1
			if temp3<alu_a then
			c<='1';
			else c<='0';
			end if;
			when "001"=>
			if alu_b<alu_a then
			c<='1';
			else c<='0';
			end if;
			when "101"=>
			c <= alu_b(7);  --(15)
			when "110"=>
			c <= alu_b(0);
			when others=>
			c<='0';
		end case;
	end process;
end behave;