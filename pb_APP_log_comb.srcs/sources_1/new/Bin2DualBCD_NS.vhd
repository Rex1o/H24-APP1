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

entity Bin2DualBCD_NS is
    Port (
        ADCbin : in STD_LOGIC_VECTOR(3 downto 0); -- Unsigned representation 
        Dizaines : out STD_LOGIC_VECTOR(3 downto 0);
        Unites_ns : out STD_LOGIC_VECTOR(3 downto 0)
     );
end Bin2DualBCD_NS;

architecture Behavioral of Bin2DualBCD_NS is
begin
    process (ADCbin)
    begin
        case ADCbin is
            when  "0000" | "0001" | -- De 0 a 9
                  "0010" | "0011" |
                  "0100" | "0101" |
                  "0110" | "0111" |
                  "1000" | "1001" =>
                Dizaines  <= "0000";
                Unites_ns <= ADCbin;
            when "1010" => --10
                Dizaines  <= "0001";
                Unites_ns <= "0000";
            when "1011" => --11
                Dizaines  <= "0001";
                Unites_ns <= "0001";
            when "1100" => --12
                Dizaines  <= "0001";
                Unites_ns <= "0010";
            when "1101" => --13
                Dizaines  <= "0001";
                Unites_ns <= "0011";
            when "1110" => --14
                Dizaines  <= "0001";
                Unites_ns <= "0100";
            when "1111" => --15
                Dizaines  <= "0001";
                Unites_ns <= "0101";
           when others => -- Mettre les valeurs ER du 7 segment a la place?
                Dizaines  <= "0000";
                Unites_ns <= "0000";
        end case;
    end process;
end Behavioral;
