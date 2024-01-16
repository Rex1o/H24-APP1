library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Count4Bits is
    Port (
     values     : in STD_LOGIC_VECTOR(3 downto 0);
     sum  : out STD_LOGIC_VECTOR(2 downto 0);
     err     : out STD_LOGIC
     );
end Count4Bits;
architecture Behavioral of Count4Bits is
begin
    process (values)
    begin
        sum(2) <= values(3) and values(2) and values(1) and values(0);
        sum(1) <= not values(3) and values(1) and values(0);
        sum(0) <= (not values(3) and values(2) and values(1) and values(0)) or
                (not values(3) and not values(2) and not values(1) and values(0));
        err      <= (values(1) and not values(0)) or 
                        (values(3) and not values(2)) or
                        (values(2) and not values(1)) or
                        (values(3) and not values(1));
    end process;
end Behavioral;
