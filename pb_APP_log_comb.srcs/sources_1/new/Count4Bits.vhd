----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 03:15:00 PM
-- Design Name: 
-- Module Name: Count4Bits - Behavioral
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

entity Count4Bits is
    Port (
     values     : in STD_LOGIC_VECTOR(3 downto 0);
     total_bit  : out STD_LOGIC_VECTOR(2 downto 0);
     error      : out STD_LOGIC
     );
end Count4Bits;
architecture Behavioral of Count4Bits is
begin
    process (values)
    begin
        total_bit(2) <= values(3) and values(2) and values(1) and values(0);
        total_bit(1) <= not values(3) and values(1) and values(0);
        total_bit(0) <= (not values(3) and values(2) and values(1) and values(0)) or
                (not values(3) and not values(2) and not values(1) and values(0));
        error        <= (values(1) and not values(0)) or 
                        (values(3) and not values(2)) or
                        (values(2) and not values(1)) or
                        (values(3) and not values(1));
    end process;
end Behavioral;
