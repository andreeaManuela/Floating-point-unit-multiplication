library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity automat_stari is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           z : out STD_LOGIC_VECTOR (31 downto 0);
           depasire_sup: out STD_LOGIC:='0';
           depasire_inf: out std_logic:='0');
end automat_stari;

architecture Behavioral of automat_stari is

begin

process(x,y)
 variable x_mantisa: std_logic_vector(22 downto 0);
 variable x_exponent: std_logic_vector(7 downto 0);
 variable x_semn: std_logic;
 variable y_mantisa: std_logic_vector(22 downto 0);
 variable y_exponent: std_logic_vector(7 downto 0);
 variable y_semn: std_logic;
 variable z_mantisa: std_logic_vector(22 downto 0);
 variable z_exponent: std_logic_vector(7 downto 0);
 variable z_semn: std_logic;
 variable sum_exp: std_logic_vector(7 downto 0);
 variable a: std_logic_vector(3 downto 0);
 variable q: std_logic_vector(3 downto 0);
 
begin
 x_mantisa := x(22 downto 0);
 x_exponent :=x(30 downto 23);
 x_semn := x(31);
 
 y_mantisa := y(22 downto 0);
 y_exponent :=y(30 downto 23);
 y_semn := y(31);
 
 if (x=0) then 
   z <= (others => '0');
   --stop
 elsif (y=0) then
    z <= (others => '0');
    --stop
  else
     --adunarea exponentilor
     z_exponent:= x_exponent + y_exponent;
     --scade deplasamentul 
     z_exponent(7 downto 0):= z_exponent(6 downto 0) &'0';
     if(z_exponent>127) then
         depasire_sup<='1';
     elsif z_exponent<-128 then 
          depasire_inf<='1'; 
     else 
        --inmultirea mantiselor
        --?????  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        --z_mantisa := x_mantisa * y_mantisa;
        --normalizarea rezultatului 
        a:=z_mantisa(7 downto 4);
        q:=z_mantisa(3 downto 0);
        if a(3)='0' then
          a(3 downto 0) :=a(2 downto 0) &'0';
          a(0):=q(3);
        elsif a(3)='1' then
           z_exponent := z_exponent+1;
        
        if z_exponent<-128 then
           depasire_inf<='1'; 
        else 
        --rotunjeste rezultatul ?????????
        
        --seteaza semnul lui z
        z_semn:= x_semn xor y_semn;
        end if;
        end if;
     end if;
  end if;  
    

z(22 downto 0) <= z_mantisa;
z(30 downto 23) <= z_exponent;
z(31) <= z_semn;
 
end process;


end Behavioral;
