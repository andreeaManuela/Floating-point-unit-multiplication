library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

--Regsitru cu resetare asincrona
--Registru B

entity FDN is
generic (n: natural :=23);
    Port ( clk : in STD_LOGIC;
           D : in std_logic_vector(n-1 downto 0);
           Rst: in std_logic;
           Q : out std_logic_vector(n-1 downto 0);
           CE : in STD_LOGIC); --Clock Enable 
end FDN;

architecture Behavioral of FDN is

begin

process(clk)
begin
if rising_edge(clk) then
   if Rst='1' then Q<= (others =>'0');
   else if CE='1' then Q<=D; --incarcarea paralela
        end if;
    end if;
end if;    
end process;
end Behavioral;
