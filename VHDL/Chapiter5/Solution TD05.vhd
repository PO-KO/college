                              TD05
-------------------------exercice 1---------------------------
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXO_1 IS
PORT( X : IN INTEGER;
    clk : IN STD_LOGIC;
   out1 : OUT STD_LOGIC);
END EXO_1;

ARCHITECTURE machine1 OF EXO_1 IS
TYPE etat IS (E0,E1,E2,E3,E4);
SIGNAL etap: etat:= E0;
BEGIN
PROCESS (clk,X)
BEGIN
IF (clk'EVENT AND clk = '1') THEN
CASE etap IS

WHEN E0 => out1 <='0';
IF (X=0) THEN
etap <= E1;
ELSE
etap <= E0;
end if;

WHEN E1 => out1 <='0';
IF (X=9) THEN
etap <= E2;
ELSIF (X=0) then 
etap <= E1;
else
etap <= E0;
END IF;

WHEN E2 => out1 <='0';
IF (X=1) THEN
etap <= E3;
ELSIF (X=0) then 
etap <= E1;
else
etap <= E0;
END IF;

WHEN E3 => out1 <='0'; 
IF (X=5) THEN
etap <= E4;
ELSIF (X=0) then 
etap <= E1;
else
etap <= E0;
END IF;

WHEN E4 => out1='1';
ELSIF (X=0) then 
etap <= E1;
else
etap <= E0;
WHEN others => etap <= E0;
END IF;
END CASE;
END IF;
END PROCESS;
END machine1;

-------------------------exercice 2---------------------------
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXO_2 IS
PORT(clk, in1 : IN STD_LOGIC;
   out1, out2 : OUT STD_LOGIC);
END EXO_2;

ARCHITECTURE machine2 OF EXO_2 IS
TYPE impulsion IS (start, continue);
SIGNAL etap: impulsion;
BEGIN
PROCESS (clk)
BEGIN
IF (clk'EVENT AND clk = '1') THEN
CASE etap IS

WHEN start =>
IF (in1 = '1') THEN
etap <= start;
out1 <= '0';
out2 <= '0';
ELSE
etap <= continue;
out1 <= '1';
out2 <= '0';
END IF;

WHEN continue =>
etap <= start;
out1 <= '0';
out2 <= '1';

WHEN others => etap <= start;
END CASE;
END IF;
END PROCESS;
END machine2;

-------------------------exercice 3---------------------------
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXO_3 IS
PORT(
clk, pb_in : IN STD_LOGIC;
pb_out : BUFFER STD_LOGIC);-- la machine ne présente pas de sortie
END EXO_3;

ARCHITECTURE machine3 of EXO_3 IS
TYPE etat IS (s0, s1, s2, s3);
SIGNAL state: etat;
BEGIN
PROCESS (clk, pb_in)
BEGIN
IF (clk'EVENT and clk='1') THEN
CASE state IS

WHEN s0=> 
IF (pb_in = pb_out) THEN
state <= s1;pb_out <= pb_out;
ELSE
state <= s0;pb_out <= pb_out;
END IF;

WHEN s1=> 
IF (pb_in = pb_out) THEN
state <= s2;pb_out <= pb_out;
ELSE
state <= s0;pb_out <= pb_out;
END IF;

WHEN S2=> 
IF (pb_in = pb_out) THEN
state <= s3;pb_out <= pb_out;
ELSE
state <= s0;pb_out <= pb_out;
END IF;

WHEN s3=> 
IF (pb_in = pb_out) THEN
state <= s0;
pb_out <= not (pb_out);
ELSE 
pb_out <= pb_out;
state <= s0;
END IF;

WHEN others => state <= s0;

END CASE;
END IF;
END PROCESS;
END machine3;

-------------------------exercice 4---------------------------
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EXO_4 IS
PORT(
clk, in1,in2 : IN STD_LOGIC;
out1 : out STD_LOGIC);
END EXO_4;

ARCHITECTURE machine4 of EXO_4 IS
TYPE etat IS (s0, s1, s2, s3,s4);
SIGNAL state: etat;
BEGIN
etat: PROCESS (clk)
BEGIN
IF (clk'EVENT and clk='1') THEN
CASE state IS

WHEN s0=>
state <=s1;
out1<='0';--------------------------la sortie peut être insérée dans un autre process
WHEN s1=> IF (in1='1') THEN
state <= s1;
out1<='0';
ELSE
state <= s2;
out1<='1';
END IF;

WHEN S2=>
state <=s3;
out1<='0';
WHEN s3=>
state <= s4;
out1<='0';

WHEN s4=> (IF in2='0') THEN
state<=s0;
out1<='1';
else
state <=s4;
out1<='0';
end if;

WHEN others =>
state <= s0;
out1<='0';

END CASE;
END IF;
END PROCESS;
END machine4;

-------------------------exercice 5---------------------------
--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY EXO_5 IS
PORT (clk : IN STD_LOGIC;
un_dollar : IN STD_LOGIC;
deux_dollars : IN STD_LOGIC;
film : OUT STD_LOGIC;
monnaie : OUT STD_LOGIC
);
END EXO_5;

ARCHITECTURE machine5 OF EXO_5 IS
  TYPE etats IS (zero, un , deux, trois, quatre, cinq, six);
SIGNAL etat_present : etats;
SIGNAL etat_prochain : etats;
BEGIN
PROCESS (etat_present, un_dollar, deux_dollars)
BEGIN
CASE etat_present IS

WHEN zero =>
film <= '0';
monnaie <= '0';
IF (un_dollar = '1') THEN
etat_prochain <= un;
ELSIF (deux_dollars = '1') THEN
etat_prochain <= deux;
ELSE
etat_prochain <= zero;
END IF;

WHEN un =>
film <= '0';
monnaie <= '0';
IF (un_dollar = '1') THEN
etat_prochain <= deux;
ELSIF deux_dollars = '1' THEN
etat_prochain <= trois;
ELSE
etat_prochain <= un;
END IF;

WHEN deux =>
film <= '0';
monnaie <= '0';
IF (un_dollar = '1') THEN
etat_prochain <= trois;
ELSIF deux_dollars = '1' THEN
etat_prochain <= quatre;
ELSE
etat_prochain <= deux;
END IF;

WHEN trois =>
film <= '0';
monnaie <= '0';
IF (un_dollar = '1') THEN
etat_prochain <= quatre;
ELSIF deux_dollars = '1' THEN
etat_prochain <= cinq;
ELSE
etat_prochain <= trois;
END IF;

WHEN quatre =>
film <= '0';
monnaie <= '0';
IF (un_dollar = '1') THEN
etat_prochain <= cinq;
ELSIF deux_dollars = '1' THEN
etat_prochain <= six;
ELSE
etat_prochain <= quatre;
END if;

WHEN cinq =>
film <= '1';
monnaie <= '0';
etat_prochain <= zero;

WHEN six =>
film <= '1';
monnaie <= '1';
etat_prochain <= zero;
END CASE;

END PROCESS;

PROCESS (clk)
BEGIN
IF (clk'EVENT AND clk = '1') THEN
etat_present <= etat_prochain;
END IF;
END PROCESS;
END machine5;
-----------------------------exercice 6-------------------------
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity temp_cntrl is
port(MCLK, EN_1SEC : in std_logic ;
TEMP, CONS : in std_logic_vector(6 downto 0) ;
CHAUF : out std_logic ) ;
end temp_cntrl ;
architecture FPGA of temp_cntrl is
type T_etat is (mesure, chauffage, attente);
signal etat : T_etat;
signal duree, cmpt : std_logic_vector(14 downto 0) ;
begin
process(MCLK)
variable diff : std_logic_vector(6 downto 0) ;
begin
if MCLK'event and MCLK = '1' then
if EN_1SEC = '1' then
case etat is
when mesure =>
diff := CONS - TEMP ;
if diff(6) ='0' then
duree <= diff * x"F0" ; -- = 240 = 60*4
CHAUF <= '1' ;
etat <= chauffage ;
end if ;
when chauffage =>
cmpt <= cmpt + 1 ;
if cmpt = duree then
cmpt <= (others => '0') ;
etat <= attente ;
CHAUF <= '0' ;
end if ;
when attente =>
cmpt <= cmpt + 1 ;
if cmpt = "000001110000011" then -- = 60*15 -1
cmpt <= (others => '0') ;
etat <= mesure ;
end if ;
end case;
end if ;
end if ;
end process ;
end FPGA ;