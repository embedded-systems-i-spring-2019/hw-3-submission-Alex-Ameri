----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 12:27:53 AM
-- Design Name: 
-- Module Name: Question_5Q - Behavioral
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

entity Question_5Q is
    Port ( SL1, SL2, CLK : in STD_LOGIC;
           A, B, C : in STD_LOGIC_VECTOR (7 downto 0);
           RAX, RBX : out STD_LOGIC_VECTOR (7 downto 0));
end Question_5Q;

architecture Behavioral of Question_5Q is
    signal LDA_internal, LDB_internal : STD_LOGIC;
    signal REGB_input : STD_LOGIC_VECTOR (7 downto 0);
begin

    --Decoder
    decoder : process (SL1)
    begin
        if(SL1 = '1') then
            LDA_internal <= '1';
            LDB_internal <= '0';
        elsif (SL1 = '0') then
            LDA_internal <= '0';
            LDB_internal <= '1';
        else
            LDA_internal <= '0';
            LDB_internal <= '0';
        end if;
    end process;
        
    --Mux
    with SL2 select
        REGB_input <= C when '0',
                      B when '1',
                      (others => '0') when others;
                      
    --Register A
   reg_A : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA_internal = '1') then
                RAX <= A;
            end if;
        end if;
    end process;
    
   --Register B
    reg_B : process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDB_internal = '1') then
                RBX <= REGB_input;
            end if;
        end if;
    end process;


end Behavioral;
