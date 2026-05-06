library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_RGB is
    port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        red        : in  std_logic_vector(7 downto 0); 
        green      : in  std_logic_vector(7 downto 0); 
        blue       : in  std_logic_vector(7 downto 0); 
        red_out    : out std_logic;                   
        green_out  : out std_logic;                   
        blue_out   : out std_logic                    
    );
end PWM_RGB;

architecture Behavioral of PWM_RGB is
    -- 8-bitový čítač definuje 256 úrovní jasu (0 až 255)
    signal pwm_cnt : unsigned(7 downto 0) := (others => '0');
begin

    -- PWM proces
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                pwm_cnt   <= (others => '0');
                red_out   <= '0';
                green_out <= '0';
                blue_out  <= '0';
            else
                -- Inkrementácia hlavného PWM čítača
                pwm_cnt <= pwm_cnt + 1;

                -- Porovnávanie pre Červenú
                if pwm_cnt < unsigned(red) then
                    red_out <= '1';
                else
                    red_out <= '0';
                end if;

                -- Porovnávanie pre Zelenú
                if pwm_cnt < unsigned(green) then
                    green_out <= '1';
                else
                    green_out <= '0';
                end if;

                -- Porovnávanie pre Modrú
                if pwm_cnt < unsigned(blue) then
                    blue_out <= '1';
                else
                    blue_out <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;