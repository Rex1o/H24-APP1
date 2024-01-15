----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 07:18:19 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_NS_tb - Behavioral
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

entity Bin2DualBCD_NS_tb is
--  Port ( );
end Bin2DualBCD_NS_tb;

architecture Behavioral of Bin2DualBCD_NS_tb is
    type truth_table is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    component Bin2DualBCD_NS
      Port (
            ADCbin : in STD_LOGIC_VECTOR(3 downto 0); -- Unsigned representation 
            Dizaines : out STD_LOGIC_VECTOR(3 downto 0);
            Unites_ns : out STD_LOGIC_VECTOR(3 downto 0)
       );
    end component;
    signal ADCbin : STD_LOGIC_VECTOR(3 downto 0); -- Unsigned representation 
    signal Dizaines : STD_LOGIC_VECTOR(3 downto 0);
    signal Unites_ns : STD_LOGIC_VECTOR(3 downto 0);
    
    begin
    
    DUT : Bin2DualBCD_NS port map (ADCbin => ADCbin, Dizaines => Dizaines, Unites_ns => Unites_ns);
    process
        variable wanted_dizaines : truth_table :=
        ( 0 => "0000", -- 0
          1 => "0000", -- 0
          2 => "0000", -- 0
          3 => "0000", -- 0
          4 => "0000", -- 0
          5 => "0000", -- 0
          6 => "0000", -- 0
          7 => "0000", -- 0
          8 => "0000", -- 0
          9 => "0000", -- 0
          10 => "0001", -- 1
          11 => "0001", -- 1
          12 => "0001", -- 1
          13 => "0001", -- 1
          14 => "0001", -- 1
          15 => "0001"  -- 1
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
          8 => "1000", -- 8
          9 => "1001", -- 9
          10 => "0000", -- 0
          11 => "0001", -- 1
          12 => "0010", -- 2
          13 => "0011", -- 3
          14 => "0100", -- 4
          15 => "0101"  -- 5
        );
    begin
    for index in 0 to 15 loop
        ADCbin <= conv_std_logic_vector(index, 4);
        wait for 1us;
        
        if (wanted_dizaines(index) /= Dizaines or wanted_unite(index) /= Unites_ns) then
            report "Error at number " & integer'image(index)  severity error;
        end if;
    end loop;
    finish;
    end process;

end Behavioral;
