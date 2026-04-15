library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;   

entity brght_speed is
    Port ( clk   : in STD_LOGIC;
           rst   : in STD_LOGIC;
           btnu :  in STD_LOGIC;
           btnd  : in STD_LOGIC;
           btnr  : in STD_LOGIC;
           btnl  : in STD_LOGIC;
           brght : out STD_LOGIC_VECTOR(7 downto 0);
           speed : out STD_LOGIC_VECTOR(7 downto 0)
           );
end brght_speed;

architecture Behavioral of brght_speed is

    type brght_val is array (0 to 7) of integer range 0 to 255;
    constant brightnes : brght_val := (0, 26, 64, 102, 128, 191, 230, 255);
    
    type speed_val is array (0 to 7) of integer range 0 to 255;
    constant spd : speed_val := (0, 26, 64, 102, 128, 191, 230, 255);
    
    signal index_brght : integer range 0 to 7 := 0;
    signal index_speed : integer range 0 to 7 := 0;
    
begin 
    
    process(clk)
    begin 
    
        if rising_edge(clk) then
            if rst = '1' then
                index_brght <= 0;
                index_speed <= 0;
            else 
                if btnu = '1' then
                    if index_brght < 7 then
                        index_brght <= index_brght + 1;
                        index_speed <= index_speed;
                    end if;
                elsif btnd = '1' then
                    if index_brght > 0 then
                        index_brght <= index_brght - 1;
                        index_speed <= index_speed;
                    end if;
                elsif btnr = '1' then
                    if index_speed < 7 then
                        index_speed <= index_speed + 1;
                        index_brght <= index_brght;
                    end if;
                elsif btnl = '1' then
                    if index_speed > 0 then
                        index_speed <= index_speed - 1;
                        index_brght <= index_brght;
                    end if;        
                end if;
            end if;
        end if;
    end process;
    
    brght <= std_logic_vector(to_unsigned(brightnes(index_brght), 8));
    speed <= std_logic_vector(to_unsigned(spd(index_speed), 8));               

end Behavioral;
