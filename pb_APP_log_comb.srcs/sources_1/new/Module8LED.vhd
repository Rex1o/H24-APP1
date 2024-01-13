----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 03:27:16 PM
-- Design Name: 
-- Module Name: Module8LED - Behavioral
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

entity Module8LED is
    Port ( termoBin : in STD_LOGIC_VECTOR (3 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0)
          );
end Module8LED;

architecture Behavioral of Module8LED is
    component DivideBy2
        Port ( Xin : in STD_LOGIC_VECTOR (3 downto 0);
               Yout : out STD_LOGIC_VECTOR (3 downto 0)
              );
    end component;
    
    component DivideBy8
        Port ( Xin : in STD_LOGIC_VECTOR (3 downto 0);
               Yout : out STD_LOGIC_VECTOR (3 downto 0)
         );
    end component;
    
    component Add4Bit
        Port ( X    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
               Y    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
               Cin  : in  STD_LOGIC; 
               Sum    : out STD_LOGIC_VECTOR(3 DOWNTO 0);
               Cout : out STD_LOGIC
            );
     end component;
    
    
    component Decodeur3_8
        Port ( choice : in STD_LOGIC_VECTOR (2 downto 0);
               output : out STD_LOGIC_VECTOR (7 downto 0) 
          );
    end component;
    
    signal divide2ToAdd, divide8ToAdd, sumResult : STD_LOGIC_VECTOR (3 downto 0);
    signal convertedSumResult : STD_LOGIC_VECTOR (2 downto 0);
    signal carryOut : STD_LOGIC;
    
begin
    terme0 : DivideBy2
        port map(
            Xin => termoBin,
            Yout => divide2ToAdd
        );
        
    terme1 : DivideBy8
        port map(
            Xin => termoBin,
            Yout => divide8ToAdd
        );
        
    adder : Add4Bit
        port map(
            X => divide2ToAdd,
            Y => divide8ToAdd,
            Cin => '0',
            Sum => sumResult,
            Cout => carryOut
        );
            
     
     convertedSumResult(0) <= sumResult(0);
     convertedSumResult(1) <= sumResult(1);
     convertedSumResult(2) <= sumResult(2);
     
     ledChoice : Decodeur3_8
        port map(
            choice => convertedSumResult,
            output => LED
        );
     
        
            
        
        





end Behavioral;
