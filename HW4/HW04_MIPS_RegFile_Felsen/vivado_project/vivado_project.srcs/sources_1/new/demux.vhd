LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;
USE work.math_real.ALL;

ENTITY demux IS
    PORT(
    RegWrite    : IN std_logic;
    sel         : IN std_logic_vector(n_bits_of(reg_file_depth) - 1 DOWNTO 0);
    output      : OUT std_logic_vector(reg_file_width - 1 DOWNTO 0)
);
END demux;

ARCHITECTURE Behavioral OF demux IS
BEGIN
demux_process : PROCESS (RegWrite, sel)
BEGIN
    output <= (OTHERS => '0');
    IF RegWrite = '1'  THEN
        output(to_integer(unsigned(sel))) <= '1';
    END IF;
END PROCESS;

end Behavioral;
