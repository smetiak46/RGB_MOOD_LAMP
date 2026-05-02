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

    -- 20-bit timer pre časovanie prechodu
    signal timer : unsigned(19 downto 0) := (others => '0');
    -- 2-bit stav RGB (R → G → B)
    signal step  : unsigned(1 downto 0) := (others => '0');
    -- dynamický prah rýchlosti
    signal threshold : unsigned(19 downto 0);

begin

    -- SPEED → časový prah
    threshold <= (unsigned(speed) & "000000000000") + 1;

    -- RIADIACI FSM (beží len pri 1 kHz enable)
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

                        if step = "10" then
                            step <= (others => '0');
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

    -- OUTPUT LOGIKA (kombinačná)
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

            when others =>
                null;
        end case;
    end process;

end Behavioral;
