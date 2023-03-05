library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sum1bit is
  Port ( a: in std_logic;
         b: in std_logic;
         cIn: in std_logic;
         s: out std_logic;
         cOut: out std_logic );
end sum1bit;

architecture Behavioral of sum1bit is

begin
  
  s <= a xor b xor cIn;
  cOut<= (a and b) or (a and cIn) or (b and cIn);

end Behavioral;
