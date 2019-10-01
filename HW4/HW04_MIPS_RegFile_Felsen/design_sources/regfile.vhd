LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;
USE work.math_real.ALL;

ENTITY RegFile IS
   PORT( 
      RA1      : IN  std_logic_vector (n_bits_of(reg_file_depth) - 1 DOWNTO 0);
      RA2 	   : IN  std_logic_vector (n_bits_of(reg_file_depth) - 1 DOWNTO 0);
      RegWrite : IN  std_logic;
      WA  	   : IN  std_logic_vector (n_bits_of(reg_file_depth) - 1 DOWNTO 0);
      WD  	   : IN  std_logic_vector (reg_file_width - 1 DOWNTO 0);
      clk      : IN  std_logic;
      rst      : IN  std_logic;
      RD1 	   : OUT std_logic_vector (reg_file_width - 1 DOWNTO 0);
      RD2 	   : OUT std_logic_vector (reg_file_width - 1 DOWNTO 0)
   );
END RegFile;

ARCHITECTURE behav OF RegFile IS

   -- Internal signal declarations
   SIGNAL reg_file  : mem_type(0 to reg_file_depth - 1);
   
   SIGNAL RA1_index : std_logic_vector (RA1'length - 1 DOWNTO 0);
   SIGNAL RA2_index : std_logic_vector (RA2'length - 1 DOWNTO 0);
   SIGNAL WA_index  : std_logic_vector (WA'length - 1 DOWNTO 0);
   
  
BEGIN

    --WA to address guard to DEMUX, accounting for write to 0, overflow, and address spilling
    WA_index <= WA when to_integer(unsigned(WA)) > 0 and to_integer(unsigned(WA)) < reg_file_depth
    else (OTHERS => '0');
    
    --RA1 and RA2 to address guard to MUX, account for overflow, and address spilling
    RA1_index <= RA1 when to_integer(unsigned(RA1)) >= 0 and to_integer(unsigned(RA1)) < reg_file_depth
    else (OTHERS => '0');
    RA2_index <= RA2 when to_integer(unsigned(RA2)) >= 0 and to_integer(unsigned(RA2)) < reg_file_depth
    else (OTHERS => '0');

    --MUXs for RD1 and RD2
    RD1 <= reg_file(to_integer(unsigned(RA1_index)));
    RD2 <= reg_file(to_integer(unsigned(RA2_index)));
    
    --Process for writing to registers
    write_access : PROCESS(clk, rst,WA,WA_index)
    
    BEGIN
    --WA to address guard to DEMUX, accounting for write to 0, overflow, and address spilling
    if to_integer(unsigned(WA)) > 0 and to_integer(unsigned(WA)) < reg_file_depth then
        WA_index <= WA ;
    else 
        WA_index <= (OTHERS => '0');
    end if;
    if rst = '1' then
        reg_file <= (OTHERS => zeros);
    elsif rising_edge(clk) and RegWrite = '1' then
      --After address guarding, WD can write to index
      if to_integer(unsigned(WA_index)) /= 0 then
        reg_file(to_integer(unsigned(WA_INDEX))) <= WD;
      end if;
    end if;       
    
    END PROCESS write_access;
    
    

END behav;
