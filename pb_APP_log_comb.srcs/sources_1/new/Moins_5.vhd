----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 08:26:09 PM
-- Design Name: 
-- Module Name: Moins_5 - Behavioral
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

entity Moins_5 is
    Port(
        X          : in STD_LOGIC_VECTOR(3 downto 0);
        Difference : out STD_LOGIC_VECTOR(3 downto 0);
        Cout       : out STD_LOGIC
    );
end Moins_5;

architecture Behavioral of Moins_5 is
    component Add4bit
    Port (
        X    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Y    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin  : in  STD_LOGIC; 
        Sum    : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : out STD_LOGIC
    );
    end component;
begin
    -- La valeur 1011 est le complement 2 du chiffre 5
    add0 : Add4bit port map (X => X, Y=> "1011", Cin => '0', Sum => Difference, Cout => Cout);
end Behavioral;
