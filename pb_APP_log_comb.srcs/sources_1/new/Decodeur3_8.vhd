----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 02:55:31 PM
-- Design Name: 
-- Module Name: Decodeur3_8 - Behavioral
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

entity Decodeur3_8 is
    Port ( choice : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0) 
          );
end Decodeur3_8;

architecture Behavioral of Decodeur3_8 is

begin
    output <= "00000001" when choice = "000" else
              "00000010" when choice = "001" else
              "00000100" when choice = "010" else
              "00001000" when choice = "011" else
              "00010000" when choice = "100" else
              "00100000" when choice = "101" else
              "01000000" when choice = "110" else
              "10000000" when choice = "111";
end Behavioral;
