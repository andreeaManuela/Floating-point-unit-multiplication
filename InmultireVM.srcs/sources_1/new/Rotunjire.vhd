library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rotunjire is
  generic (n: natural :=23);
  Port (  mantisaIn: in std_logic_vector(47 downto 0);
          mantisaOut: out std_logic_vector(n-1 downto 0)
  );
end Rotunjire;

architecture Behavioral of Rotunjire is

begin

mantisaOut<= mantisaIn(46 downto 24);

end Behavioral;
