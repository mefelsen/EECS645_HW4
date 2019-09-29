LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;
USE work.math_real.ALL;

entity address_guard is
  Port (
  input     : IN std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0);
  output    : OUT std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0)
  );
end address_guard;

architecture Behavioral of address_guard is

begin
--if input > reg_file_depth then
    --output <= std_logic_vector(reg_file_depth - 1 downto 0);
--elsif input < 0 then
    --output <= 0;
--else
    --output <= input
 --end if
end Behavioral;
