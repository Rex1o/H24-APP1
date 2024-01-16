library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add1bitB is
    Port (
        X    : in  STD_LOGIC;
        Y    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC; 
        Sum    : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end Add1bitB;

architecture Behavioral of Add1bitB is
begin
    process (X, Y, Cin)
    begin
        Sum <= X xor Y xor Cin;
        Cout <= (X and Y) or (Y and Cin) or (Cin and X);
    end process;
end Behavioral;
