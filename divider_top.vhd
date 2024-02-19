----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2024 08:21:31 PM
-- Design Name: 
-- Module Name: divider_top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider_top is
  Port (
    div: inout std_logic;
    clk: in std_logic );
end divider_top;

architecture Behavioral of divider_top is

    component clock_div is
      Port ( clk : in std_logic;
             div : out std_logic);
    end component clock_div;

    --signal
    signal divider_output : std_logic;
    signal CE : std_logic;
    
begin

    clo: clock_div
        port map(
            clk => clk,
            div => divider_output
     );
     
    process(CLK,divider_output )
    begin
        if (rising_edge(CLK)) then
            if (divider_output  = '1') then
                div <= not(div);
            end if;
        end if;
    end process;
    


end Behavioral;
