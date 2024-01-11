----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 06:12:39 PM
-- Design Name: 
-- Module Name: Add1bitB - Behavioral
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

entity Add1bitB is
    Port (
        X    : in  STD_LOGIC;
        Y    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC; 
        Sum    : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end Add1bitB;

architecture Behavioral of Add1bitB is
begin
    process (X, Y, Cin)
    begin
        Sum <= X xor Y xor Cin;
        Cout <= (X and Y) or (Y and Cin) or (Cin and X);
    end process;
end Behavioral;
