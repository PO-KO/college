                                     TD04
---------------------------------------------------------------
-----------------------------exercice1-------------------------
library ieee;
use ieee.std_logic_1164.all;

ENTITY EXO_1 IS
PORT( ck,pr,clr,j,k : IN std_logic;
                  s : OUT std_logic);
END EXO_1;

ARCHITECTURE JK OF EXO_1 IS
SIGNAL q : std_logic;
BEGIN
process(pr,clr,ck)
begin
if clr='0' then q<='0';
 elsif pr='0' then q<='1';
 elsif rising_edge(ck) then--rising_edge tester le front montant
if j='1' and k='0' then q<='1';
  elsif j='0' and k='1' then q<='0';
  elsif j='1' and k='1' then q<=not(q);
  elsif j='0' and k='0' then q<=q;
end if;
end if;
end process;
s<=q;
end JK;

---------------------------------------------------------------
-----------------------------exercice2-------------------------
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned;

ENTITY EXO_2 IS
PORT(clk : IN std_logic;
   clear : IN std_logic;
       q : OUT INTEGER RANGE 0 TO 255);
END EXO_2;

ARCHITECTURE compteur_8bits OF EXO_2 IS
BEGIN
PROCESS (clk, clear)
VARIABLE count : INTEGER RANGE 0 TO 255;--la varaible ne peut être déclarée que dans un processus
BEGIN
If (clear = '0') THEN -- clear actif à l'état bas
 count := 0;
 ELSIF (clk'EVENT AND clk = '1') THEN -- ou bien if rising_edge(ck) then
 count := count + 1;
END IF;
q <= count;
END PROCESS;
END compteur_8bits;

---------------------------------------------------------------
-----------------------------exercice3-------------------------
library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned;

ENTITY EXO_3 IS
PORT (clk, count_ena : IN std_logic;
clear, load, direction : IN std_logic;
                     p : IN INTEGER RANGE 0 TO 15;
                     q : OUT INTEGER RANGE 0 TO 15);
END EXO_3;

ARCHITECTURE compteur OF EXO_3 IS
BEGIN
PROCESS (clk, clear, load)
VARIABLE cnt : INTEGER RANGE 0 TO 15;--la varaible ne peut être déclarée que dans un processus
BEGIN
IF (clear = '0') THEN cnt := 0;-- clear actif à l'état bas
 ELSIF (load = '1') THEN
 cnt := p;
 elsif (clk'EVENT AND clk = '1') THEN -- ou bien if rising_edge(ck) then
IF (count_ena = '1' and direction = '0') THEN
 cnt := cnt - 1;
 ELSIF (count_ena = '1' and direction = '1') THEN
 cnt := cnt + 1;
END IF;
END IF;
q <= cnt;
END PROCESS;
END compteur;
---------------------------------------------------------------
-----------------------------exercice4-------------------------
library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned;

entity EXO_4 is
PORT (RESET, CLK : in std_logic;
               Q : out std_logic_vector (7 downto 0));
end EXO_4;

architecture DESCRIPTION of EXO_4 is
signal DIGIT_MSB, DIGIT_LSB: std_logic_vector (3 downto 0);
begin
process (RESET,CLK)
begin
if RESET ='1' then
 DIGIT_LSB <= (others=>'0');
 DIGIT_MSB <= (others=>'0');
 elsif (CLK ='1' and CLK'event) then
 if DIGIT_LSB < 9 then
 DIGIT_LSB <= DIGIT_LSB + 1;
 else
  DIGIT_LSB <= (others=>'0');
  if DIGIT_MSB < 9 then
  DIGIT_MSB <= DIGIT_MSB + 1 ;
   else
   DIGIT_MSB <= (others=>'0');
  end if;
 end if;
end if;
end process;
Q <= DIGIT_MSB & DIGIT_LSB;
end DESCRIPTION;

---------------------------------------------------------------
-----------------------------exercice5-------------------------
library ieee;
use ieee.std_logic_1164.all;

entity EXO_5 is 
port (H, IR,IL,S0,S1 : in std_logic;
                   I : in std_logic_vector (3 downto 0);
                   Q : buffer std_logic_vector (3 downto 0));
end EXO_5;

architecture arch of EXO_5 is
Begin
process (S0, S1, H)
variable Z : integer;
variable N: Integer:=0;
begin
if (H'event and H ='1') then
 if (S0='0' and S1= '0') then Q<=Q;
 elsif (S0='0' and S1= '1') then Q<=I;
 elsif (S0 ='1' and S1='0') then
 Boucle1: For Z IN 3 downto 1 Loop
 N:=Z-1;
 Q(Z)<=Q(N);
          End  loop Boucle1;
 Q(N)<=IR;
 elsif (S0 ='1' and S1='1') then
 Boucle2 : For Z IN 0 to 2 Loop
 N:=Z+1;
 Q(Z)<=Q(N);
           End  loop Boucle2;
 Q(N)<=IL;
 end if;
end if;                                                             
end process;
end arch; 

---------------------------------------------------------------
-----------------------------exercice6-------------------------
library ieee;
use ieee.std_logic_1164.all;

entity EXO_6 is
port (Reset,clk,load,dataIN : in std_logic;
                    pattern : in std_logic_vector (7 downto 0);
                      found : out std_logic);
end EXO_6;

architecture identification of EXO_6 is
signal D, data:std_logic_vector (7 downto 0);
begin
   process(clk)
   begin
   if (clk'event and clk='1') then
   if (Reset='1') then data <= (others=>'0');
    else
    data <=data(6 downto 0)&dataIN;
   end if;
   end if;
   end process;

   process(clk)
   begin
   if (clk'event and clk='1') then
   if (load='1') then
    D <= pattern;
   end if;
   end if;
   end process;

   process(D,data)
   begin
   found <='0';
   if (D=data) then found <='1';
   else found <='0';
   end if;
   end process;
end identification;
   