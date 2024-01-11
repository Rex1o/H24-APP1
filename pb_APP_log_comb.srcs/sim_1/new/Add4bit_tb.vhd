----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 08:33:59 PM
-- Design Name: 
-- Module Name: Add4bit_tb - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add4bit_tb is
--  Port ( );
end Add4bit_tb;




architecture Behavioral of Add4bit_tb is
    component Add4bit 
        port (
            X    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin  : in  STD_LOGIC; 
            Sum    : out STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cout : out STD_LOGIC
            );
    end component;
       
    signal X    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Y    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Cin  : STD_LOGIC; 
    signal Sum  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Cout : STD_LOGIC;
begin
    DUT : Add4bit port map (X => X, Y => Y, Cin => Cin, Sum => Sum, Cout => Cout);
    
    process
    begin
        report("Starting sim");
        X   <= "0000";
        Y   <= "0000";
        Cin <= '0';
        
        wait for 1ms;
        X   <= "1010";
        Y   <= "0111";
        
        wait for 1ms;
        X   <= "0110";
        Y   <= "0101";
        
        wait for 1ms;
        X   <= "1001";
        Y   <= "0000";
        
        wait for 1ms;
        X   <= "0011";
        Y   <= "0111";
    end process;
end Behavioral;
