----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 08:26:09 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_NS - Behavioral
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

entity Bin2DualBCD_S is
    Port (
        ADCbin : in STD_LOGIC_VECTOR(3 downto 0); -- Representation complement 2
        Code_signe : out STD_LOGIC_VECTOR(3 downto 0);
        Unites_s : out STD_LOGIC_VECTOR(3 downto 0)
     );
end Bin2DualBCD_S;

architecture Behavioral of Bin2DualBCD_S is
begin
    process (ADCbin)
    begin
        case ADCbin is
            when "1000" => -- -8
                Code_signe <= "1111";
                Unites_s <= "1000";
            when "1001" => -- -7
                Code_signe <= "1111";
                Unites_s <= "0111";
            when "1010" => -- -6
                Code_signe <= "1111";
                Unites_s <= "0110";
            when "1011" => -- -5
                Code_signe <= "1111";
                Unites_s <= "0101";
            when "1100" => -- -4
                Code_signe <= "1111";
                Unites_s <= "0100";
            when "1101" => -- -3
                Code_signe <= "1111";
                Unites_s <= "0011";
            when "1110" => -- -2 
                Code_signe <= "1111";
                Unites_s <= "0010";
            when "1111" => -- -1
                Code_signe <= "1111";
                Unites_s <= "0001";
            when "0000" => -- 0
                Code_signe <= "0000";
                Unites_s <= "0000";
            when "0001" => -- 1
                Code_signe <= "0000";
                Unites_s <= "0001";
            when "0010" => -- 2
                Code_signe <= "0000";
                Unites_s <= "0010";
            when "0011" => -- 3
                Code_signe <= "0000";
                Unites_s <= "0011";
            when "0100" => -- 4
                Code_signe <= "0000";
                Unites_s <= "0100";
            when "0101" => -- 5
                Code_signe <= "0000";
                Unites_s <= "0101";
            when "0110" => -- 6
                Code_signe <= "0000";
                Unites_s <= "0110";
            when "0111" => -- 7
                Code_signe <= "0000";
                Unites_s <= "0111";
            when others =>
                Code_signe <= "1101";
                Unites_s <= "1110";
            end case;
    end process;
end Behavioral;
