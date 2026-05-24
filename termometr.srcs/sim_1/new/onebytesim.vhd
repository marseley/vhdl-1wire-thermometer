
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity test_writeByte_wrapper_tb is
end;

architecture bench of test_writeByte_wrapper_tb is

  component test_writeByte_wrapper
    port (
      Clk : in STD_LOGIC;
      IOBuf_In : in STD_LOGIC;
      Read : in STD_LOGIC;
      Read_Out : out STD_LOGIC;
      Rst : in STD_LOGIC;
      TT : out STD_LOGIC;
      hex : in STD_LOGIC_VECTOR ( 7 downto 0 );
      start : in STD_LOGIC
    );
  end component;

  signal Clk: STD_LOGIC;
  signal IOBuf_In: STD_LOGIC := '0';
  signal Read: STD_LOGIC := '0';
  signal Read_Out: STD_LOGIC;
  signal Rst: STD_LOGIC := '0';
  signal TT: STD_LOGIC;
  signal hex: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal start: STD_LOGIC ;
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: test_writeByte_wrapper port map ( Clk      => Clk,
                                         IOBuf_In => IOBuf_In,
                                         Read     => Read,
                                         Read_Out => Read_Out,
                                         Rst      => Rst,
                                         TT       => TT,
                                         hex      => hex,
                                         start    => start );

  stimulus: process
  begin

    hex <= "11001100";
    
    start <= '0','1' after 10 ns, '0' after 20 ns;
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
  