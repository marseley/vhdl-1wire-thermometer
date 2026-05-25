library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DS18S20_Controller is
    Port (
        clk         : in  STD_LOGIC;
        reset_n     : in  STD_LOGIC;
        start_meas  : in  STD_LOGIC;
        ow_reset    : out STD_LOGIC;
        ow_write_b  : out STD_LOGIC;
        ow_read_b   : out STD_LOGIC;
        ow_done     : in  STD_LOGIC;
        ow_data_tx  : out STD_LOGIC_VECTOR(7 downto 0);
        ow_data_rx  : in  STD_LOGIC_VECTOR(7 downto 0);
        presence_pulse : in  STD_LOGIC;
        temp_data   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end DS18S20_Controller;

architecture Behavioral of DS18S20_Controller is

    type state_type is (IDLE, SEND_RESET_1, SEND_RESET_3, SEND_RESET_4, SKIP_ROM_1, SKIP_ROM_3, SKIP_ROM_4, CONVERT_T, CONVERT_T_2,  WAIT_CONV, WAIT_CONV_2, 
                        SEND_RESET_2, SKIP_ROM_2, READ_SCRATCHPAD, READ_SCRATCHPAD_2, 
                        GET_BYTE_1, GET_BYTE_2, GET_BYTE_3, GET_BYTE_4, DONE_STATE);
    signal state, next_state : state_type;
    
    signal temp_reg  : STD_LOGIC_VECTOR(15 downto 0);

begin

    process1 : process(clk, reset_n)
    begin
        if reset_n = '1' then
            state <= IDLE;
            ow_reset <= '0';
            ow_write_b <= '0';
            ow_read_b <= '0';
        end if;
        if rising_edge(clk) then
            state <= next_state;
        end if;
     end process process1;
     
      process2 : process(state, start_meas, ow_done)
      begin
            next_state <= state;

            case state is
                
                when IDLE =>
                    if start_meas = '1' then
                        next_state <= SEND_RESET_1;
                    end if;

                when SEND_RESET_1 =>
                    ow_reset <= '1';
                    next_state <= SEND_RESET_2; 
                    
                when SEND_RESET_2 =>
                    ow_reset <= '0';
                    if ow_done = '0' then 
                       if  presence_pulse = '0' then 
                            next_state <= SKIP_ROM_1;
                       else
                            next_state<= IDLE;
                       end if;
                    end if;

                when SKIP_ROM_1 =>
                    ow_data_tx <= x"CC"; 
                    ow_write_b <= '1';
                    next_state <= SKIP_ROM_2;
                when SKIP_ROM_2 =>
                    ow_write_b <= '0';
                    if ow_done = '0' then next_state <= CONVERT_T; end if;
                when CONVERT_T =>
                    ow_data_tx <= x"44"; 
                    ow_write_b <= '1';
                    next_state <= CONVERT_T_2;
                    
                when CONVERT_T_2=>    
                    ow_write_b <= '0';
                    
                    if ow_done = '0' then 
                        next_state <= WAIT_CONV;
                    end if;

                when  WAIT_CONV=>
                    ow_read_b <= '1';
                    next_state <= WAIT_CONV_2;
              
                when  WAIT_CONV_2=>
                    ow_read_b <= '0';
                    if ow_done = '0' then
                        if ow_data_rx = x"00" then 
                            next_state <= WAIT_CONV;
                        else
                            next_state <= SEND_RESET_3;
                        end if;
                    end if;

                when SEND_RESET_3 =>
                    ow_reset <= '1';
                    next_state <= SEND_RESET_4; 
                when SEND_RESET_4 =>
                    ow_reset <= '0';
                    if ow_done = '0' then 
                       if  presence_pulse = '0' then 
                            next_state <= SKIP_ROM_3;
                       else
                            next_state<= IDLE;
                       end if;
                    end if;

                when SKIP_ROM_3 =>
                    ow_data_tx <= x"CC"; 
                    ow_write_b <= '1';
                    next_state <= SKIP_ROM_4;
                when SKIP_ROM_4 =>
                    ow_write_b <= '0';
                    if ow_done = '0' then next_state <= READ_SCRATCHPAD; end if;
                    
                when READ_SCRATCHPAD =>
                    ow_data_tx <= x"BE"; 
                    ow_write_b <= '1';
                    next_state <= READ_SCRATCHPAD_2;
                when READ_SCRATCHPAD_2 =>
                    ow_write_b <= '0';
                    if ow_done = '0' then next_state <= GET_BYTE_1; end if;

                when GET_BYTE_1 =>
                    ow_read_b <= '1';
                    next_state <= GET_BYTE_2;

                when GET_BYTE_2 =>
                    ow_read_b <= '0';
                    if ow_done = '0' then
                        temp_reg(7 downto 0) <= ow_data_rx;
                        next_state <= GET_BYTE_3;
                    end if;
                when GET_BYTE_3 =>
                    ow_read_b <= '1';
                        next_state <= GET_BYTE_4;
                when GET_BYTE_4 =>
                    ow_read_b <= '0';
                    if ow_done = '0' then
                        temp_reg(15 downto 8) <= ow_data_rx;
                        next_state <= DONE_STATE;
                    end if;

                when DONE_STATE =>
                    temp_data <= temp_reg;
                    next_state <= IDLE;
            end case;
    end process process2;

end Behavioral;
