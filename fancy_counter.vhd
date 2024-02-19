-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2024 06:42:46 PM
-- Design Name: 
-- Module Name: counter_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fancy_counter is
    Port ( clk,clk_en, dir, en, ld, rst, updn : in std_logic;
         val : in std_logic_vector(3 downto 0);
         cnt : out std_logic_vector(3 downto 0));
end fancy_counter;

architecture Behavioral of fancy_counter is

    --signal
    signal direction_register_output : std_logic;
    signal value_register_output : std_logic_vector(3 downto 0);
    signal cnt_val : std_logic_vector(3 downto 0) := (others=>'0');
begin

    direction: process(CLK)
    begin
        if (rising_edge(CLK) and en='1' and clk_en = '1') then
            if (ld = '1') then
                value_register_output <= val;
            end if;
        end if;
    end process;
    
    update_cnt: process(cnt_val)
    begin
        cnt <= cnt_val;
    end process;
    
    value: process(CLK)
    begin
        if (rising_edge(CLK) and en = '1'and clk_en = '1') then
            if (updn = '1') then
                direction_register_output <= dir;
            end if;
        end if;
    end process;

    counter: process(clk)
    begin
        if(en='1' and rising_edge(clk)) then
            if(clk_en = '1') then
                if(direction_register_output='1') then
                    cnt_val <= std_logic_vector(unsigned(cnt_val) + 1);
                    if(cnt_val = value_register_output) then
                        cnt_val <= "0000";
                    end if;
                elsif(direction_register_output = '0') then
                    if (cnt_val="0000") then
                        cnt_val <= value_register_output;
                    else
                        cnt_val <= std_logic_vector(unsigned(cnt_val) - 1);
                    end if;
                end if;


            else
                if(rst = '1') then
                    cnt_val <= "0000"; --Reset count
                end if;
            end if;
        end if;

    end process;

end Behavioral;