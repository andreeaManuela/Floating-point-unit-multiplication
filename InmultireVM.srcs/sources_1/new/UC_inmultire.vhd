library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.std_logic_arith.all;

entity UC_inmultire is
    generic (n: natural);
    Port ( clk : in STD_LOGIC;
           RstA: out std_logic;
           Q0 : in STD_LOGIC;
           Start : in STD_LOGIC;
           ShrAQ : out STD_LOGIC;
           Term : out STD_LOGIC;
           LoadA : out STD_LOGIC;
           LoadB : out STD_LOGIC;
           LoadQ : out STD_LOGIC);
end UC_inmultire;

architecture Behavioral of UC_inmultire is

--start=init
type tip_stare is (init, inactiv, add, shiftDr, stop, decizie);
signal stare_curenta: tip_stare;

signal C: natural :=n;
signal terminat: std_logic:='0';

begin

NumaratorC:process(clk)
begin
if rising_edge(clk) then 
  if stare_curenta=shiftDr then C<= C-1;
  elsif stare_curenta=inactiv then C<= n-1;
  end if;
end if;
end process;

process(clk)
begin
 if rising_edge(clk) then
    case stare_curenta is
    when inactiv => if Start='1' then stare_curenta <= init;
                    end if;
    when init => stare_curenta<= decizie;                
    when decizie => if Q0='1' then stare_curenta<= add;
                    else stare_curenta <= shiftDr;
                    end if;
     when add=> stare_curenta <= shiftDr;
     when shiftDr => if C=0 then stare_curenta<= stop;
                     else stare_curenta <= decizie; 
                     end if;
     when stop=> terminat<='1';                           
    
    end case;
 end if;
 Term<=terminat;
end process;

RstA<='1' when stare_curenta=inactiv else '0';
LoadA<='1' when stare_curenta=add else '0' ;
LoadB<='1' when stare_curenta=init else '0' ;
LoadQ<='1' when stare_curenta=init else '0';
ShrAQ<='1' when stare_curenta=shiftDr else '0';
Term<=terminat;



end Behavioral;
