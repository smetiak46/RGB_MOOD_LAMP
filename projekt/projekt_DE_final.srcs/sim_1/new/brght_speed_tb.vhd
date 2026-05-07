-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Tue, 14 Apr 2026 23:38:01 GMT
-- Request id : cfwk-fed377c2-69decfd9c613e

library ieee;
use ieee.std_logic_1164.all;

entity tb_brght_speed is
end tb_brght_speed;

architecture tb of tb_brght_speed is

    component brght_speed
        port (clk   : in std_logic;
              rst   : in std_logic;
              btnu  : in std_logic;
              btnd  : in std_logic;
              btnr  : in std_logic;
              btnl  : in std_logic;
              brght : out std_logic_vector (7 downto 0);
              speed : out std_logic_vector (7 downto 0));
    end component;

    signal clk   : std_logic;
    signal rst   : std_logic;
    signal btnu  : std_logic;
    signal btnd  : std_logic;
    signal btnr  : std_logic;
    signal btnl  : std_logic;
    signal brght : std_logic_vector (7 downto 0);
    signal speed : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10   ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : brght_speed
    port map (clk   => clk,
              rst   => rst,
              btnu  => btnu,
              btnd  => btnd,
              btnr  => btnr,
              btnl  => btnl,
              brght => brght,
              speed => speed);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        btnu <= '0';
        btnd <= '0';
        btnr <= '0';
        btnl <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- 1. testovanie jasu pre všetky nastavitelné hodnoty   
        -- Smerom hore
        for i in 1 to 7 loop
            btnu <= '1';            
            wait for 10 ns;  
            btnu <= '0';            
            wait for 10 ns;  
        end loop;

        for i in 1 to 7 loop
            btnd <= '1';            
            wait for 10 ns;
            btnd <= '0';            
            wait for 10 ns;
        end loop;
        
        -- 2. testovanie rýchlosti pre všetky nastavitelné hodnoty
        -- Smerom doprava
        for i in 1 to 7 loop
            btnr <= '1';            
            wait for 10 ns;
            btnr <= '0';            
            wait for 10 ns;
        end loop;

        -- Smerom doľava 
        for i in 1 to 7 loop
            btnl <= '1'; 
            wait for 10 ns; 
            btnl <= '0';
            wait for 10 ns;
        end loop;

        wait for 1000 ns;
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_brght_speed of tb_brght_speed is
    for tb
    end for;
end cfg_tb_brght_speed;
