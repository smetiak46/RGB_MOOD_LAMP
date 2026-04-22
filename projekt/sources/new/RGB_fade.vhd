library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RGB_FADE is
    port (
        clk   : in std_logic;
        rst   : in std_logic;
        brght : in std_logic_vector(7 downto 0);
        speed : in std_logic_vector(7 downto 0);
        red   : out std_logic_vector(7 downto 0);
        green : out std_logic_vector(7 downto 0);
        blue  : out std_logic_vector(7 downto 0)
    );
end RGB_FADE;

architecture Behavioral of RGB_FADE is

    signal timer : unsigned(15 downto 0) := (others => '0');
    signal step  : unsigned(1 downto 0) := (others => '0');
    signal br    : std_logic_vector(7 downto 0);
    signal sp    : unsigned(7 downto 0);

begin

    br <= brght;
    sp <= unsigned(speed);

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                step  <= (others => '0');
                timer <= (others => '0');

            else
                if timer = 0 then
                    timer <= resize(sp(7 downto 4) + 1, timer'length);

                    if step = "10" then
                        step <= (others => '0');
                    else
                        step <= step + 1;
                    end if;

                else
                    timer <= timer - 1;
                end if;
            end if;
        end if;
    end process;

    process(step, br)
    begin
        red   <= (others => '0');
        green <= (others => '0');
        blue  <= (others => '0');

        case step is
            when "00" =>
                red <= br;

            when "01" =>
                green <= br;

            when "10" =>
                blue <= br;

            when others =>
                null;
        end case;
    end process;

end Behavioral;
