library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_en_fade is
    Generic (
        G_MAX : integer := 100_000 --1kHz
        );
    Port (
        clk : in  std_logic;
        rst : in  std_logic;
        ce  : out std_logic
    );
end clk_en_fade;

architecture Behavioral of clk_en_fade is

    signal cnt : integer range 0 to G_MAX-1 := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt <= 0;
                ce  <= '0';
            else
                if cnt = G_MAX-1 then
                    cnt <= 0;
                    ce  <= '1';   -- 1 takt pulse @ 1 kHz
                else
                    cnt <= cnt + 1;
                    ce  <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;