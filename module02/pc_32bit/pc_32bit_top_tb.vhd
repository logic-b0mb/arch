----------------------------------------------------------------------------------
-- Company: Johns Hopkins University
-- Engineer: Casey Borror
-- 
-- Create Date: 02/02/2021 05:54:08 PM
-- Module Name: pc_32bit_top_tb - tb
-- Project Name: module02
-- Target Devices: Nexys-4 DDR Development Board
-- Tool Versions: Vivado 2020.2
-- Description: A testbench for the 32-bit Program Counter with Load and Reset
-- 
-- Dependencies: N/A
-- 
-- Revision: 0.02
-- Revision 0.01 - File Created
-- Revision 0.02 - Added testbench code
-- 
----------------------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity tb_pc_32bit_top is
end tb_pc_32bit_top;

architecture tb of tb_pc_32bit_top is

    component pc_32bit_top
     port (
        clk      : in std_logic;
        rst      : in std_logic;
        load     : in std_logic;
        pc_value : in unsigned (31 downto 0);
        pc_addr  : out unsigned (31 downto 0)
     );
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal load     : std_logic;
    signal pc_value : unsigned (31 downto 0);
    signal pc_addr  : unsigned (31 downto 0);

    constant tb_period : time := 10 ns; -- EDIT Put right period here
    signal tb_clock : std_logic := '0';
    signal tb_sim_ended : std_logic := '0';

begin

    dut : pc_32bit_top
    port map (clk      => clk,
              rst      => rst,
              load     => load,
              pc_value => pc_value,
              pc_addr  => pc_addr);

    -- Clock generation
    tb_clock <= not tb_clock after tb_period/2 when tb_sim_ended /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= tb_clock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        load <= '0';
        pc_value <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';

        -- EDIT Add stimuli here
        wait for 10 * tb_period;
        pc_value <= x"00008000";
        load <= '1';
        wait for tb_period;
        load <= '0';
        
        wait for 10 * tb_period;
        pc_value <= x"00004000";
        load <= '1';
        wait for tb_period;
        load <= '0';
        
        wait for 10 * tb_period;
        pc_value <= x"80000000";
        load <= '1';
        wait for tb_period;
        load <= '0';
        wait for 10 * tb_period;

        -- Stop the clock and hence terminate the simulation
        tb_sim_ended <= '1';
        wait;
    end process;

end tb;