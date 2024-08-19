
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity declaration
entity tb_fourbit_divider is
end tb_fourbit_divider;

--architecture declaration
architecture testbench of tb_fourbit_divider is
  signal dividend        :   std_logic_vector(3 downto 0);           
  signal divisor         :   std_logic_vector(3 downto 0);                                 
  signal quotient        :   std_logic_vector(3 downto 0);              
  signal remainder       :   std_logic_vector(3 downto 0);              
  signal clk             :   std_logic := '0'; 

  constant c_clk_period : time := 10 ns;

-- Procedure to apply test vectors
    procedure apply_test_vectors(
        signal dividend_in     : out std_logic_vector(3 downto 0);
        signal divisor_in     : out std_logic_vector(3 downto 0);
        constant dividend_value : in std_logic_vector(3 downto 0);
        constant divisor_value: in std_logic_vector(3 downto 0)
      ) is

      begin
        dividend_in <= dividend_value;
        divisor_in <= divisor_value;
        wait until rising_edge(clk); 
      end procedure apply_test_vectors;
    
  begin

-- Instantiate the DUT

  uut: entity work.BinaryDivision
    port map (
      dividend        => dividend ,
      divisor         => divisor ,
      quotient        => quotient ,
      remainder       => remainder

    );

-- Clock generation 
        clk <= not clk after c_clk_period;

-- Test process

  stim_proc: process
  begin
    -- Test case 1
    apply_test_vectors(dividend, divisor, "0000", "0000");

    -- Test case 1
    apply_test_vectors(dividend, divisor, "0011", "0011");

    -- Test case 1
    apply_test_vectors(dividend, divisor, "1011", "0011");

    -- Test case 1
    apply_test_vectors(dividend, divisor, "1111", "0011");

    -- Test case 1
    apply_test_vectors(dividend, divisor, "0001", "0011");

    -- Test case 1
    apply_test_vectors(dividend, divisor, "0111", "1100");


    wait;
  end process;
end testbench;