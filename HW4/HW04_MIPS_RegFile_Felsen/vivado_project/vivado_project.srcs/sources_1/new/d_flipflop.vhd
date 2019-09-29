LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;
USE work.math_real.ALL;

entity d_flipflop is 
   port(
      Q     : out std_logic;
      en    : in std_logic;    
      clk   : in std_logic;   
      D     : in  std_logic;
      rst   : in std_logic    
   );
end d_flipflop;
architecture Behavioral of d_flipflop is  
begin  
 process(clk)
 begin 
    if(rising_edge(clk) and en = '1') then
        if rst = '1' then 
            Q <= '0';
        else
            Q <= D;
        end if; 
    end if;       
 end process;  
end Behavioral;