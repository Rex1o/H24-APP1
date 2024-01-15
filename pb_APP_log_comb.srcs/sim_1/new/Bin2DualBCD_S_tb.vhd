----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 07:18:19 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_S_tb - Behavioral
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

entity Bin2DualBCD_S_tb is
--  Port ( );
end Bin2DualBCD_S_tb;

architecture Behavioral of Bin2DualBCD_S_tb is
    type truth_table is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    component Bin2DualBCD_S
      Port (
            ADCbin : in STD_LOGIC_VECTOR(3 downto 0); -- Unsigned representation 
            Code_signe : out STD_LOGIC_VECTOR(3 downto 0);
            Unites_s : out STD_LOGIC_VECTOR(3 downto 0)
       );
    end component;
    signal ADCbin : STD_LOGIC_VECTOR(3 downto 0); -- Unsigned representation 
    signal Code_signe : STD_LOGIC_VECTOR(3 downto 0);
    signal Unites_s : STD_LOGIC_VECTOR(3 downto 0);
    
    begin
    
    DUT : Bin2DualBCD_S port map (ADCbin => ADCbin, Code_signe => Code_signe, Unites_s => Unites_s);
    process
        variable wanted_code_signe : truth_table :=
        ( 0 => "0000",
          1 => "0000",
          2 => "0000",
          3 => "0000",
          4 => "0000",
          5 => "0000",
          6 => "0000",
          7 => "0000",
          8 => "1111",
          9 => "1111",
          10 => "1111",
          11 => "1111",
          12 => "1111",
          13 => "1111",
          14 => "1111",
          15 => "1111"
        );
        
        variable wanted_unite : truth_table :=
        ( 0 => "0000", -- 0
          1 => "0001", -- 1
          2 => "0010", -- 2
          3 => "0011", -- 3
          4 => "0100", -- 4
          5 => "0101", -- 5
          6 => "0110", -- 6
          7 => "0111", -- 7
          8 => "1000", -- -8
          9 => "0111", -- -7
          10 => "0110", -- -6
          11 => "0101", -- -5
          12 => "0100", -- -4
          13 => "0011", -- -3
          14 => "0010", -- -2
          15 => "0001"  -- -1
        );
    begin
    for index in 0 to 15 loop
        ADCbin <= conv_std_logic_vector(index, 4);
        wait for 1us;
        
        if (wanted_unite(index) /= Unites_s or wanted_code_signe(index) /= Code_signe) then
            report "Error at number " & integer'image(index)  severity error;
        end if;
    end loop;
    finish;
    end process;

end Behavioral;
