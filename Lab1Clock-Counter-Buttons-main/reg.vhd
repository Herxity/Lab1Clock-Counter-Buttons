----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2024 08:29:35 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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
entity reg is --- ENTITY
    Port ( REG_IN : in std_logic;
         CE,CLK : in std_logic;
         REG_OUT : out std_logic);
end reg;
architecture reg of reg is --- ARCHITECTURE
begin


    reg: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (CE = '1') then
                REG_OUT <= REG_IN;
            end if;
        end if;
    end process;
end reg;