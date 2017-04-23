
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UDCounterModule is
  port(Cin,Clk,PE,reset,UD: in std_logic;
       P: in std_logic_vector(4 downto 1);
       Cout: out std_logic;
       Q: out std_logic_vector(4 downto 1));
end UDCounterModule;

architecture Behavioral of UDCounterModule is



begin
  
  SetCout: process(Q,UD,Cin) is
  begin
    if Cin = '1' then
      Cout <= '1';
    elsif (UD = '1' and Q(1) = '1' and Q(4) = '1') then
      Cout <= '0';
    elsif (UD = '0' and Q = "0000") then
      Cout <= '0';
    else
      Cout <= '1';
    end if;
  end process;
      
  SetQ: process(Cin,PE,Reset,Clk) is
    
  begin
    if Reset = '1' then
      Q <= "0000";
    elsif PE = '1' then
      Q <= P;
    elsif Cin = '1' then
      null;
    elsif rising_edge(Clk) = '1' then
      if UD = '1' then
			Q<=Q+1; -- if UD is high count up
						-- code for when a pe out of range is given
		else
			Q<=Q-1; -- if UD is low
						-- code for when pe out of range
		end if;
    end if;
  end process;
      
end Behavioral;