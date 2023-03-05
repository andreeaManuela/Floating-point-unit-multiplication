library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;

entity Inmultire is
  generic (n: natural:=23);
  Port ( 
         X: in std_logic_vector(22 downto 0);
         Y: in std_logic_vector(22 downto 0);
         Produs: out std_logic_vector(47 downto 0);
         mantisaZero: out std_logic;
         Term: out std_logic  
        );
end Inmultire;

architecture Behavioral of Inmultire is
signal p: std_logic_vector(47 downto 0);
signal nr1, nr2: std_logic_vector(23 downto 0);
signal gata: std_logic;
signal zeroMantisa: std_logic_vector(22 downto 0):=(others=>'0');
signal zero: std_logic:='0';

begin
process(X,Y, nr1, nr2,p, gata,zero)
begin
if X=zeroMantisa then zero<='1'; p<=(others=>'0');
elsif Y=zeroMantisa then zero<='1'; p<=(others=>'0');
else
nr1<='1' & X(22 downto 0);
nr2<='1' & Y(22 downto 0);
p<=std_logic_vector(unsigned(nr1) * unsigned(nr2));
gata<='1';
end if;
Produs<=p;
mantisaZero<=zero;
Term<=gata;
end process;
end Behavioral;
