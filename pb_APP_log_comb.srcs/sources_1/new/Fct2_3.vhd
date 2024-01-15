----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2024 02:21:35 PM
-- Design Name: 
-- Module Name: Fct2_3 - Behavioral
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

entity Fct2_3 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0)
          );
end Fct2_3;

architecture Behavioral of Fct2_3 is
    component DivideBy2
        Port ( Xin : in STD_LOGIC_VECTOR (3 downto 0);
               Yout : out STD_LOGIC_VECTOR (3 downto 0);
               YoutFloat : out STD_LOGIC_VECTOR (3 downto 0)
              );
    end component;
    
    component DivideBy8
        Port ( Xin : in STD_LOGIC_VECTOR (3 downto 0);
               Yout : out STD_LOGIC_VECTOR (3 downto 0);
               YoutFloat : out STD_LOGIC_VECTOR (3 downto 0)
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
    
    signal divide2ToAdd, divide2FloatToAdd, divide8ToAdd, divide8FloatToAdd, sumResult, sumResultFloat : STD_LOGIC_VECTOR (3 downto 0);
    signal carryOut, carryOutFloat : STD_LOGIC;
begin

terme0 : DivideBy2
        port map(
            Xin => ADCbin,
            Yout => divide2ToAdd,
            YoutFloat => divide2FloatToAdd
        );
        
    terme1 : DivideBy8
        port map(
            Xin => ADCbin,
            Yout => divide8ToAdd,
            YoutFloat => divide8FloatToAdd
        );
        
    adder : Add4Bit
        port map(
            X => divide2ToAdd,
            Y => divide8ToAdd,
            Cin => carryOutFloat,
            Sum => sumResult,
            Cout => carryOut
        );
        
    adderFloat : Add4Bit
        port map(
            X => divide2FloatToAdd,
            Y => divide8FloatToAdd,
            Cin => '0',
            Sum => sumResultFloat,
            Cout => carryOutFloat
        );
            
     A2_3 <= sumResult(2 downto 0);
end Behavioral;
