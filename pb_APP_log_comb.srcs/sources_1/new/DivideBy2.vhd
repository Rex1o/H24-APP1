----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 02:55:31 PM
-- Design Name: 
-- Module Name: DivideBy2 - Behavioral
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

entity DivideBy2 is
    Port ( Xin : in STD_LOGIC_VECTOR (3 downto 0);
           Yout : out STD_LOGIC_VECTOR (3 downto 0);
           YoutFloat : out STD_LOGIC_VECTOR (3 downto 0)
         );
end DivideBy2;

architecture Behavioral of DivideBy2 is

begin
    Yout(3) <= '0';
    Yout(2) <= Xin(3);
    Yout(1) <= Xin(2);
    Yout(0) <= Xin(1);
    YoutFloat(3) <= Xin(0);
    YoutFloat(2) <= '0';
    YoutFloat(1) <= '0';
    YoutFloat(0) <= '0';
end Behavioral;