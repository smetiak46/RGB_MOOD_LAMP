library ieee;
use ieee.std_logic_1164.all;

entity tb_PWM_RGB is
end tb_PWM_RGB;

architecture tb of tb_PWM_RGB is

    component PWM_RGB
        port (
            clk        : in std_logic;
            rst        : in std_logic;
            red        : in std_logic_vector (7 downto 0);
            green      : in std_logic_vector (7 downto 0);
            blue       : in std_logic_vector (7 downto 0);
            red_out    : out std_logic;
            green_out  : out std_logic;
            blue_out   : out std_logic
        );
    end component;

    signal clk       : std_logic := '0';
    signal rst       : std_logic := '0';

    signal red       : std_logic_vector (7 downto 0) := (others => '0');
    signal green     : std_logic_vector (7 downto 0) := (others => '0');
    signal blue      : std_logic_vector (7 downto 0) := (others => '0');

    signal red_out   : std_logic;
    signal green_out : std_logic;
    signal blue_out  : std_logic;

    constant TbPeriod : time := 10 ns;

    signal TbClock    : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_RGB
        port map (
            clk       => clk,
            rst       => rst,
            red       => red,
            green     => green,
            blue      => blue,
            red_out   => red_out,
            green_out => green_out,
            blue_out  => blue_out
        );

    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    clk <= TbClock;

    stimuli : process

        type val8 is array (0 to 1) of std_logic_vector(7 downto 0);

        constant red_vals : val8 := (
            x"1A",
            x"FF"
        );

        constant green_vals : val8 := (
            x"40",
            x"E6"
        );

        constant blue_vals : val8 := (
            x"80",
            x"BF"
        );

    begin

        red   <= (others => '0');
        green <= (others => '0');
        blue  <= (others => '0');

        rst <= '1';
        wait for 200 ns;
        rst <= '0';
        wait for 200 ns;

        -- test case 1
        red   <= red_vals(0);
        green <= green_vals(0);
        blue  <= blue_vals(0);

        wait for 25 ms;

        -- test case 2
        red   <= red_vals(1);
        green <= green_vals(1);
        blue  <= blue_vals(1);

        wait for 25 ms;

        TbSimEnded <= '1';
        wait;

    end process;

end tb;