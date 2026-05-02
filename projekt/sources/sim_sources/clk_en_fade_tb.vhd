library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_en_fade_tb is
end clk_en_fade_tb;

architecture Behavioral of clk_en_fade_tb is

    component clk_en_fade
        generic (
            G_MAX : integer := 100_000
        );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ce  : std_logic;

    constant clk_period : time := 10 ns;

begin

    dut: clk_en_fade
        generic map (
            G_MAX => 10   -- pre simuláciu
        )
        port map (
            clk => clk,
            rst => rst,
            ce  => ce
        );

    -- Clock generation (100 MHz)
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    stimuli: process
    begin

        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        wait for 500 ns;

        rst <= '1';
        wait for 30 ns;
        rst <= '0';

        wait for 300 ns;
        wait;

    end process;

end Behavioral;