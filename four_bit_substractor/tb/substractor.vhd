
library ieee;
use ieee.std_logic_1164.all;

--entity declaration
entity tb_fourbit_substractor is
end tb_fourbit_substractor;

--architecture declaration
architecture testbench of tb_fourbit_substractor is
  signal a,b      : std_logic_vector(3 downto 0);
  signal difference       : std_logic_vector(3 downto 0);
  signal borrow      : std_logic_vector(3 downto 0);
  signal clk        : std_logic := '0'; 

  constant c_clk_period : time := 10 ns;

-- Procedure to apply test vectors
    procedure apply_test_vectors(
        signal a_in      : out std_logic_vector(3 downto 0);
        signal b_in      : out std_logic_vector(3 downto 0);
        constant a_value : in std_logic_vector(3 downto 0);
        constant b_value : in std_logic_vector(3 downto 0)
      ) is

      begin
        a_in <= a_value;
        b_in <= b_value;
        wait until rising_edge(clk); 
      end procedure apply_test_vectors;
    
  begin

-- Instantiate the DUT

  uut: entity work.fourbit_substractor
    port map (
      a         => a,
      b         => B,
      difference       => difference,
      borrow     => borrow
    );

-- Clock generation 
        clk <= not clk after c_clk_period;

-- Test process

  stim_proc: process
  begin
    -- Test case 1
    apply_test_vectors(a, b, "0000", "0000");
    
    -- Test case 2
    apply_test_vectors(a, b, "0001", "0001");
    
    -- Test case 3
    apply_test_vectors(a, b, "0010", "0011");
    
    -- Test case 4
    apply_test_vectors(a, b, "0101", "0110");
    
    -- Test case 5
    apply_test_vectors(A, B, "1111", "0001");
    
    -- Test case 6
    apply_test_vectors(a, b, "1111", "1111");
    
    -- Stop the simulation
    wait;
  end process;
end testbench;