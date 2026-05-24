----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2026 08:37:18
-- Design Name: 
-- Module Name: onebyte - Behavioral
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity onebyte is
    Port ( Wr1 : in STD_LOGIC;
           Wr0 : in STD_LOGIC;
           Read : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           TT : out STD_LOGIC;
           IOBuf_In : in STD_LOGIC;
           Busy : out STD_LOGIC;
           Read_Out : out STD_LOGIC := '0';
           Read_Ready : out STD_LOGIC);
end onebyte;

architecture Behavioral of onebyte is
--signal interBusy: STD_LOGIC := '0';
signal counter: UNSIGNED(17 downto 0) := (others => '0');

type state_type is (IDLE, WR1_A, WR1_B, WR0_A, WR0_B, RD_A, RD_B, RD_C, RD_D, RST_A, RST_B, RST_C, RST_D);
signal state, next_state : state_type := IDLE;

begin
    
    process1 : process(clk)
    begin
        if rising_edge(clk) then
            state <= next_state;
        end if;
    end process process1;
    
    process2 : process(state, Wr1, Wr0, Read, Rst, counter)
    begin
        next_state <= state;
        
        case state is
            when IDLE =>
                if Rst = '1' then
                    next_state <= RST_A;
                elsif Wr1 = '1' then
                    next_state <= WR1_A;
                elsif Wr0 = '1' then
                    next_state <= WR0_A;
                elsif Read = '1' then
                    next_state <= RD_A;
                end if;
            when RST_A =>
                if counter = 48000 then
                    next_state <= RST_B;
                end if;
            when RST_B =>
                if counter = 55000 then
                    next_state <= RST_C;
                end if;
            when RST_C =>
                next_state <= RST_D;
            when RST_D =>
                if counter = 96000 then
                    next_state <= IDLE;
                end if;          
                
            when WR1_A =>
                if counter = 600 then
                    next_state <= WR1_B;
                end if;
            when WR1_B =>
                if counter = 7000 then
                    next_state <= IDLE;
                end if;
                
            when WR0_A =>
                if counter = 6000 then
                    next_state <= WR0_B;
                end if;
            when WR0_B =>
                if counter = 7000 then
                    next_state <= IDLE;
                end if;
                
             when RD_A =>
                if counter = 600 then
                    next_state <= RD_B;
                end if;
            when RD_B =>
                if counter = 1500 then
                    next_state <= RD_C;
                end if;
            when RD_C =>
                next_state <= RD_D;
            when RD_D =>
                if counter = 7000 then
                    next_state <= IDLE;
                end if;        

        end case;
    end process process2;
    
    process3: process(state)
    begin 
        if state = IDLE then
            Busy <= '0';
        else
            Busy <= '1';
        end if;
        
        if state = WR1_A or state = WR0_A or state = RST_A or state = RD_A then
            TT <= '0';
        else
            TT <= '1';
        end if;
                                
    end process process3;
    
    
    process4: process(clk, state)
    begin 
        if rising_edge(clk) then
            if state = RD_C or state = RST_C then
                Read_Out <= IOBuf_In;
                Read_Ready <= '1';
            else Read_Ready<='0';
            end if;
        end if;
    end process process4;
    
       
    CounterLoop: process(clk)
    begin
        if rising_edge(clk) then
            if state = IDLE then
                counter <= (others => '0');
            else
                counter <= counter + x"1";
            end if;
        end if;
    
    end process;


end Behavioral;
