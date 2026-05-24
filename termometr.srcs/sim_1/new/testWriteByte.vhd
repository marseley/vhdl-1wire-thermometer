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
      Read_0 : in STD_LOGIC;
      Read_Out_0 : out STD_LOGIC;
      Rst_0 : in STD_LOGIC;
      hex_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
      start_0 : in STD_LOGIC
    );
  end component;

  signal Clk_0: STD_LOGIC;
  signal IOBUF_IO_IO_0: STD_LOGIC_VECTOR ( 0 to 0 );
  signal Read_0: STD_LOGIC;
  signal Read_Out_0: STD_LOGIC;
  signal Rst_0: STD_LOGIC;
  signal hex_0: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal start_0: STD_LOGIC ;
    
  constant CLK_PERIOD: time:= 10 ns;
begin

  uut: design_1_wrapper port map ( Clk_0         => Clk_0,
                                   IOBUF_IO_IO_0 => IOBUF_IO_IO_0,
                                   Read_0        => Read_0,
                                   Read_Out_0    => Read_Out_0,
                                   Rst_0         => Rst_0,
                                   hex_0         => hex_0,
                                   start_0       => start_0 );

  stimulus: process
  begin
  start_0<='1';
  hex_0<="00011101";
  
  wait;
  end process;

clk_process : process
begin
Clk_0 <= '0';
wait for CLK_PERIOD / 2;
Clk_0 <= '1';
wait for CLK_PERIOD / 2;
end process;

end;