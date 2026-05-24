-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity onebyte_tb is
end;

architecture bench of onebyte_tb is

  component onebyte
      Port ( Wr1 : in STD_LOGIC;
             Wr0 : in STD_LOGIC;
             Read : in STD_LOGIC;
             Rst : in STD_LOGIC;
             Clk : in STD_LOGIC;
             T : out STD_LOGIC;
             IOBuf_In : in STD_LOGIC;
             Busy : out STD_LOGIC;
             Read_Out : out STD_LOGIC);
  end component;

  signal Wr1: STD_LOGIC := '0';
  signal Wr0: STD_LOGIC := '0';
  signal Read: STD_LOGIC := '0';
  signal Rst: STD_LOGIC := '0';
  signal Clk: STD_LOGIC;
  signal T: STD_LOGIC;
  signal IOBuf_In: STD_LOGIC  := '0';
  signal Busy: STD_LOGIC;
  signal Read_Out: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: onebyte port map ( Wr1      => Wr1,
                          Wr0      => Wr0,
                          Read     => Read,
                          Rst      => Rst,
                          Clk      => Clk,
                          T        => T,
                          IOBuf_In => IOBuf_In,
                          Busy     => Busy,
                          Read_Out => Read_Out );

  stimulus: process
  begin

    -- Put initialisation code here

    
    -- Put test bench stimulus code here
    Read <= '0', '1' after 1000 ns, '0' after 1010 ns;
    IOBuf_In <= '1'; 

    
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;