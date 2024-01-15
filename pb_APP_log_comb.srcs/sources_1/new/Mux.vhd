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
        Unites_ns   : in STD_LOGIC_VECTOR(3 downto 0 );
        Code_signe : in STD_LOGIC_VECTOR(3 downto 0);
        Unites_s    : in STD_LOGIC_VECTOR(3 downto 0);
        erreur     : in  STD_LOGIC;
        BTN        : in STD_LOGIC_VECTOR(1 downto 0);
        S2         : in STD_LOGIC;
        AFF0       : out STD_LOGIC_VECTOR(3 downto 0);
        AFF1       : out STD_LOGIC_VECTOR(3 downto 0)
     );
end Mux;

architecture Behavioral of Mux is
begin
    process (ADCbin, Dizaines, Unites_ns, Code_signe, Unites_s, erreur, BTN, S2)
    begin
        if (S2 = '1' or erreur = '1' or BTN = "11") then -- Erreur
            AFF0 <= "1101"; -- E
            AFF1 <= "1110"; --r
        elsif BTN = "00" then -- BCD_NS
            AFF0 <= Unites_ns; 
            AFF1 <= Dizaines;
        elsif BTN = "01" then -- Hexa
            AFF0 <= ADCbin; --Afficher rien, ou afficher 0?
            AFF1 <= "0000";  
        elsif BTN = "10" then -- BCD_S
            AFF0 <= Unites_s;
            AFF1 <= Code_signe; 
        else
            AFF0 <= "1101"; -- E
            AFF1 <= "1110";  -- r
        end if;
    end process;
end Behavioral;
