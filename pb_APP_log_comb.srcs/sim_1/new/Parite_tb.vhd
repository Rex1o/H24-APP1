----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 06:36:19 PM
-- Design Name: 
-- Module Name: Parite_tb - Behavioral
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

entity Parite_tb is
end Parite_tb;

architecture Behavioral of Parite_tb is

   component Parite
        Port (
        ADCbin : in  STD_LOGIC_VECTOR(3 downto 0);
        pair   : in STD_LOGIC;
        par : out STD_LOGIC
        );
    end component;
    signal ADCbin : STD_LOGIC_VECTOR(3 downto 0);
    signal pair   : STD_LOGIC;
    signal par : STD_LOGIC;
begin
    DUT : Parite port map (ADCbin => ADCbin, pair => pair, par => par);
    
    process
    variable wanted_values : STD_LOGIC_VECTOR(0 to 15) := 
     (  0  => '1',
        1  => '0',
        2  => '0',
        3  => '1',
        4  => '0',
        5  => '1',
        6  => '1',
        7  => '0',
        8  => '0',
        9  => '1',
        10  => '1',
        11  => '0',
        12  => '1',
        13  => '0',
        14  => '0',
        15  => '1'
      );
    begin
        pair <= '0';
        for index in 0 to 15 loop
           ADCbin <= conv_std_logic_vector(index, 4);
           wait for 1us;
           if (par /= wanted_values(index)) then
            report "Impair parity | Expected par: " &  std_logic'image(wanted_values(index)) & " but received " & std_logic'image(par) severity error;
            end if;
        end loop;
        
        pair <= '1';
        
        for index in 0 to 15 loop
           wanted_values(index) := not wanted_values(index);
           ADCbin <= conv_std_logic_vector(index, 4);
           wait for 1us;
           if (par /= wanted_values(index)) then
            report "Pair parity | Expected par: " &  std_logic'image(wanted_values(index)) & " but received " & std_logic'image(par) severity error;
           end if;
        end loop;
        finish;
    end process;
end Behavioral;
