----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2026 08:56:12
-- Design Name: 
-- Module Name: writeByte - Behavioral
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

entity writeByte is
    Port ( hex : in STD_LOGIC_VECTOR (7 downto 0);
           start : in STD_LOGIC;
           busy : in STD_LOGIC;
           Clk : in STD_LOGIC;
           busyWR : out STD_LOGIC;
           out1 : out STD_LOGIC;
           out0 : out STD_LOGIC);
end writeByte;

architecture Behavioral of writeByte is
    type state_type is (IDLE, B0, B1, B2, B3, B4, B5, B6, B7, W0, W1, W2, W3, W4, W5, W6, W7);
    signal state, next_state : state_type := IDLE;
begin
    process1 : process(clk)
    begin
        if rising_edge(clk) then
            state <= next_state;
        end if;
    end process process1;
    
    process2 : process(state, start, busy)
    begin
         next_state <= state;
        
        case state is
            when IDLE =>
                if start = '1' then
                    next_state <= B0;
                end if;
            when B0 =>
                next_state <= W0;
            when W0 =>
                if busy = '0' then
                    next_state <= B1;
                end if;
                
            when B1 =>
                next_state <= W1;
            when W1 =>
                if busy = '0' then
                    next_state <= B2;
                end if;
                
            when B2 =>
                next_state <= W2;
            when W2 =>
                if busy = '0' then
                    next_state <= B3;
                end if;
            
            when B3 =>
                next_state <= W3;
            when W3 =>
                if busy = '0' then
                    next_state <= B4;
                end if;
                
           when B4 =>
                next_state <= W4;
            when W4 =>
                if busy = '0' then
                    next_state <= B5;
                end if;
           
           when B5 =>
                next_state <= W5;
            when W5 =>
                if busy = '0' then
                    next_state <= B6;
                end if;
                
           when B6 =>
                next_state <= W6;
            when W6 =>
                if busy = '0' then
                    next_state <= B7;
                end if;
                
           when B7 =>
                next_state <= W7;
            when W7 =>
                if busy = '0' then
                    next_state <= IDLE;
                end if;
                    
                
        end case;
     end process process2;
     
     
    process3: process(state)
    begin 
        if state = IDLE then
            BusyWR <= '0';
        else
            BusyWR <= '1';
        end if;
        
        if state = B0 and hex(0) = '0' then
            Out0 <= '1';
        elsif state = B0 and hex(0) = '1' then
            Out1 <= '1';
            
        elsif state = B1 and hex(1) = '0' then
            Out0 <= '1';
        elsif state = B1 and hex(1) = '1' then
            Out1 <= '1'; 
            
        elsif state = B2 and hex(2) = '0' then
            Out0 <= '1';
        elsif state = B2 and hex(2) = '1' then
            Out1 <= '1';    
            
        elsif state = B3 and hex(3) = '0' then
            Out0 <= '1';
        elsif state = B3 and hex(3) = '1' then
            Out1 <= '1'; 
            
        elsif state = B4 and hex(4) = '0' then
            Out0 <= '1';
        elsif state = B4 and hex(4) = '1' then
            Out1 <= '1'; 
            
        elsif state = B5 and hex(5) = '0' then
            Out0 <= '1';
        elsif state = B5 and hex(5) = '1' then
            Out1 <= '1'; 
            
        elsif state = B6 and hex(6) = '0' then
            Out0 <= '1';
        elsif state = B6 and hex(6) = '1' then
            Out1 <= '1'; 
        
        elsif state = B7 and hex(7) = '0' then
            Out0 <= '1';
        elsif state = B7 and hex(7) = '1' then
            Out1 <= '1'; 
            
        else
            Out0 <= '0';
            Out1 <= '0';
        end if;
    
    
    
     end process process3;


end Behavioral;
