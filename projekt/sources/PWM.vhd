library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_RGB is
    port (
        clk       : in std_logic;
        rst       : in std_logic;
        red       : in std_logic_vector(7 downto 0);
        green     : in std_logic_vector(7 downto 0);
        blue      : in std_logic_vector(7 downto 0);
        red_out   : out std_logic;
        green_out : out std_logic;
        blue_out  : out std_logic
    );
end PWM_RGB;

architecture Behavioral of PWM_RGB is

    signal pwm_cnt : unsigned(7 downto 0) := (others => '0');

begin

    -- PWM counter
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                pwm_cnt <= (others => '0');
            else
                pwm_cnt <= pwm_cnt + 1;
            end if;
        end if;
    end process;

    -- compare (brightness control)
    red_out   <= '1' when pwm_cnt < unsigned(red)   else '0';
    green_out <= '1' when pwm_cnt < unsigned(green) else '0';
    blue_out  <= '1' when pwm_cnt < unsigned(blue)  else '0';

end Behavioral;
