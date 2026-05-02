library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_RGB_Lampa is
    Port (
        clk      : in STD_LOGIC;   
        rst      : in STD_LOGIC;
        btnu     : in STD_LOGIC;
        btnd     : in STD_LOGIC;
        btnr     : in STD_LOGIC;
        btnl     : in STD_LOGIC;
        LED16_r  : out STD_LOGIC;
        LED16_g  : out STD_LOGIC;
        LED16_b  : out STD_LOGIC
    );
end Top_RGB_Lampa;

architecture Behavioral of Top_RGB_Lampa is

    signal sig_btnu_p : std_logic;
    signal sig_btnd_p : std_logic;
    signal sig_btnr_p : std_logic;
    signal sig_btnl_p : std_logic;

    signal brght_sig : std_logic_vector(7 downto 0);
    signal speed_sig : std_logic_vector(7 downto 0);

    signal red_sig   : std_logic_vector(7 downto 0);
    signal green_sig : std_logic_vector(7 downto 0);
    signal blue_sig  : std_logic_vector(7 downto 0);

    signal sig_fade_en : std_logic;

    component debounce is
        Port (
            clk       : in STD_LOGIC;
            rst       : in STD_LOGIC;
            btn_in    : in STD_LOGIC;
            btn_state : out STD_LOGIC;
            btn_press : out STD_LOGIC
        );
    end component;

    component brght_speed is
        Port (
            clk   : in STD_LOGIC;
            rst   : in STD_LOGIC;
            btnu  : in STD_LOGIC;
            btnd  : in STD_LOGIC;
            btnr  : in STD_LOGIC;
            btnl  : in STD_LOGIC;
            brght : out STD_LOGIC_VECTOR(7 downto 0);
            speed : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component clk_en_fade is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ce  : out STD_LOGIC
        );
    end component;

    component RGB_FADE is
        Port (
            clk     : in STD_LOGIC;
            rst     : in STD_LOGIC;
            fade_en : in STD_LOGIC;
            brght   : in STD_LOGIC_VECTOR(7 downto 0);
            speed   : in STD_LOGIC_VECTOR(7 downto 0);
            red     : out STD_LOGIC_VECTOR(7 downto 0);
            green   : out STD_LOGIC_VECTOR(7 downto 0);
            blue    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component PWM_RGB is
        Port (
            clk       : in STD_LOGIC;
            rst       : in STD_LOGIC;
            red       : in STD_LOGIC_VECTOR(7 downto 0);
            green     : in STD_LOGIC_VECTOR(7 downto 0);
            blue      : in STD_LOGIC_VECTOR(7 downto 0);
            red_out   : out STD_LOGIC;
            green_out : out STD_LOGIC;
            blue_out  : out STD_LOGIC
        );
    end component;

begin

    -- DEBOUNCERS
    deb_u : debounce
        port map(clk, rst, btnu, open, sig_btnu_p);

    deb_d : debounce
        port map(clk, rst, btnd, open, sig_btnd_p);

    deb_r : debounce
        port map(clk, rst, btnr, open, sig_btnr_p);

    deb_l : debounce
        port map(clk, rst, btnl, open, sig_btnl_p);

    -- BRIGHTNESS + SPEED CONTROL
    ctrl : brght_speed
        port map(
            clk   => clk,
            rst   => rst,
            btnu  => sig_btnu_p,
            btnd  => sig_btnd_p,
            btnr  => sig_btnr_p,
            btnl  => sig_btnl_p,
            brght => brght_sig,
            speed => speed_sig
        );

    -- 1 kHz CLOCK ENABLE 
    ce : clk_en_fade
        port map(
            clk => clk,
            rst => rst,
            ce  => sig_fade_en
        );

    -- RGB FADE LOGIC
    fade : RGB_FADE
        port map(
            clk     => clk,
            rst     => rst,
            fade_en => sig_fade_en,
            brght   => brght_sig,
            speed   => speed_sig,
            red     => red_sig,
            green   => green_sig,
            blue    => blue_sig
        );

    -- PWM 
    pwm : PWM_RGB
        port map(
            clk   => clk,
            rst   => rst,
            red   => red_sig,
            green => green_sig,
            blue  => blue_sig,

            red_out   => LED16_r,
            green_out => LED16_g,
            blue_out  => LED16_b
        );

end Behavioral;
