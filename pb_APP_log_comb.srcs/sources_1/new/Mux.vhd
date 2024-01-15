----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 03:45:53 PM
-- Design Name: 
-- Module Name: Mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux is
    Port (
        ADCbin     : in STD_LOGIC_VECTOR(3 downto 0);
        Dizaines   : in STD_LOGIC_VECTOR(3 downto 0);
        Unite_ns   : in STD_LOGIC_VECTOR(3 downto 0 );
        Code_signe : in STD_LOGIC_VECTOR(3 downto 0);
        Unite_s    : in STD_LOGIC_VECTOR(3 downto 0);
        erreur     : in  STD_LOGIC;
        BTN        : in STD_LOGIC_VECTOR(1 downto 0);
        S2         : in STD_LOGIC;
        AFF0       : out STD_LOGIC_VECTOR(3 downto 0);
        AFF1       : out STD_LOGIC_VECTOR(3 downto 0)
     );
end Mux;

architecture Behavioral of Mux is
begin
    process (ADCbin, Dizaines, Unite_ns, Code_signe, Unite_s, erreur, BTN, S2)
    begin
        if (S2 = '1' or erreur = '1' or BTN = "11") then -- Erreur
            AFF0 <= "1110"; -- E
            AFF1 <= "1101"; --r
        elsif BTN = "00" then -- BCD_NS
            AFF0 <= Dizaines;
            AFF1 <= Unite_ns;
        elsif BTN = "01" then -- Hexa
            AFF0 <= "0000"; --Afficher rien, ou afficher 0?
            AFF1 <= ADCbin; 
        elsif BTN = "10" then -- BCD_S
            AFF0 <= Code_signe;
            AFF1 <= Unite_s;
        else
            AFF0 <= "1110"; -- E
            AFF1 <= "1101"; -- r
        end if;
    end process;
end Behavioral;
