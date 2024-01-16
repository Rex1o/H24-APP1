library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add1bitA is
    Port (
        X    : in  STD_LOGIC;
        Y    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC; 
        Sum    : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end Add1bitA;

architecture Behavioral of Add1bitA is
begin
    process (X, Y, Cin)
    variable v_concatenate : std_logic_vector(2 downto 0);
    
    begin
    v_concatenate := X & Y & Cin;
        case (v_concatenate) is
            when "111" =>
                Sum  <= '1';
                Cout <= '1';
            when "000" =>
                Sum  <= '0';
                Cout <= '0';
            when "001" | "010" | "100" =>
                Sum  <= '1';
                Cout <= '0';
            when others =>
                Sum  <= '0';
                Cout <= '1';
        end case;
    end process;
    
end Behavioral;
