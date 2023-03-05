library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.ALL;

entity InmultireVM is
  Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
         y : in STD_LOGIC_VECTOR (31 downto 0);
         z : out STD_LOGIC_VECTOR (31 downto 0);
         clk: in std_logic;
         Stop: out std_logic );
end InmultireVM;

architecture Behavioral of InmultireVM is

signal x_semn: std_logic;
signal y_semn: std_logic;
signal x_exponent: std_logic_vector(7 downto 0);
signal y_exponent: std_logic_vector(7 downto 0);
signal x_mantisa: std_logic_vector(22 downto 0);
signal y_mantisa: std_logic_vector(22 downto 0);
signal z_semn: std_logic;
signal z_exponent: std_logic_vector(7 downto 0);
signal z_mantisa: std_logic_vector(22 downto 0);
signal zPartial: std_logic_vector(31 downto 0);

--Semnale pentru Inmultire
signal inmultireOut: std_logic_vector(47 downto 0);
signal inmultireStop: std_logic;
signal mantisaZero: std_logic;

--Semnale pentru adunarea exponentilor
signal sumaExponenti: std_logic_vector(7 downto 0);
signal depasireSupAdd: std_logic;
signal depasireInfAdd: std_logic;
signal Tout: std_logic:='0';

--semnale pentru normalizare
signal produsNormalizat: std_logic_vector(47 downto 0);
signal finishNorm: std_logic;
signal depasireInfNorm: std_logic;
signal exponentFinal: std_logic_vector(7 downto 0);

--semnale rotunjire
signal rezultatFinal: std_logic_vector(22 downto 0);

--semnal UC
signal rezZero:std_logic;

begin

x_semn<=x(31);
y_semn<=y(31);
x_exponent<=x(30 downto 23);
y_exponent<=y(30 downto 23);
x_mantisa<=x(22 downto 0);
y_mantisa<=y(22 downto 0);


AdunareaExponentilor: entity work.Sumator8 generic map(n=>8)
          port map(X=> x_exponent,
                   Y=> y_exponent,
                   Tin=> '0',
                   S=>sumaExponenti,
                   depasireSup=>depasireSupAdd,
                   depasireInf=>depasireInfAdd,
                   Tout=>Tout);

InmultireaMantiselor: entity work.Inmultire generic map (n=>23)
         port map( X=>x_mantisa,
                   Y=>y_mantisa,
                   Produs=>inmultireOut,
                   mantisaZero=> mantisaZero,
                   Term=>inmultireStop  
                   );

NormalizareaRezultatului: entity work.Normalizare generic map(n=>8)
        port map(exponentIn=>sumaExponenti,
                 produsIn=>inmultireOut,
                 Start=>'1',
                 produsOut=>produsNormalizat,
                 Terminat=>finishNorm,
                 depasireInf=>depasireInfNorm,
                 exponentOut=>exponentFinal
                 );   
                
 RotunjireRezultat: entity work.Rotunjire generic map(n=>23)
 port map(mantisaIn=>produsNormalizat,
          mantisaOut=> rezultatFinal
 ); 
 
 UnitateControl: entity work.Control generic map (n=>32)
  port map ( clk=>clk,
             X=>x,
             Y=>y,
             Start=>'1',
             Stop=>Stop,
             rezZero=>rezZero,
             TerminatInmultire=>inmultireStop,
             depasireInf=>depasireInfAdd,
             depasireInf2=>depasireInfNorm,
             depasireSup=>depasireSupAdd
  );                              

--depasireInf la normalizare
--process(rezultatFinal, produsNormalizat)
--begin
--if depasireInfNorm='0' then z_mantisa<=produsNormalizat(46 downto 24);
--else z_mantisa<=rezultatFinal;
--end if;
--end process;

--Proces unde tratez cazul in care una din mantise este zero
process(rezultatFinal)
begin
if mantisaZero='1' then z_mantisa<=(others=>'0');
else z_mantisa<=rezultatFinal;
end if;
end process;

--z_mantisa<=rezultatFinal;    
z_exponent<=exponentFinal;
z_semn<= x_semn xor y_semn;
zPartial(31)<=z_semn;
zPartial(30 downto 23)<= z_exponent;
zPartial(22 downto 0)<=z_mantisa;

--Tratez cazul in care X sau Y este zero
process(rezZero, zPartial)
begin
if rezZero='1' then
  z<=x"00000000";
else z<=zPartial;  
end if;
end process;
end Behavioral;
