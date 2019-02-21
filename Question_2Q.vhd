----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 12:30:08 AM
-- Design Name: 
-- Module Name: Question_2Q - Behavioral
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

entity Question_2Q is
    Port ( DS : in STD_LOGIC;
           X, Y, Z : in STD_LOGIC_VECTOR (7 downto 0);
           MS : in STD_LOGIC_VECTOR (1 downto 0);
           CLK : in STD_LOGIC;
           RB : out STD_LOGIC_VECTOR (7 downto 0);
           RA : out STD_LOGIC_VECTOR (7 downto 0));
end Question_2Q;

architecture Behavioral of Question_2Q is
    signal mux_result : STD_LOGIC_VECTOR (7 downto 0);
    signal RA_result, RB_result : STD_LOGIC_VECTOR (7 downto 0);
    signal LDA, LDB : STD_LOGIC;
begin

    --Tie things together first
    RB <= RB_result;
    RA <= RA_result;

    --mux
    with MS select
        mux_result <= RB_result when "00",
                              Z when "01",
                              Y when "10",
                              X when "11",
                (others => '0') when others;
                  
    --Register A
    reg_A : process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (LDA = '1') then
                RA_result <= mux_result;
            end if;
        end if;
    end process;
    
   --Register B
    reg_B : process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (LDB = '1') then
                RB_result <= RA_result;
            end if;
        end if;
    end process;
    
    --Decoder
    decoder : process(DS)
    begin
        if (DS = '0') then
            LDA <= '1';
            LDB <= '0';
        elsif (DS = '1') then
            LDA <= '0';
            LDB <= '1';
        else
            LDA <= '0';
            LDB <= '0';
        end if;
    end process;  

end Behavioral;
