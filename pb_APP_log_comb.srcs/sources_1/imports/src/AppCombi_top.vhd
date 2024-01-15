---------------------------------------------------------------------------------------------
-- Universit� de Sherbrooke - D�partement de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date            : 21 Avril 2020
-- Auteur(s)       : R�jean Fontaine, Daniel Dalle, Marc-Andr� T�trault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Circuit utilitaire pour le laboratoire et la probl�matique de logique combinatoire
--
---------------------------------------------------------------------------------------------
-- � faire :
-- Voir le guide de l'APP
--    Ins�rer les modules additionneurs ("components" et "instances")
--
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity AppCombi_top is
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
end AppCombi_top;
 
architecture BEHAVIORAL of AppCombi_top is

   constant nbreboutons     : integer := 4;    -- Carte Zybo Z7
   constant freq_sys_MHz    : integer := 125;  -- 125 MHz 
   
   signal d_s_1Hz           : std_logic;
   signal clk_5MHz          : std_logic;
   --
   --
   signal d_AFF0            : std_logic_vector (3 downto 0):= "0000";
   signal d_AFF1            : std_logic_vector (3 downto 0):= "0000";
   
   -- output of Thermo2Bin
   signal thermo2bin_err    : std_logic;
   signal ADCbin            : std_logic_vector (3 downto 0);
   
   --Output of Bin2DualBCD
   signal Dizaines          : std_logic_vector (3 downto 0);
   signal Unites_ns          : std_logic_vector (3 downto 0);
   signal Code_signe        : std_logic_vector (3 downto 0);
   signal Unites_s           : std_logic_vector (3 downto 0);
   
   --Output of mux
   
 component synchro_module_v2 is
   generic (const_CLK_syst_MHz: integer := freq_sys_MHz);
      Port ( 
           clkm        : in  STD_LOGIC;  -- Entr�e  horloge maitre
           o_CLK_5MHz  : out STD_LOGIC;  -- horloge divise utilise pour le circuit             
           o_S_1Hz     : out  STD_LOGIC  -- Signal temoin 1 Hz
            );
      end component;  

   component septSegments_Top is
    Port (   clk          : in   STD_LOGIC;                      -- horloge systeme, typique 100 MHz (preciser par le constante)
             i_AFF0       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0
             i_AFF1       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0     
             o_AFFSSD_Sim : out string(1 to 2);
             o_AFFSSD     : out  STD_LOGIC_VECTOR (7 downto 0)  
           );
   end component;
   
   component Thermo2Bin is
    Port (
        ADCth  : in  STD_LOGIC_VECTOR(11 downto 0);
        err    : out STD_LOGIC;
        ADCbin : out STD_LOGIC_VECTOR(3 downto 0)
        );
   end component;
   
   component Bin2DualBCD is
    Port(
        ADCbin : in STD_LOGIC_VECTOR(3 downto 0);
        Dizaines : out STD_LOGIC_VECTOR(3 downto 0);
        Unites_ns : out STD_LOGIC_VECTOR(3 downto 0);
        Code_signe : out STD_LOGIC_VECTOR(3 downto 0);
        Unites_s : out STD_LOGIC_VECTOR(3 downto 0)
    );
   end component;
   
   component Mux is
    Port (
        ADCbin     : in STD_LOGIC_VECTOR(3 downto 0);
        Dizaines   : in STD_LOGIC_VECTOR(3 downto 0);
        Unites_ns   : in STD_LOGIC_VECTOR(3 downto 0 );
        Code_signe : in STD_LOGIC_VECTOR(3 downto 0);
        Unites_s    : in STD_LOGIC_VECTOR(3 downto 0);
        erreur     : in  STD_LOGIC;
        BTN        : in STD_LOGIC_VECTOR(1 downto 0);
        S2         : in STD_LOGIC;
        AFF0       : out STD_LOGIC_VECTOR(3 downto 0);
        AFF1       : out STD_LOGIC_VECTOR(3 downto 0)
     );
   end component;
   
   component Parite is
    Port (
        ADCbin : in  STD_LOGIC_VECTOR(3 downto 0);
        pair : in STD_LOGIC;
        par : out STD_LOGIC
    );
   end component;
begin
  
    inst_synch : synchro_module_v2
     generic map (const_CLK_syst_MHz => freq_sys_MHz)
         port map (
            clkm         => sysclk,
            o_CLK_5MHz   => clk_5MHz,
            o_S_1Hz      => d_S_1Hz
        );  

   inst_aff :  septSegments_Top 
       port map (
           clk    => clk_5MHz,
           -- donnee a afficher definies sur 8 bits : chiffre hexa position 1 et 0
           i_AFF1  => d_AFF1, 
           i_AFF0  => d_AFF0,
           o_AFFSSD_Sim   => open,   -- ne pas modifier le "open". Ligne pour simulations seulement.
           o_AFFSSD       => o_SSD   -- sorties directement adaptees au connecteur PmodSSD
       );
       
   inst_thermo2bin : Thermo2Bin
        port map (
          ADCth => i_ADC_th,
          err => thermo2bin_err,
          ADCbin => ADCbin
        );
        
  inst_bin2dualbcd : Bin2DualBCD
    port map (
        ADCbin => ADCbin, 
        Dizaines => Dizaines,  
        Unites_ns => Unites_ns, 
        Code_signe => Code_signe,
        Unites_s => Unites_s
    );
    
  inst_parite : Parite
    port map (
        ADCbin => ADCbin,
        pair => i_S1,
        par => o_DEL2
    );
  
  inst_mux : Mux
    port map (
        ADCbin => ADCbin,
        Dizaines => Dizaines,
        Unites_ns => Unites_ns,
        Code_signe => Code_signe,
        Unites_s => Unites_s,
        erreur => thermo2bin_err,
        BTN => i_btn(1 downto 0),
        S2  => i_S2,
        AFF0 => d_AFF0,
        AFF1 => d_AFF1
    );
end BEHAVIORAL;


