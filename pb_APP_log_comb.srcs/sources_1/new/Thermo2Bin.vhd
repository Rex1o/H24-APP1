library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Thermo2Bin is
    Port (
        ADCth  : in  STD_LOGIC_VECTOR(11 downto 0);
        err    : out STD_LOGIC;
        ADCbin : out STD_LOGIC_VECTOR(3 downto 0)
        );
end Thermo2Bin;

architecture Behavioral of Thermo2Bin is
    component Count4Bits
        Port (
            values : in STD_LOGIC_VECTOR(3 downto 0);
            sum    : out STD_LOGIC_VECTOR(2 downto 0);
            err    : out STD_LOGIC
         );
    end component;
    
    component Add4bit
        Port (
            X    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin  : in  STD_LOGIC; 
            Sum  : out STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cout : out STD_LOGIC
        );
    end component;
    signal err0, err1, err2 : STD_LOGIC;
    signal count_sum0, count_sum1, count_sum2 : STD_LOGIC_VECTOR(2 downto 0);
    signal sum0 : STD_LOGIC_VECTOR(3 downto 0);
    signal c0 : STD_LOGIC;
begin
    count0 : Count4Bits port map (values => ADCth(3 downto 0), err => err0, sum => count_sum0);
    count1 : Count4Bits port map (values => ADCth(7 downto 4), err => err1, sum => count_sum1);
    count2 : Count4Bits port map (values => ADCth(11 downto 8), err => err2, sum => count_sum2);
    
    add0 : Add4bit port map (X(3) => '0', X(2 downto 0) => count_sum0, Y(3) => '0', Y(2 downto 0) => count_sum1, Cin => '0', Cout => c0, Sum => sum0);
    add1 : Add4bit port map (X => sum0, Y(3) => '0', Y(2 downto 0) => count_sum2, Cin => c0, Sum => ADCbin);
    
    err <= err0 or err1 or err2 or (not ADCth(3) and ADCth(4)) or (not ADCth(7) and ADCth(8));

end Behavioral;
