-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity design_1_wrapper_tb is
end;

architecture bench of design_1_wrapper_tb is

  component design_1_wrapper
    port (
      Clk_0 : in STD_LOGIC;
      IOBUF_IO_IO_0 : inout STD_LOGIC_VECTOR ( 0 to 0 );
      reset_n_0 : in STD_LOGIC;
      start_meas_0 : in STD_LOGIC;
      temp_data_0 : out STD_LOGIC_VECTOR ( 15 downto 0 )
    );
  end component;

  signal Clk_0: STD_LOGIC;
  signal IOBUF_IO_IO_0: STD_LOGIC_VECTOR ( 0 to 0 );
  signal reset_n_0: STD_LOGIC;
  signal start_meas_0: STD_LOGIC;
  signal temp_data_0: STD_LOGIC_VECTOR ( 15 downto 0 ) ;

begin

  uut: design_1_wrapper port map ( Clk_0         => Clk_0,
                                   IOBUF_IO_IO_0 => IOBUF_IO_IO_0,
                                   reset_n_0     => reset_n_0,
                                   start_meas_0  => start_meas_0,
                                   temp_data_0   => temp_data_0 );

  stimulus: process
  begin

    reset_n_0 <= '1' ;
    reset_n_0 <= '0' after 20us;
    start_meas_0 <= '1' after 100 us;
    IOBUF_IO_IO_0(0) <= '0' after 2180 us;
    IOBUF_IO_IO_0(0) <= 'Z' after 3400 us;

    

    wait;
  end process;
  
     IOBUF_IO_IO_0(0) <= 'H';

   process
   begin
      IOBUF_IO_IO_0(0) <= 'Z';
      loop
         wait until  IOBUF_IO_IO_0(0)'Delayed'Last_event > 450 us  and  IOBUF_IO_IO_0(0)'Last_value = '0';
         IOBUF_IO_IO_0(0) <= '0' after 10 us, 'Z' after 310 us;
      end loop;
   end process;
  clk_process : process
  begin
    clk_0 <= '0';
    wait for 5 ns;
    clk_0 <='1';
    wait for 5 ns;
  end process;


end;