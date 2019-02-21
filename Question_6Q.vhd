----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 12:30:08 AM
-- Design Name: 
-- Module Name: Question_6Q - Behavioral
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

entity Question_6Q is
    Port ( SEL1, SEL2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           A, B, C : in STD_LOGIC_VECTOR (7 downto 0);
           RAP, RBP : out STD_LOGIC_VECTOR (7 downto 0));
end Question_6Q;

architecture Behavioral of Question_6Q is
    signal LDA_internal, LDB_internal : STD_LOGIC;
    signal REGA_input : STD_LOGIC_VECTOR (7 downto 0);
begin

 --Decoder
    decoder : process (SEL2)
    begin
        if(SEL2 = '1') then
            LDA_internal <= '1';
            LDB_internal <= '0';
        elsif (SEL2 = '0') then
            LDA_internal <= '0';
            LDB_internal <= '1';
        else
            LDA_internal <= '0';
            LDB_internal <= '0';
        end if;
    end process;
        
    --Mux
    with SEL1 select
        REGA_input <= B when '0',
                      A when '1',
                      (others => '0') when others;
                      
    --Register A
   reg_A : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA_internal = '1') then
                RAP <= REGA_input;
            end if;
        end if;
    end process;
    
   --Register B
    reg_B : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDB_internal = '1') then
                RBP <= C;
            end if;
        end if;
    end process;

end Behavioral;
