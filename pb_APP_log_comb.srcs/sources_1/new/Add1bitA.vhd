----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 06:12:39 PM
-- Design Name: 
-- Module Name: Add1bitA - Behavioral
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

entity Add1bitA is
    Port (
        X    : in  STD_LOGIC;
        Y    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC; 
        Sum    : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end Add1bitA;

architecture Behavioral of Add1bitA is
begin
    process (X, Y, Cin)
    variable v_concatenate : std_logic_vector(2 downto 0);
    
    begin
    v_concatenate := X & Y & Cin;
        case (v_concatenate) is
            when "111" =>
                Sum  <= '1';
                Cout <= '1';
            when "000" =>
                Sum  <= '0';
                Cout <= '0';
            when "001" | "010" | "100" =>
                Sum  <= '1';
                Cout <= '0';
            when others =>
                Sum  <= '0';
                Cout <= '1';
        end case;
    end process;
    
end Behavioral;
