----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 06:24:11 PM
-- Design Name: 
-- Module Name: Parite - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: La parite est toujours impair par defaut
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Parite is
    Port (
        ADCbin : in  STD_LOGIC_VECTOR(3 downto 0);
        pair : in STD_LOGIC;
        par : out STD_LOGIC
    );
end Parite;

architecture Behavioral of Parite is
begin
    process (ADCbin) is
    begin
    case ADCbin is
        when "0000" |
         "0011" |
         "0101" |
         "0110" |
         "1001" |
         "1010" |
         "1100" |
         "1111" =>
            par <= '1' xor pair;
        when others =>
            par <= '0' xor pair;
    end case;
    end process;
end Behavioral;
