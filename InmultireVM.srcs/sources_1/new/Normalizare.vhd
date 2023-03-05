library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Normalizare is
  generic (n: natural:=8);
  Port ( exponentIn: in std_logic_vector(n-1 downto 0);
         produsIn: in std_logic_vector(47 downto 0);
         Start: in std_logic;
         produsOut: out std_logic_vector(47 downto 0);
         Terminat: out std_logic;
         depasireInf:out std_logic:='0';
         exponentOut: out std_logic_vector(n-1 downto 0)  ); --nr de incrementari ale exponentului
end Normalizare;

architecture Behavioral of Normalizare is
begin

process(produsIn)
variable produsNormalizat: std_logic_vector(47 downto 0);
    variable nr_pozitii: std_logic_vector(7 downto 0);
    variable term: std_logic;
    variable expOut: std_logic_vector(7 downto 0);
    begin
      nr_pozitii:="00000000";
      produsNormalizat:=produsIn;
      term:='0';
    if Start='1' then
    normalizare:for i in 0 to 47 loop
      if produsIn(47-i)='0' then 
          produsNormalizat:=produsNormalizat(46 downto 0) & '0'; --deplasare la dreapta 
          nr_pozitii:= nr_pozitii +1; 
      else term:='1'; 
           exit normalizare;  
             
      end if;
     end loop;
     expOut:=exponentIn;
     --Verifica depasirea inferioara dupa normalizare
     if expOut<"00000000" then depasireInf<='1';
     end if; 
     produsOut<=produsNormalizat(47 downto 0);
     Terminat<=term;
     exponentOut<=expOut;
     end if;
    end process;

end Behavioral;
