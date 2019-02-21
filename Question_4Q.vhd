----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 12:30:08 AM
-- Design Name: 
-- Module Name: Question_4Q - Behavioral
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

entity Question_4Q is
    Port ( LDB : in STD_LOGIC;
           X, Y : in STD_LOGIC_VECTOR (7 downto 0);
           S1, LDA, RD, S0, CLK : in STD_LOGIC;
           RB, RA : out STD_LOGIC_VECTOR (7 downto 0));
end Question_4Q;

architecture Behavioral of Question_4Q is
    signal reg_b_input : STD_LOGIC_VECTOR (7 downto 0);
    signal reg_b_result : STD_LOGIC_VECTOR (7 downto 0);
    signal reg_a_input : STD_LOGIC_VECTOR (7 downto 0);
    signal LDA_internal, LDB_internal : STD_LOGIC;
begin

    --tie things together first
    LDB_internal <= LDB and (not RD);
    LDA_internal <= LDA and RD;
    RB <= reg_b_result;

    --XY MUX
    with S1 select
        reg_b_input <= Y when '0',
                       X when '1',
                       (others => '0') when others;
                       
    --REGA input mux
    with S0 select
        reg_a_input <= Y when '0',
                       reg_b_result when '1',
                       (others => '0') when others;
                       
   --Register A
   reg_A : process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (LDA_internal = '1') then
                RA <= reg_a_input;
            end if;
        end if;
    end process;
    
   --Register B
    reg_B : process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (LDB_internal = '1') then
                reg_b_result <= reg_b_input;
            end if;
        end if;
    end process;

end Behavioral;
