
library ieee;
use ieee.std_logic_1164.all;

--entity declaration
entity tb_fourbit_adder is
end tb_fourbit_adder;

--architecture declaration
architecture testbench of tb_fourbit_adder is
  signal A, B       : std_logic_vector(3 downto 0);
  signal SUM        : std_logic_vector(3 downto 0);
  signal CARRY_OUT  : std_logic;
  signal CARRY      : std_logic_vector(3 downto 0);
  signal clk        : std_logic := '0'; 

  constant c_clk_period : time := 10 ns;

-- Procedure to apply test vectors
    procedure apply_test_vectors(
        signal    A_in    : out std_logic_vector(3 downto 0);
        signal    B_in    : out std_logic_vector(3 downto 0);
        constant  A_value : in std_logic_vector(3 downto 0);
        constant  B_value : in std_logic_vector(3 downto 0)
      ) is

      begin
        A_in <= A_value;
        B_in <= B_value;
        wait until rising_edge(clk); 
      end procedure apply_test_vectors;
    
  begin

-- Instantiate the DUT

  uut: entity work.fourbit_adder
    port map (
      A         => A,
      B         => B,
      SUM       => SUM,
      CARRY_OUT => CARRY_OUT,
      CARRY     => CARRY
    );

-- Clock generation process
  clk <= not clk after c_clk_period;

-- Test process

  stim_proc: process
  begin
    -- Test case 1
    apply_test_vectors(A, B, "0000", "0000");
    
    -- Test case 2
    apply_test_vectors(A, B, "0001", "0001");
    
    -- Test case 3
    apply_test_vectors(A, B, "0010", "0011");
    
    -- Test case 4
    apply_test_vectors(A, B, "0101", "0110");
    
    -- Test case 5
    apply_test_vectors(A, B, "1111", "0001");
    
    -- Test case 6
    apply_test_vectors(A, B, "1111", "1111");
    -- Stop the simulation
    wait;
  end process;
end testbench;