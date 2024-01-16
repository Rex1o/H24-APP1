library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add4bit is
    Port (
        X    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Y    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin  : in  STD_LOGIC; 
        Sum  : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : out STD_LOGIC
    );
end Add4bit;

architecture Behavioral of Add4bit is
    component Add1bitA
        port(
        X, Y, Cin : in  STD_LOGIC;
        Sum, Cout : out STD_LOGIC
        );
    end component;
    
    component Add1bitB
        port(
        X, Y, Cin : in  STD_LOGIC;
        Sum, Cout : out STD_LOGIC
        );
    end component;
    signal c0, c1, c2 : STD_LOGIC;
begin
    add0 : Add1bitA port map (X => X(0), Y => Y(0), Cin => Cin, Cout => c0, Sum => Sum(0));
    add1 : Add1bitA port map (X => X(1), Y => Y(1), Cin => c0, Cout => c1, Sum => Sum(1));
    add2 : Add1bitB port map (X => X(2), Y => Y(2), Cin => c1, Cout => c2, Sum => Sum(2));
    add3 : Add1bitB port map (X => X(3), Y => Y(3), Cin => c2, Cout => Cout, Sum => Sum(3));    
end Behavioral;
