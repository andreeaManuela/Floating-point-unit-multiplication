library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.all;

entity Comparator32biti is
     generic (N: integer := 32);
     Port ( 
        X: in std_logic_vector(N-1 downto 0);
        eq: out std_logic
     );
end Comparator32biti;

architecture Behavioral of Comparator32biti is
signal zero: std_logic_vector(31 downto 0):= "0000000000000000000000000000000";
begin
process(X)
begin
eq<='0';
if (X=zero) then
  eq<='1';
end if;
end process;
end Behavioral;
