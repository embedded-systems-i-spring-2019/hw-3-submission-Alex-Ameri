----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 12:30:08 AM
-- Design Name: 
-- Module Name: Question_1Q - Behavioral
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

entity Question_1Q is
      Port ( SEL : in STD_LOGIC;
           CLK : in STD_LOGIC;
           LDA : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           F : out STD_LOGIC_VECTOR (7 downto 0));
end Question_1Q;

architecture Behavioral of Question_1Q is
    signal mux_result : STD_LOGIC_VECTOR (7 downto 0);
begin
    
    --MUX
    with SEL select
        mux_result <= A when '0',
                      B when '1',
                      (others => '0') when others;
    
    -- REGISTER                  
    reg : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                F <= mux_result;
            end if;
        end if;
    end process;
    
end Behavioral;
