----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 12:30:08 AM
-- Design Name: 
-- Module Name: Question_3Q - Behavioral
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

entity Question_3Q is
    Port ( LDB : in STD_LOGIC;
           LDA : in STD_LOGIC;
           X, Y : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           S1 : in STD_LOGIC;
           S0 : in STD_LOGIC;
           RB : out STD_LOGIC_VECTOR (7 downto 0));
end Question_3Q;

architecture Behavioral of Question_3Q is
    signal mux1_result, mux2_result : STD_LOGIC_VECTOR (7 downto 0);
    signal RA_result, RB_result : STD_LOGIC_VECTOR (7 downto 0);
begin
    --tie things together
    RB <= RB_result;
    
    --mux1
    with S1 select
        mux1_result <= RB_result when '0',
                               X when '1',
                (others => '0') when others;
                  
    --Register A
    reg_A : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                RA_result <= mux1_result;
            end if;
        end if;
    end process;
    
    --mux2
    with S0 select
        mux1_result <= RA_result when '1',
                               Y when '0',
                (others => '0') when others;
    
   --Register B
    reg_B : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDB = '1') then
                RB_result <= RA_result;
            end if;
        end if;
    end process;    

end Behavioral;
