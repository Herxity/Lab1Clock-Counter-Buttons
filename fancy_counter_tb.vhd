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

entity fancy_counter_tb is
end fancy_counter_tb;

architecture testbench of fancy_counter_tb is

    signal tb_clk : std_logic := '0';
    signal tb_clk_en : std_logic;
    signal tb_dir  : std_logic;
    signal tb_en : std_logic;
    signal tb_ld : std_logic;
    signal tb_rst : std_logic;
    signal tb_updn : std_logic;
    
    signal tb_val : std_logic_vector(3 downto 0);
    signal tb_cnt : std_logic_vector(3 downto 0);

    component fancy_counter is
        Port ( clk,clk_en, dir, en, ld, rst, updn : in std_logic;
         val : in std_logic_vector(3 downto 0);
         cnt : out std_logic_vector(3 downto 0));
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

    clk_en_process: process
        begin
            tb_clk_en <='1';
            tb_en <='1';
            wait for 8 ns;
            tb_clk_en <= '0';
            wait for 3 ns;
            tb_en <='0';
            
            wait for 2 ns;
            tb_clk_en <= '1';
            tb_en <= '1';
    end process clk_en_process;
    
    rst_proc: process
        begin
            tb_rst <= '0';
            wait for 10 ns;
            --tb_rst <= '1';
    
            wait for 3 ns;
            tb_rst <= '0';
    
    end process rst_proc;

    signals_process: process
    begin
            tb_updn <= '1';
            tb_dir<= '1';
            tb_val <= "0111";
            tb_ld <='1';
            wait for 10 ns;
            tb_dir<= '0';
            tb_val <= "1000";
            tb_ld <='1';
            
    end process signals_process;
    
    --------------------------------------------------------------------------------
    -- port mapping
    --------------------------------------------------------------------------------

    dut : fancy_counter
        port map(

            clk  => tb_clk,
            en => tb_en,
            clk_en=>tb_clk_en,
            dir=>tb_dir,
            ld=>tb_ld,
            rst=>tb_rst,
            updn=>tb_updn,
            val=> tb_val,
            cnt=>tb_cnt
        );



end testbench; 