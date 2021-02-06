----------------------------------------------------------------------------------
-- Company: Johns Hopkins University
-- Engineer: Casey Borror
-- 
-- Create Date: 02/02/2021 05:54:08 PM
-- Module Name: pc_32bit_top - rtl
-- Project Name: module02
-- Target Devices: Nexys-4 DDR Development Board
-- Tool Versions: Vivado 2020.2
-- Description: A 32-bit Program Counter with Load and Reset
-- 
-- Dependencies: N/A
-- 
-- Revision: 0.02
-- Revision 0.01 - File Created
-- Revision 0.02 - Added 32-bit Program Counter
-- 
----------------------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity pc_32bit_top is
 port (
    clk      : in std_logic;
    rst      : in std_logic;
    load     : in std_logic;
    pc_value : in unsigned (31 downto 0);
    pc_addr  : out unsigned (31 downto 0)
 );
end pc_32bit_top;

architecture rtl of pc_32bit_top is

    ------------------------------------
    -- Signals
    ------------------------------------
    signal pc : unsigned (31 downto 0); -- the current state of the program counter

begin

    process(clk) begin
        if(rst = '1') then
            pc <= (others => '0');
        elsif(rising_edge(clk)) then
            if(load = '1') then
                pc <= pc_value;
            else
                pc <= pc + 4;
            end if;
        end if; 
    end process;
    pc_addr <= pc;

end architecture rtl;