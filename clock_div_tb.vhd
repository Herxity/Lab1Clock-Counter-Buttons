--
-- filename:    blinker_tb.vhd
-- written by:  steve dinicolantonio
-- description: testbench for blinker.vhd
-- notes:       
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_div_tb is
end clock_div_tb;

architecture testbench of clock_div_tb is

    signal tb_clk : std_logic := '0';
    signal tb_button : std_logic;
    signal tb_dbnc  : std_logic;
    signal tb_div : std_logic;

    component clock_div is
        port(

            clk  : in std_logic;        -- 125 Mhz clock            
            div : out std_logic        -- led, '1' = on

        );
    end component;

    component debounce is
        Port (
            btn : in std_logic;
            clk: in std_logic;
            dbnc : out std_logic);
    end component;

begin

    --------------------------------------------------------------------------------
    -- procs
    --------------------------------------------------------------------------------

    -- simulate a 125 Mhz clock
    clk_gen_proc: process
    begin

        wait for 4 ns;
        tb_clk <= '1';

        wait for 4 ns;
        tb_clk <= '0';

    end process clk_gen_proc;

    -- simulate a 125 Mhz clock
    button_presser: process
    begin

        wait for 50 ms;
        tb_button <= '1';

        wait for 50 ms;
        tb_button <= '0';

    end process button_presser;


    --------------------------------------------------------------------------------
    -- port mapping
    --------------------------------------------------------------------------------

    dut : clock_div
        port map (

            clk  => tb_clk,
            div => tb_div

        );

    dbncer : debounce
        port map (

            clk  => tb_clk,
            btn => tb_button,
            dbnc => tb_dbnc

        );


end testbench; 