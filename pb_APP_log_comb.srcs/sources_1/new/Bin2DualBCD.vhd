----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 02:28:30 PM
-- Design Name: 
-- Module Name: Bin2DualBCD - Behavioral
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

entity Bin2DualBCD is
    Port (
        ADCbin : in STD_LOGIC_VECTOR(3 downto 0);
        Dizaines : out STD_LOGIC_VECTOR(3 downto 0);
        Unites_ns : out STD_LOGIC_VECTOR(3 downto 0);
        Code_signe : out STD_LOGIC_VECTOR(3 downto 0);
        Unites_s : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Bin2DualBCD;

architecture Behavioral of Bin2DualBCD is
    component Moins_5
        Port(
            X          : in STD_LOGIC_VECTOR(3 downto 0);
            Difference : out STD_LOGIC_VECTOR(3 downto 0); -- Retourne la valeur en complement 2
            Cout       : out STD_LOGIC
        );
    end component;
    
    component Bin2DualBCD_S
        Port (
            ADCbin : in STD_LOGIC_VECTOR(3 downto 0); -- Representation complement 2
            Code_signe : out STD_LOGIC_VECTOR(3 downto 0);
            Unites_s : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component Bin2DualBCD_NS
        port (
            ADCbin : in STD_LOGIC_VECTOR(3 downto 0); -- Unsigned representation 
            Dizaines : out STD_LOGIC_VECTOR(3 downto 0);
            Unites_ns : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    signal diff0 : STD_LOGIC_VECTOR(3 downto 0);
    
begin
    moins_5_0 : Moins_5 port map(X => ADCbin, Difference => diff0); -- We ignore the Cout since we dont need it
    bin2dualbcd_s_0 : Bin2DualBCD_S  port map(ADCbin => diff0, Code_signe => Code_signe, Unites_s => Unites_s);
    bin2dualbcd_ns_0 : Bin2DualBCD_NS port map (ADCbin => ADCbin, Unites_ns => Unites_ns, Dizaines => Dizaines);
end Behavioral;
