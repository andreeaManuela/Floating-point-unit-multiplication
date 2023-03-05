library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.all;

entity Control is
  generic (n: natural:=32);
  Port( clk: in std_logic;
        X: in std_logic_vector(31 downto 0);
        Y: in std_logic_vector(31 downto 0);
        Start: in std_logic;
        Stop: out std_logic;
        rezZero: out std_logic:='0';
        TerminatInmultire: out std_logic;
        depasireInf: in std_logic;
        depasireInf2: in std_logic;
        depasireSup: in std_logic
  );
end Control;

architecture Behavioral of Control is
type stari is (inactiv, init, checkX, checkY, addExp, depSup, depInf, multiply, normalizare, rotunjire, finish);
signal stare_curenta: stari;

begin
process(clk)
begin
if rising_edge(clk) then
   case stare_curenta is 
    when inactiv => if Start='1' then stare_curenta<= init;
                    end if;
    when init => stare_curenta<=checkX;
    when checkX => if X=x"00000000" then rezZero<='1';
                                     Stop<='1';
                    else stare_curenta<=checkY;
                    end if;              
    when checkY =>  if Y=x"00000000" then rezZero<='1';
                                     Stop<='1';
                    else stare_curenta<=addExp;
                    end if;  
    when addExp => stare_curenta<= depSup;
    when depSup=>  if depasireSup='1' then Stop<='1';
                   else stare_curenta<= depInf;
                   end if; 
    when depInf => if depasireInf='1' then Stop<='1';
                   else stare_curenta<= multiply;
                   end if; 
    when multiply => stare_curenta<=normalizare;
    when normalizare => if depasireInf2='1' then Stop<='1';
                   else stare_curenta<= rotunjire;
                   end if;
    when rotunjire => stare_curenta<=finish;
    when finish => Stop<='1'; stare_curenta<=inactiv;                                                                           
    end case;
end if;
end process;
end Behavioral;

