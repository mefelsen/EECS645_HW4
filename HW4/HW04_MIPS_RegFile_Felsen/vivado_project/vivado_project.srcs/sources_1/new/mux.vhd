LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;
USE work.math_real.ALL;

ENTITY mux IS
  PORT (
    input : IN std_logic_vector(reg_file_width - 1 DOWNTO 0);
    sel   : IN std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0);
    RD    : OUT std_logic_vector(reg_file_width - 1 DOWNTO 0)
   );
END mux;

ARCHITECTURE Behavioral OF mux IS
BEGIN
--RD <= input(to_integer(unsigned(sel)));--FIX THIS
END Behavioral;
