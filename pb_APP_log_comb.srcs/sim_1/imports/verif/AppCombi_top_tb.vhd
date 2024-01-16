---------------------------------------------------------------------------------------------
-- labo_adder4b_sol_tb.vhd
---------------------------------------------------------------------------------------------
-- Universit� de Sherbrooke - D�partement de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date R�vision   : 21 Avril 2020
-- Auteur(s)       : R�jean Fontaine, Daniel Dalle, Marc-Andr� T�trault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: carte Thermo12, Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Banc d'essai pour circuit combinatoire Laboratoire logique combinatoire
-- Version avec entr�es toutes combinatoires CIRCUIT COMPLET (TOP)
-- 
-- Revision v1 12 novembre 2018, 3 d�cembre 2018 D. Dalle 
-- Revision 30 Avril 2021, M-A Tetrault
--
---------------------------------------------------------------------------------------------
-- Notes :
-- L'entr�e retenue (i_cin) est g�n�r�e par l'interrupteur S1 de la carte Thermobin
--
---------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.env.finish;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- requis pour enonc�s de type mem_valeurs_tests(to_integer( unsigned(table_valeurs_adr(9 downto 6) )));
USE ieee.numeric_std.ALL;          -- 
use IEEE.STD_LOGIC_UNSIGNED.ALL;   --


entity AppCombi_top_tb is
--  Port ( );
end AppCombi_top_tb;

architecture Behavioral of AppCombi_top_tb is
type truth_table is array (0 to 12) of STD_LOGIC_VECTOR(11 downto 0);
type error_table is array (0 to 10) of STD_LOGIC_VECTOR(11 downto 0);
COMPONENT verif_show_affhex is
end COMPONENT;

COMPONENT AppCombi_top
   port ( 
          i_btn       : in    std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
          i_sw        : in    std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
          sysclk      : in    std_logic;                     -- horloge systeme
          i_ADC_th    : in    std_logic_vector (11 downto 0); -- Thermo
          o_SSD       : out   std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
          o_led       : out   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
          o_led6_r    : out   std_logic;                     -- vers DEL rouge de la carte Zybo
          o_pmodled   : out   std_logic_vector (7 downto 0);  -- vers connecteur pmod 8 DELs
          o_DEL2      : out   std_logic;
          o_DEL3      : out   std_logic;
          i_S1        : in   std_logic;
          i_S2        : in   std_logic
     );    
end COMPONENT;
   signal btn_sim       :  STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
   signal sw_sim        :  STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
   signal clk_sim       :  STD_LOGIC := '0';
   signal ADC_th_sim    :  STD_LOGIC_VECTOR (11 DOWNTO 0) := "000000000000";
   signal SSD_sim       :  STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
   signal led_sim       :  STD_LOGIC_VECTOR (3 DOWNTO 0);
   signal led6_r_sim    :  STD_LOGIC := '0';
   signal pmodled_sim   :  STD_LOGIC_VECTOR (7 DOWNTO 0);
   signal DEL2_sim      :  STD_LOGIC := '0';
   signal DEL3_sim      :  STD_LOGIC := '0';
   signal S1_sim        :  STD_LOGIC := '0';
   signal S2_sim        :  STD_LOGIC := '0';

   constant sysclk_Period  : time := 8 ns;
begin


-- Pattes du FPGA Zybo-Z7
uut: AppCombi_top
   PORT MAP(
        i_btn       => btn_sim,
        i_sw        => sw_sim,
        sysclk      => clk_sim,
        i_ADC_th    => ADC_th_sim,
        o_SSD       => SSD_sim,
        o_led       => led_sim,
        o_led6_r    => led6_r_sim,
        o_pmodled   => pmodled_sim,
        o_DEL2      => DEL2_sim,
        o_DEL3      => DEL3_sim,
        i_S1        => S1_sim,
        i_S2        => S2_sim
   );
   
	-- Section banc de test
    ----------------------------------------
	-- generation horloge 
	----------------------------------------
   process
   begin
       clk_sim <= '1';  -- init
       loop
           wait for sysclk_Period/2;
           clk_sim <= not clk_sim;    -- invert clock value
       end loop;
   end process;  
	----------------------------------------
   
   ----------------------------------------
   -- test bench
   tb : PROCESS
         variable code_valides : truth_table :=
     (  0  => "000000000000",
        1  => "000000000001",
        2  => "000000000011",
        3  => "000000000111",
        4  => "000000001111",
        5  => "000000011111",
        6  => "000000111111",
        7  => "000001111111",
        8  => "000011111111",
        9  => "000111111111",
        10 => "001111111111",
        11 => "011111111111",
        12 => "111111111111"
      );
         variable codes_invalides : error_table :=
     (  0  => "000000000010",
        1  => "000000000100",
        2  => "000000001000",
        3  => "000000010000",
        4  => "000000100000",
        5  => "000001000000",
        6  => "000010000000",
        7  => "000100000000",
        8  => "001000000000",
        9  => "010000000000",
        10 => "100000000000"
      );
      BEGIN
      --Attendre que la clock spread
      wait for 300ns;
        -- Affichage en bcd
        for index in 0 to code_valides'length-1 loop
            ADC_th_sim <= code_valides(index);
            wait for 5ns;
        end loop;
         
      -- Affichage en Hexa et parité pair
        btn_sim(0) <= '1';
        S1_sim <= '1';
        for index in 0 to code_valides'length-1 loop
            ADC_th_sim <= code_valides(index);
            wait for 5ns;
        end loop;
      -- Affichage en BCD signe -5
        btn_sim(0) <= '0';
        btn_sim(1) <= '1';
        for index in 0 to code_valides'length-1 loop
            ADC_th_sim <= code_valides(index);
            wait for 5ns;
        end loop;
       -- Affichage de Er avec bouton 0 et 1
        btn_sim(0) <= '1';
        btn_sim(1) <= '1';
        wait for 5ns;
        -- reset de l'etat des boutons
        btn_sim(0) <= '0';
        btn_sim(1) <= '0';

        --Reset de la switch S1
        S1_sim <= '0';
        --Afficher Er avec boutton S2
        S2_sim <= '1';
        
        wait for 5ns;
        -- Afficher err sur le 7segments dans le cas de rentre au thermo invalides
        S2_sim <= '0';
        for index in 0 to codes_invalides'length-1 loop
            ADC_th_sim <= codes_invalides(index);
            wait for 5ns;
        end loop;
      finish;
  END PROCESS;

END Behavioral;
