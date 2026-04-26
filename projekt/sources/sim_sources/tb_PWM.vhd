-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 22 Apr 2026 13:35:33 GMT
-- Request id : cfwk-fed377c2-69e8cea5f2ca6

library ieee;
use ieee.std_logic_1164.all;

entity tb_PWM_RGB is
end tb_PWM_RGB;

architecture tb of tb_PWM_RGB is

    component PWM_RGB
        port (clk       : in std_logic;
              rst       : in std_logic;
              red       : in std_logic_vector (7 downto 0);
              green     : in std_logic_vector (7 downto 0);
              blue      : in std_logic_vector (7 downto 0);
              red_out   : out std_logic;
              green_out : out std_logic;
              blue_out  : out std_logic);
    end component;

    signal clk       : std_logic;
    signal rst       : std_logic;
    signal red       : std_logic_vector (7 downto 0);
    signal green     : std_logic_vector (7 downto 0);
    signal blue      : std_logic_vector (7 downto 0);
    signal red_out   : std_logic;
    signal green_out : std_logic;
    signal blue_out  : std_logic;

    constant TbPeriod : time := 0.5 ms; -- ***EDIT*** Put right period here
    signal TbClock    : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_RGB
    port map (clk       => clk,
              rst       => rst,
              red       => red,
              green     => green,
              blue      => blue,
              red_out   => red_out,
              green_out => green_out,
              blue_out  => blue_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        red   <= (others => '0');
        green <= (others => '0');
        blue  <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 1 ms;
        rst <= '0';
        wait for 1 ms;
        red <= x"80";
        wait for 2ms;
        red <= x"60";
        wait for 2ms;
        green <= x"60";
        wait for 2ms; 
        blue <= x"60";
        wait for 2ms;
        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PWM_RGB of tb_PWM_RGB is
    for tb
    end for;
end cfg_tb_PWM_RGB;

