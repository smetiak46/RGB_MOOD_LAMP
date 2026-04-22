library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_RGB_Lampa is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           btnu     : in STD_LOGIC;
           btnd     : in STD_LOGIC;
           btnr     : in STD_LOGIC;
           btnl     : in STD_LOGIC;
           LED16_r  : out STD_LOGIC;
           LED16_g  : out STD_LOGIC;
           LED16_b  : out STD_LOGIC);
end Top_RGB_Lampa;

architecture Behavioral of Top_RGB_Lampa is
    
    signal sig_brightness_u : std_logic;
    signal sig_brightness_d : std_logic;
    signal sig_speed_u      : std_logic;
    signal sig_speed_d      : std_logic;
    signal brght_sig        : std_logic_vector (7 downto 0);
    signal speed_sig        : std_logic_vector (7 downto 0);
    signal red_sig          : std_logic_vector (7 downto 0);
    signal green_sig        : std_logic_vector (7 downto 0);
    signal blue_sig         : std_logic_vector (7 downto 0);  
   
    component debounce is    
        Port ( 
           clk       : in STD_LOGIC;
           rst       : in STD_LOGIC;
           btn_in    : in STD_LOGIC;
           btn_state : out STD_LOGIC;
           btn_press : out STD_LOGIC);
    end component debounce;  
    
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
    end component brght_speed;
    
    component RGB_fade is
        Port (
        clk   : in std_logic;
        rst   : in std_logic;
        brght : in std_logic_vector(7 downto 0);
        speed : in std_logic_vector(7 downto 0);
        red   : out std_logic_vector(7 downto 0);
        green : out std_logic_vector(7 downto 0);
        blue  : out std_logic_vector(7 downto 0)
        );    
    end component RGB_fade; 
    
    component PWM is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            red      : in std_logic_vector(7 downto 0);
            green    : in std_logic_vector(7 downto 0);
            blue     : in std_logic_vector(7 downto 0);
            red_out  : out std_logic;
            green_out: out std_logic;
            blue_out : out std_logic
            );        
    end component PWM;
        
begin
    
    debounce_up : debounce
        Port map(
            clk       => clk,
            rst       => rst, 
            btn_in    => btnu,
            btn_state => open, 
            btn_press => sig_brightness_u
        );
     
    debounce_down : debounce
        Port map(
            clk       => clk,
            rst       => rst, 
            btn_in    => btnd,
            btn_state => open, 
            btn_press => sig_brightness_d
        );   
    
    debounce_right : debounce
        Port map(
            clk       => clk,
            rst       => rst, 
            btn_in    => btnr,
            btn_state => open,
            btn_press => sig_speed_u
        );
        
     debounce_left : debounce
        Port map(
            clk       => clk,
            rst       => rst, 
            btn_in    => btnl,
            btn_state => open,
            btn_press => sig_speed_d
        );   
     
     inst_bright_speed : brght_speed
        Port map(
            clk   => clk,
            rst   => rst,
            btnu  => sig_brightness_u,
            btnd  => sig_brightness_d,
            btnr  => sig_speed_u,
            btnl  => sig_speed_d,
            brght => brght_sig,
            speed => speed_sig
        );
        
     fade : RGB_fade
        Port map(
            clk   => clk,
            rst   => rst,
            brght => brght_sig,
            speed => speed_sig,
            red   => red_sig,
            blue  => blue_sig,
            green => green_sig   
        );
            
     inst_PWM : PWM
        Port map(
            clk       => clk,
            rst       => rst,
            red       => red_sig,
            green     => green_sig,
            blue      => blue_sig,
            red_out   => LED16_r,
            green_out => LED16_g,
            blue_out  => LED16_b
        );      
                                         
end Behavioral;


