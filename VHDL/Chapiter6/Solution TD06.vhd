                                     TD06
-----------------------------------------------------
----------------------Exercice1----------------------
Library ieee;
use ieee.std_logic_1164.all;

entity EXO_1 is
port (A,B,Cin : in std_logic;
     SUM,Cout : out std_logic);
end EXO_1;
	 
Architecture structure of EXO_1 is
signal S1,S2,S3 : std_logic;

  component HA 
    port(a,b : in std_logic;
    sum,carry : out std_logic);
  end HA;
  
  Component or1 
  port(a,b : in std_logic;
         c : out std_logic);
		 end or1
  end or1;
begin
U1: HA port map(A,B,S1,S2);
U2: HA port map(A,Cin,SUM,S3);
U3: or1 port map(S3,S2,Cout);
end structure;

---or1---
Library ieee;
use ieee.std_logic_1164.all;

entity or1 is
port (a,b : in std_logic;
      c: out std_logic);
end or1;

Architecture comportemental of or1 is
begin
c <= a or b;
end comportemental;

---HA---
Library ieee;
use ieee.std_logic_1164.all;

entity HA is
port (a,b : in std_logic;
     sum,carry : out std_logic);
end HA;

Architecture comportementa2 of HA is
begin
process (a,b)
begin
sum <= a xor b;
carry <= a and b;
end process;
end comportementa2;

-----------------------------------------------------
----------------------Exercice2----------------------
Library ieee;
use ieee.std_logic_1164.all;

entity EXO_2 is
port (A,B : in std_logic_vector(7 downto 0);
     SUM : out std_logic_vector(7 downto 0);
     Cout : out std_logic);
end EXO_2;
	 
Architecture structure of EXO_2 is
signal S: std_logic_vector(6 downto 0);
  component ADD
    port(a,b,cin : in std_logic;
    sum,carry : out std_logic);
  end ADD;
begin
U0: ADD port map(A(0),B(0),'0',SUM(0),S(0));
U1: ADD port map(A(1),B(1),S(0),SUM(1),S(1));
U2: ADD port map(A(2),B(2),S(1),SUM(2),S(2));
U3: ADD port map(A(3),B(3),S(2),SUM(3),S(3));
U4: ADD port map(A(4),B(4),S(3),SUM(4),S(4));
U5: ADD port map(A(5),B(5),S(4),SUM(5),S(5));
U6: ADD port map(A(6),B(6),S(5),SUM(6),S(6));
U7: ADD port map(A(7),B(7),S(6),SUM(7),Cout);
end structure;

