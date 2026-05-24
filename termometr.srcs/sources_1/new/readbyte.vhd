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

entity readbyte is
    Port ( hex : out STD_LOGIC_VECTOR (7 downto 0);
           start : in STD_LOGIC;
           busy : in STD_LOGIC;
           Clk : in STD_LOGIC;
           busyRD : out STD_LOGIC;
           outRD : out STD_LOGIC;
           read : in STD_LOGIC;
           read_ready : in STD_LOGIC);
end readbyte;

architecture Behavioral of readbyte is
    type state_type is (IDLE, B0, B1, B2, B3, B4, B5, B6, B7, R0, R1, R2, R3, R4, R5, R6, R7, Wait0, Wait1, Wait2, Wait3, Wait4, Wait5, Wait6, Wait7);
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
                if read_ready='1' then
                next_state <= R0;
                end if;
            when R0 =>
            next_state <= Wait0;
            when Wait0 =>
                if busy='0' then
                    next_state <= B1;
                end if;
                
             when B1 =>
                if read_ready='1' then
                next_state <= R1;
                end if;
            when R1 =>
            next_state <= Wait1;
            when Wait1 =>
                if busy='0' then
                    next_state <= B2;
                end if;
               
             when B2 =>
                if read_ready='1' then
                next_state <= R2;
                end if;
            when R2 =>
            next_state <= Wait2;
            when Wait2 =>
                if busy='0' then
                    next_state <= B3;
                end if;

            when B3 =>
                if read_ready='1' then
                next_state <= R3;
                end if;
            when R3 =>
            next_state <= Wait3;
            when Wait3 =>
                if busy='0' then
                    next_state <= B4;
                end if;            

        
            when B4 =>
                if read_ready='1' then
                next_state <= R4;
                end if;
            when R4 =>
            next_state <= Wait4;
            when Wait4 =>
                if busy='0' then
                    next_state <= B5;
                end if;
                
            when B5 =>
                if read_ready='1' then
                next_state <= R5;
                end if;
            when R5 =>
            next_state <= Wait5;
            when Wait5 =>
                if busy='0' then
                    next_state <= B6;
                end if;
 
             when B6 =>
                if read_ready='1' then
                next_state <= R6;
                end if;
            when R6 =>
            next_state <= Wait6;
            when Wait6 =>
                if busy='0' then
                    next_state <= B7;
                end if;               

            when B7 =>
                if read_ready='1' then
                next_state <= R7;
                end if;
            when R7 =>
            next_state <= Wait7;
            when Wait7 =>
                if busy='0' then
                    next_state <= IDLE;
                end if;                
            end case;
            
     end process process2;
     
     
    process3: process(state)
    begin 
        if state = IDLE then
            BusyRD <= '0';
        else
            BusyRD <= '1';
        end if;
    
        if state = B0 or state = B1 or state = B2 or state = B3 or state = B4 or state = B5 or state = B6 or state = B7 then
            outRD <= '1';
        else
            outRD <= '0';
        end if;
        if state = R0 then
            hex(0) <= read;
        end if;
        if state = R1 then
            hex(1) <= read;
        end if;
        if state = R2 then
            hex(2) <= read;
        end if;
        if state = R3 then
            hex(3) <= read;
        end if;
        if state = R4 then
            hex(4) <= read;
        end if;
        if state = R5 then
            hex(5) <= read;
        end if;
        if state = R6 then
            hex(6) <= read;
        end if;
        if state = R7 then
            hex(7) <= read;
        end if;
     end process process3;


end Behavioral;
