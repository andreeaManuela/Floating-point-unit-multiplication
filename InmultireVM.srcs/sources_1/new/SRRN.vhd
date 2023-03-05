library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

--Registru de deplasare la dreapta de n biti cu resetare asincrona
--Registru de deplasare pt A si Q

entity SRRN is
    generic (n:natural);
    Port ( clk : in STD_LOGIC;
           Rst: in std_logic;
           D : in std_logic_vector(n-1 downto 0);
           Q : out STD_LOGIC_vector(n-1 downto 0);
           CE : in STD_LOGIC;
           SRI : in STD_LOGIC; 
           Load : in STD_LOGIC);
end SRRN;

architecture Behavioral of SRRN is
signal output: std_logic_vector(n-1 downto 0);

begin
process(clk)
begin
if rising_edge(clk) then
   if Rst='1' then output<= (others => '0');
   else if Load='1' then output<=D;
        else if CE='1' then output<= SRI & output(n-1 downto 1); --deplasare la dreapta 
             end if;
        end if;
   end if;
end if;
end process;

Q<=output;
end Behavioral;
