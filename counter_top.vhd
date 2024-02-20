----------------------------------------------------------------------------------
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_top is
  Port ( 
    btn,sw:in std_logic_vector(3 downto 0);
    clk: in std_logic;
    cnt: out std_logic_vector(3 downto 0));
end counter_top;

architecture Behavioral of counter_top is
    --Components used
    component debounce is
        Port (
            btn : in std_logic;
            clk: in std_logic;
            dbnc : out std_logic);
    end component;
    
    component fancy_counter is
        Port ( clk,clk_en, dir, en, ld, rst, updn : in std_logic;
             val : in std_logic_vector(3 downto 0);
             cnt : out std_logic_vector(3 downto 0));
    end component;
    
    component clock_div is
      Port ( clk : in std_logic;
             div : out std_logic);
    end component;


    signal rst, en, updn, ld, div: std_logic;
    
begin
    reset: debounce 
        port map(
            btn => btn(0),
            clk=>clk,
            dbnc => rst);
    enable: debounce 
        port map(
            btn => btn(1),
            clk=>clk,
            dbnc => en);

    updown: debounce 
        port map(
            btn => btn(2),
            clk=>clk,
            dbnc => updn);
            
    load: debounce 
        port map(
            btn => btn(3),
            clk=>clk,
            dbnc => ld);           

    clockdiv: clock_div
        port map(
            clk=> clk,
            div=>div);
    u6: fancy_counter
        port map(
            clk=>clk,
            clk_en=>div,
            dir=>sw(0),
            en=>en,
            ld=>ld,
            rst=>rst,
            updn=>updn,
            val=>sw,
            cnt=>cnt);

end Behavioral;
