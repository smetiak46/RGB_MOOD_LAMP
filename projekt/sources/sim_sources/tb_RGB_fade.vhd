-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 22 Apr 2026 12:14:25 GMT
-- Request id : cfwk-fed377c2-69e8bba18f56e

library ieee;
use ieee.std_logic_1164.all;

entity tb_RGB_FADE is
end tb_RGB_FADE;

architecture tb of tb_RGB_FADE is

    component RGB_FADE
        port (clk   : in std_logic;
              rst   : in std_logic;
              brght : in std_logic_vector (7 downto 0);
              speed : in std_logic_vector (7 downto 0);
              red   : out std_logic_vector (7 downto 0);
              green : out std_logic_vector (7 downto 0);
              blue  : out std_logic_vector (7 downto 0));
    end component;

    signal clk   : std_logic;
    signal rst   : std_logic;
    signal brght : std_logic_vector (7 downto 0) := (others => '0');
    signal speed : std_logic_vector (7 downto 0) := (others => '0');
    signal red   : std_logic_vector (7 downto 0);
    signal green : std_logic_vector (7 downto 0);
    signal blue  : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 0.5 ms; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RGB_FADE
    port map (clk   => clk,
              rst   => rst,
              brght => brght,
              speed => speed,
              red   => red,
              green => green,
              blue  => blue);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        brght <= (others => '0');
        speed <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 2 ms;
        rst <= '0';
        wait for 2 ms;
        -- brightness test
        brght <= x"ff";
        wait for 2ms;
        brght <= x"00";
        wait for 2ms;
        speed <= x"00";
        wait for 2ms;
        speed <= x"FF";
        
        brght <= x"26";
        wait for 2ms;
        rst <= '1';
        wait for 1ms;
        rst <= '0';
        wait for 1ms;
        speed <= x"FF";
        brght <= x"26";
        wait for 2ms;
        
        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_RGB_FADE of tb_RGB_FADE is
    for tb
    end for;
end cfg_tb_RGB_FADE;
