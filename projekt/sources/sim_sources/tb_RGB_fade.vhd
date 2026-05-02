-- Testbench for RGB_FADE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_RGB_FADE is
end tb_RGB_FADE;

architecture tb of tb_RGB_FADE is

    component RGB_FADE
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            fade_en : in  std_logic;
            brght   : in  std_logic_vector(7 downto 0);
            speed   : in  std_logic_vector(7 downto 0);
            red     : out std_logic_vector(7 downto 0);
            green   : out std_logic_vector(7 downto 0);
            blue    : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal fade_en : std_logic := '0';

    signal brght   : std_logic_vector(7 downto 0) := (others => '0');
    signal speed   : std_logic_vector(7 downto 0) := (others => '0');

    signal red     : std_logic_vector(7 downto 0);
    signal green   : std_logic_vector(7 downto 0);
    signal blue    : std_logic_vector(7 downto 0);

    constant TbPeriod : time := 10 ns;

    signal TbClock     : std_logic := '0';
    signal TbSimEnded  : std_logic := '0';

    type val_array is array (0 to 3) of integer;
    constant test_values : val_array := (0, 64, 128, 255);

begin

    dut : RGB_FADE
        port map (
            clk     => clk,
            rst     => rst,
            fade_en => fade_en,
            brght   => brght,
            speed   => speed,
            red     => red,
            green   => green,
            blue    => blue
        );

    -- clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    clk <= TbClock;

    -- stimuli process
    stimuli : process
        variable wait_time : time;
    begin

        -- RESET
        rst <= '1';
        fade_en <= '0';
        brght <= (others => '0');
        speed <= (others => '0');

        wait for 100 ns;

        rst <= '0';
        fade_en <= '1';

        wait for 100 ns;

        -- test rôzne hodnoty
        for i in 0 to 3 loop

            brght <= std_logic_vector(to_unsigned(test_values(i), 8));
            speed <= std_logic_vector(to_unsigned(test_values(i), 8));

            -- čas pre prechod RGB (R->G->B)
            wait_time := test_values(i) * 4096 * 3 * TbPeriod;

            wait for wait_time;
            wait for 10 * TbPeriod;

        end loop;

        TbSimEnded <= '1';
        wait;

    end process;

end tb;
