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
   
   component demux
   port (
   RegWrite    : IN std_logic;
   sel         : IN std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0);
   output      : OUT std_logic_vector(reg_file_width - 1 DOWNTO 0)
   );
   end component;
   
   component mux
   PORT (
    input : IN std_logic_vector(reg_file_width - 1 DOWNTO 0);
    sel   : IN std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0);
    RD    : OUT std_logic_vector(reg_file_width - 1 DOWNTO 0)
   );
   end component;
   
   component d_flipflop
      port(
      Q     : out std_logic;
      en    : in std_logic;    
      clk   : in std_logic;   
      D     : in  std_logic;
      rst   : in std_logic    
   );
   end component;
   
   component address_guard
    port(
        input     : IN std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0);
        output    : OUT std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0)
        );
   end component;
   
BEGIN
demux1 : demux PORT MAP(
RegWrite => RegWrite,
sel => WA_index,
output => reg_file
);

mux1: mux PORT MAP(
input => RA1_index,
sel => RA1_index,
RD => RD1
);

mux2: mux PORT MAP(
input => RA2_index,
sel => RA2_index,
RD => RD2
);

WA_guard: address_guard PORT MAP(
input => WA,
output => WA_index
);

RA1_guard: address_guard PORT MAP(
input => RA1,
output => RA1_index
);

RA2_guard: address_guard PORT MAP(
input => RA2,
output => RA2_index
); 

END behav;
