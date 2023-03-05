library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.numeric_std.all;

entity Sumator8 is
  generic (n:natural:=8);
  Port ( X: in std_logic_vector(n-1 downto 0);
         Y: std_logic_vector(n-1 downto 0);
         Tin: in std_logic;
         S: out std_logic_vector(n-1 downto 0);
         depasireSup: out std_logic:='0';
         depasireInf: out std_logic:='0';
         Tout: out std_logic);
end Sumator8;

architecture Behavioral of Sumator8 is
--signal suma:std_logic_vector(n-1 downto 0);
begin
process(X,Y,Tin)
variable T:std_logic_vector(n downto 0);
variable suma: std_logic_vector(n-1 downto 0);
variable inf: std_logic:='0';
variable sup: std_logic:='0';
variable nrSuperior: std_logic_vector(n-1 downto 0):="11111111";
variable nrInferior: std_logic_vector(n-1 downto 0):="00000000";
variable sumaFinala: std_logic_vector(n-1 downto 0);
variable unuDoiSapte: std_logic_vector(7 downto 0):="01111111";
begin

T(0):= Tin;
 for i in 0 to n-1 loop
   suma(i) := X(i) xor Y(i) xor T(i);
   T(i+1) := ( X(i) and Y(i) ) or ( X(i) and T(i) ) or ( Y(i) and T(i) );  --este i+1 pentru ca T(0) este Tin
 end loop;
 --se scade deplasamentul
sumaFinala:=suma-unuDoiSapte;
--depasire superioara 
if sumaFinala=nrInferior then inf:='1';
--depasire inferioara
elsif sumaFinala=nrSuperior then sup:='1';
end if;
S<=sumaFinala;
Tout<= T(n);
depasireInf<=inf;
depasireSup<=sup;
end process;

end Behavioral;