---ADD---
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADD is
port (a,b,cin: in std_logic;
     sum,carry : out std_logic;
end ADD;
	 
Architecture comportemental of ADD is
-- signal result : std_logic_vector(1 downto 0);
begin
-- resultat <= ('0'& a) + ('0' & b) + ('0' & cin);
sum <= (a xor b) xor cin; --sum <= resultat(0):
carry <= (a and b) or (a and cin) or (cin and b);-- carry <= resultat(1);
end comportemental;

-------------------------------------------------------Generate
Library ieee;
use ieee.std_logic_1164.all;

entity EXO_2 is
generic(N : integer:=7);
port (A,B : in std_logic_vector(N downto 0);
     SUM : out std_logic_vector(N downto 0);
     Cout : out std_logic);
end EXO_2;
	 
Architecture structure of EXO_2 is
signal S: std_logic_vector(N+1 downto 0);
  component ADDer
    port(a,b,cin : in std_logic;
    sum,carry : out std_logic);
  end ADDer;
begin
S(0) <= '0';
Cout <= S(N+1);
process
ADD: for i in 0 to N generate
    U1: ADDer port map(A(I),B(I),S(I),SUM(I),S(I+1));
end generate ADD;
end process;
end structure;

-----------------------------------------------------
----------------------Exercice3----------------------
Library ieee;
use ieee.std_logic_1164.all;

entity EXO_3 is
port (IN1,RST,CLK : in std_logic_vector(7 downto 0);
      OUT1 : out std_logic);
end EXO_3;
	 
Architecture structure of EXO_3 is
signal t: std_logic_vector(6 downto 0);
  component regD
    port(d,clk,rst : in std_logic;
         q : out std_logic);
  end regD;
begin
U0: regD port map(IN1,CLK,RST,t(0));
U1: regD port map(t(0),CLK,RST,t(1));
U2: regD port map(t(1),CLK,RST,t(2));
U3: regD port map(t(2),CLK,RST,t(3));
U4: regD port map(t(3),CLK,RST,t(4));
U5: regD port map(t(4),CLK,RST,t(5));
U6: regD port map(t(5),CLK,RST,t(6));
U7: regD port map(t(6),CLK,RST,OUT1);
end structure;

---regD---
Library ieee;
use ieee.std_logic_1164.all;
use numeric_std.all;
entity regD is
port (d,RST,CLK : in std_logic;
      q : out std_logic);
end regD;
Architecture structure of regD is
begin 
process(CLK)
begin
if resing_edge(CLK) then
if RST='0' then
q <= '0';
else
q <=d;
end if;
end if
end process;
end structure;

--------------------------------------------generate
Library ieee;
use ieee.std_logic_1164.all;

entity EXO_3 is
port (IN1,RST,CLK : in std_logic;
      OUT1 : out std_logic);
end EXO_3;
	 
Architecture structure of EXO_3 is
signal t: std_logic_vector(7 downto 0);
  component regD
    port(d,clk,rst : in std_logic;
         q : out std_logic);
  end regD;
begin
t(0) <= IN1;
OUT1 <= t(8);
process
Gen1: for i in 0 to 6 generate 
      U1: regD port map(t(i),CLK,RST,t(i+1));
end generate Gen1;
end process;
end structure;

---regD---
Library ieee;
use ieee.std_logic_1164.all;
use numeric_std.all;
entity regD is
port (d,RST,CLK : in std_logic;
      q : out std_logic);
end regD;
	 
Architecture structure of regD is
begin 
process(CLK)
begin
if resing_edge(CLK) then
if RST='0' then
q <= '0';
else
q <=d;
end if;
end if
end process;
end structure;

---------------------exercice 4------------------------
---------------------componants--------------------------
library ieee;
use ieee.std_logic_1164.all;

entity EXO_4 is
port (   Sel : in std_logic_vector(4 downto 0); -- sélecteur de l’opération
        CI : in std_logic; -- retenue d’entrée
        A, B : in std_logic_vector (7 downto 0); -- opérandes
        Y : out std_logic_vector (7 downto 0)); -- résultat
end entity EXO_4;

architecture fct of EXO_4 is
signal LO, AO, NSO : std_logic_vector (7 downto 0);

component dec
port( sel: in std_logic_vector(1 downto 0);
      NSO : in std_logic_vector(7 downto 0);
       y : out std_logic_vector(7 downto 0));
end dec;

component logic
port( sel: in std_logic_vector(1 downto 0);
      a,b : in std_logic_vector(7 downto 0);
      LO : out std_logic_vector(7 downto 0));
end logic;

component arith
port( sel: in std_logic_vector(1 downto 0);
      a,b : in std_logic_vector(7 downto 0);
      CI : std_logic;
      AO : out std_logic_vector(7 downto 0));
end arith;

begin
U1: logic port map(Sel(1 downto 0),A,B,LO);
U2: arith port map(Sel(1 downto 0),A,B,CI,AO);
-- multiplexeur--
NSO <= LO when sel(2) = '1' else AO;
U3: dec port map(Sel(4 downto 3),NSO,Y); 
end fct;

---------------sous programme decalage
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;--ieee.std_logic.arith.all;
use ieee.numeric_std.all;
entity decalage is
port( sel: in std_logic_vector(1 downto 0);
      NSO : in std_logic_vector(7 downto 0);
       y : out std_logic_vector(7 downto 0));
end decalage;

architecture fct of decalage is
begin
-- unité de décalage--
with sel(1 downto 0) select
Y <= NSO when "00",
     NSO sll 1 when "01",
     NSO srl 1 when "10",
    (others => '0') when others;
end fct;

---------------sous programme logique
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;--ieee.std_logic.arith.all;
use ieee.numeric_std.all;
entity logique is
port( sel: in std_logic_vector(1 downto 0);
      a,b : in std_logic_vector(7 downto 0);
      LO : out std_logic_vector(7 downto 0));
end logique;

architecture fct of logique is
begin
-- unité logique--
with sel(1 downto 0) select
LO <= a and b when "00",
      a or b when "10",
      a xor b when "10",
      not a when "11",
      (others=>'0') when others;
end fct;
---------------sous programme arith
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;--ieee.std_logic.arith.all;
use ieee.numeric_std.all;
entity arith is
port( sel: in std_logic_vector(1 downto 0);
      a,b : in std_logic_vector(7 downto 0);
      CI : std_logic;
      AO : out std_logic_vector(7 downto 0));
end arith;

architecture fct of logique is
signal SEL3 : std_logic_vector(2 downto 0)
begin
-- unité arithmétique--
SEL3 <= sel(1 downto 0) & CI;
with SEL3 select
AO <= a when "000",
      a + 1 when "001",
      a + b when "010",
      a + b + 1 when "011",
      a + not b when "100",
      a - b when "101",
      a - 1 when "110",
      b when "111";
	  (others=>'0') when others;
end fct;