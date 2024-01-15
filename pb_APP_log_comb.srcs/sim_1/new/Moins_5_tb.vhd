----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 06:17:04 PM
-- Design Name: 
-- Module Name: Moins_5_tb - Behavioral
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
entity Moins_5_tb is
end Moins_5_tb;

architecture Behavioral of Moins_5_tb is
    type truth_table is array (0 to 15) of STD_LOGIC_VECTOR(4 downto 0);
    component Moins_5
    port (
        X          : in STD_LOGIC_VECTOR(3 downto 0);
        Difference : out STD_LOGIC_VECTOR(3 downto 0); -- Retourne la valeur en complement 2
        Cout       : out STD_LOGIC
    );
    end component;
    signal X : STD_LOGIC_VECTOR(3 downto 0);
    signal Difference : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout : STD_LOGIC;
begin
    DUT : Moins_5 port map(X => X, Difference => Difference, Cout => Cout);
    process
        variable wanted_values : truth_table := 
     (  0  => "01011", -- First bit indicates the cary
        1  => "01100",
        2  => "01101",
        3  => "01110",
        4  => "01111",
        5  => "10000",
        6  => "10001",
        7  => "10010",
        8  => "10011",
        9  => "10100",
        10 => "10101",
        11 => "10110",
        12 => "10111",
        13 => "11000",
        14 => "11001",
        15 => "11010"
      );
    begin
    for index in 0 to 15 loop
        X <= conv_std_logic_vector(index, 4);
        wait for 1us;
        
        if (wanted_values(index)(4) /= Cout or wanted_values(index)(3 downto 0) /= Difference) then
            report "Error at number " & integer'image(index)  severity error;
        end if;
    end loop;
    finish;
    end process;

end Behavioral;
