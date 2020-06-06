library ieee;
use ieee.std_logic_1164.all;
--"可以用于选择寄存器，然后把寄存器的内容送出去"        
entity reg_mux is
	port(reg_0:   in std_logic_vector(7 downto 0);  --15
	     reg_1:   in std_logic_vector(7 downto 0);  --15
		 reg_2:   in std_logic_vector(7 downto 0);  --15
		 reg_3:   in std_logic_vector(7 downto 0);  --15
		 dest_reg:in std_logic_vector(1 downto 0);  --3 downto 0  下同 
		 sour_reg:in std_logic_vector(1 downto 0);
		 reg_sel: in std_logic_vector(1 downto 0);--"xuan ze ji hao"
		 en:      in std_logic;
		 en_0:    out std_logic;
	     en_1:    out std_logic;
		 en_2:    out std_logic;
		 en_3:    out std_logic;	
		 dr:      out std_logic_vector(7 downto 0);  --15**
	     sr:      out std_logic_vector(7 downto 0);  --15
	     reg_out: out std_logic_vector(7 downto 0));--'kan ji hao jiu shu chu ji hao' 15	
end reg_mux;

architecture behave of reg_mux is
begin
	process(dest_reg,sour_reg,reg_sel,reg_0,reg_1,
		    reg_2,reg_3,en)
	variable temp : std_logic_vector(3 downto 0);  --15
	begin
		case dest_reg is
		when "00"=>
			dr<=reg_0;
			temp := "0001";
		when "01"=>
			dr<=reg_1;
			temp := "0010";
		when "10"=>
			dr<=reg_2;
			temp := "0100";
		when "11"=>
			dr<=reg_3;
			temp := "1000";
		end case;
		if en = '0' then
			temp := "0000";
		end if;
		en_0 <= temp(0);
		en_1 <= temp(1);
		en_2 <= temp(2);
		en_3 <= temp(3);
		case sour_reg is
		when "00"=>
			sr<=reg_0;
		when "01"=>
			sr<=reg_1;
		when "10"=>
			sr<=reg_2;
		when "11"=>
			sr<=reg_3;
		end case;
		case reg_sel is
		when "00"=>
			reg_out<=reg_0;
		when "01"=>
			reg_out<=reg_1;
		when "10"=>
			reg_out<=reg_2;
		when "11"=>
			reg_out<=reg_3;
		end case;
	end process;
end behave;