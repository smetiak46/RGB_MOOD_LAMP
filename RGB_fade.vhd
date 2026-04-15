library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RGB_FADE is
    port (
        clk : in std_logic;
        rst : in std_logic;

        brght : in std_logic_vector(7 downto 0);
        speed : in std_logic_vector(7 downto 0);

        red : out std_logic_vector(7 downto 0);
        green : out std_logic_vector(7 downto 0);
        blue : out std_logic_vector(7 downto 0)
    );
end RGB_FADE;

architecture Behavioral of RGB_FADE is

    -- counter pre časovanie
    signal cnt_speed : unsigned(23 downto 0) := (others => '0');

    -- 256-step fade
    signal step : unsigned(7 downto 0) := (others => '0');

    -- RGB interné hodnoty
    signal r, g, b : unsigned(7 downto 0);

    -- brightness
    signal br : unsigned(7 downto 0);

begin

    br <= unsigned(brght);

    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt_speed <= (others => '0');
                step <= (others => '0');
            else
                cnt_speed <= cnt_speed + 1;                
                if cnt_speed = (resize(unsigned(speed), 24) * 256) then
                    cnt_speed <= (others => '0');
                    step <= step + 1;
                end if;

            end if;
        end if;
    end process;
    
    process(step)
    begin
        case step(7 downto 6) is

            when "00" => 
                r <= 255 - step;
                g <= step;
                b <= (others => '0');

            when "01" => 
                r <= (others => '0');
                g <= 255 - step;
                b <= step;

            when "10" => 
                r <= step;
                g <= (others => '0');
                b <= 255 - step;

            when others =>
                r <= (others => '0');
                g <= (others => '0');
                b <= (others => '0');

        end case;
    end process;

   
    red <= std_logic_vector((r * br) / 255);
    green <= std_logic_vector((g * br) / 255);
    blue <= std_logic_vector((b * br) / 255);

end Behavioral;