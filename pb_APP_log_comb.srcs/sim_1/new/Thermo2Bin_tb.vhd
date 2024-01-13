----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 05:19:44 PM
-- Design Name: 
-- Module Name: Thermo2Bin_tb - Behavioral
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

entity Thermo2Bin_tb is
--  Port ( );
end Thermo2Bin_tb;

architecture Behavioral of Thermo2Bin_tb is
type truth_table is array (0 to 12) of STD_LOGIC_VECTOR(11 downto 0);
type error_table is array (0 to 10) of STD_LOGIC_VECTOR(11 downto 0);
    component Thermo2Bin
         Port (
            ADCth  : in  STD_LOGIC_VECTOR(11 downto 0);
            err    : out STD_LOGIC;
            ADCbin : out STD_LOGIC_VECTOR(3 downto 0)
        );
     end component;

     signal ADCth  : STD_LOGIC_VECTOR(11 downto 0);
     signal err    : STD_LOGIC;
     signal ADCbin : STD_LOGIC_VECTOR(3 downto 0);
begin
 DUT : Thermo2Bin port map(ADCth => ADCth, err => err, ADCbin => ADCbin);
    process
         variable test_values : truth_table :=
     (  0  => "000000000000",
        1  => "000000000001",
        2  => "000000000011",
        3  => "000000000111",
        4  => "000000001111",
        5  => "000000011111",
        6  => "000000111111",
        7  => "000001111111",
        8  => "000011111111",
        9  => "000111111111",
        10 => "001111111111",
        11 => "011111111111",
        12 => "111111111111"
      );
         variable error_test_values : error_table :=
     (  0  => "000000000010",
        1  => "000000000100",
        2  => "000000001000",
        3  => "000000010000",
        4  => "000000100000",
        5  => "000001000000",
        6  => "000010000000",
        7  => "000100000000",
        8  => "001000000000",
        9  => "010000000000",
        10 => "100000000000"
      );
    begin
        for index in 0 to 12 loop
            ADCth <= test_values(index);
            wait for 1us;
            --assert ADCbin /= conv_std_logic_vector(index, 4); report "At index " severity error;
            --assert err /= '0'; report "At index " severity error;  
        end loop;
    
       for index in 0 to 10 loop
            ADCth <= error_test_values(index);
            wait for 1us;
            --assert err /= '1' report "At index " severity error;  
        end loop;
    finish;
    end process;
end Behavioral;
