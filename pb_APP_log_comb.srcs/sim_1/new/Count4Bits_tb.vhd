----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 03:33:22 PM
-- Design Name: 
-- Module Name: Count4Bits_tb - Behavioral
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
use ieee.std_logic_arith.all;
use std.env.finish;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Count4Bits_tb is
end Count4Bits_tb;

architecture Behavioral of Count4Bits_tb is
    type truth_table is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    component Count4Bits
        Port (
            values     : in STD_LOGIC_VECTOR(3 downto 0);
            total_bit  : out STD_LOGIC_VECTOR(2 downto 0);
            error      : out STD_LOGIC
            );
     end component;
     signal wanted_values : truth_table :=
     (  0  => "0000",
        1  => "0010",
        2  => "0001",
        3  => "0100",
        4  => "0001",
        5  => "0001",
        6  => "0001",
        7  => "0110",
        8  => "0001",
        9  => "0001",
        10 => "0001",
        11 => "0001",
        12 => "0001",
        13 => "0001",
        14 => "0001",
        15 => "1000"
      );
     signal values     : STD_LOGIC_VECTOR(3 downto 0);
     signal total_bit  : STD_LOGIC_VECTOR(2 downto 0);
     signal error_bit      : STD_LOGIC;
begin
    DUT : Count4Bits port map(values => values, total_bit => total_bit, error => error_bit);
    process
    begin
        for index in 0 to 15 loop
            values <= conv_std_logic_vector(index, 4);
            wait for 1us;
            
            assert wanted_values(index)(0) /= error_bit report "At index " severity error;
            
            assert wanted_values(index)(3 downto 1) /= total_bit report "At index " severity error;
            
        end loop;
        finish;
    end process;
end Behavioral;
