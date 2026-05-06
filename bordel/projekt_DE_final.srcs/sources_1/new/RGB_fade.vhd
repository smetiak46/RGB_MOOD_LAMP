library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RGB_FADE is
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
end RGB_FADE;

architecture Behavioral of RGB_FADE is

    -- timer
    signal timer : unsigned(19 downto 0) := (others => '0');

    -- 4 stavy: R → G → B → OFF
    signal step  : unsigned(1 downto 0) := (others => '0');

    -- threshold
    signal threshold : unsigned(19 downto 0);
    signal speed_scaled : unsigned(19 downto 0);

    -- minimálny čas jednej farby (pri 1 kHz enable)
    constant MIN_DELAY : unsigned(19 downto 0) := to_unsigned(20, 20);  
    -- ≈ 20 ms → vždy viditeľné

begin

    -- škálovanie rýchlosti (jemnejšie kroky)
    speed_scaled <= resize(unsigned(speed), 20) sll 4;

    -- finálny prah
    threshold <= MIN_DELAY + speed_scaled;

    ----------------------------------------------------------------
    -- RIADIACI FSM
    ----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then

            if rst = '1' then
                timer <= (others => '0');
                step  <= (others => '0');

            else
                if fade_en = '1' then

                    if timer >= threshold then
                        timer <= (others => '0');

                        -- cyklus cez 4 stavy
                        if step = "11" then
                            step <= "00";
                        else
                            step <= step + 1;
                        end if;

                    else
                        timer <= timer + 1;
                    end if;

                end if;
            end if;

        end if;
    end process;

    -- OUTPUT LOGIKA
    process(step, brght)
    begin
        red   <= (others => '0');
        green <= (others => '0');
        blue  <= (others => '0');

        case step is

            when "00" =>
                red <= brght;

            when "01" =>
               
                green <= brght;

            when "10" =>
                
                blue <= brght;

            when "11" =>
                -- OFF
                null;

        end case;
    end process;

end Behavioral;

