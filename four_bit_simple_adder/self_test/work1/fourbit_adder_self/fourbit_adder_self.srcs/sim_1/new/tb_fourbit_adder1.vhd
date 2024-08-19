
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fourbit_adder is
end tb_fourbit_adder;

architecture sim of tb_fourbit_adder is

  -- Component declaration for the Unit Under Test (UUT)
  component fourbit_adder is
    port (
      A, B          : in  std_logic_vector(3 downto 0);
      SUM           : out std_logic_vector(3 downto 0);
      CARRY_OUT     : out std_logic;
      CARRY         : out std_logic_vector(3 downto 0)
    );
  end component;

  -- Signals to connect to the UUT
  signal A, B        : std_logic_vector(3 downto 0) := (others => '0');
  signal SUM         : std_logic_vector(3 downto 0);
  signal CARRY_OUT   : std_logic;
  signal CARRY       : std_logic_vector(3 downto 0);

  -- Expected results
  signal expected_sum       : std_logic_vector(3 downto 0);
  signal expected_carry_out : std_logic;
  signal expected_carry     : std_logic_vector(3 downto 0);

  -- Procedure to apply test vectors
  procedure apply_test_vectors(
    signal    A_in        : out std_logic_vector(3 downto 0);
    signal    B_in        : out std_logic_vector(3 downto 0);
    signal    CARRY_OUT   : in std_logic;
    signal    CARRY       : in std_logic_vector(3 downto 0);
    signal    sum         : in std_logic_vector(3 downto 0);
    -- signal    clk         : in std_logic;

    constant  A_value : in std_logic_vector(3 downto 0);
    constant  B_value : in std_logic_vector(3 downto 0);
    constant  expected_sum_value : in std_logic_vector(3 downto 0);
    constant  expected_carry_value : in std_logic_vector(3 downto 0);
    constant  expected_carryout_value : in std_logic
  ) is

  begin
    A_in <= A_value;
    B_in <= B_value;
    wait for 10 ns;
    -- wait until rising_edge(clk); 
    if(sum = expected_sum_value and CARRY_OUT = expected_carryout_value and CARRY = expected_carry_value) then
      report " Test Failed! " severity error;
    else 
      report " Test Passed! " severity note;
    end if;
    -- wait until rising_edge(clk);
    wait for 10 ns;
  end procedure apply_test_vectors;

begin

-- Instantiate the DUT

-- begin
  -- Instantiate the Unit Under Test (UUT)
  uut: fourbit_adder
    port map (
      A => A,
      B => B,
      SUM => SUM,
      CARRY_OUT => CARRY_OUT,
      CARRY => CARRY
    );

  -- Stimulus process to apply test vectors and check results
  stim_proc: process
  begin

  -- Test Case 1
    apply_test_vectors(A, B, CARRY_OUT, CARRY, SUM, "0000", "0000", "0000", "0000", '0');
    apply_test_vectors(A, B, CARRY_OUT, CARRY, SUM, "0011", "0010", "0100", "0101", '0');
    apply_test_vectors(A, B, CARRY_OUT, CARRY, SUM, "1010", "1000", "0000", "0010", '1');

    -- -- Test Case 1
    -- A <= "0001"; B <= "0001";
    -- expected_sum <= "0010"; expected_carry_out <= '0'; expected_carry <= "0000";
    -- wait for 10 ns;
    -- assert (SUM = expected_sum and CARRY_OUT = expected_carry_out and CARRY = expected_carry)
    --   report "Test Case 1 Failed!" severity error;

    -- -- Test Case 2
    -- A <= "0110"; B <= "0111";
    -- expected_sum <= "1101"; expected_carry_out <= '0'; expected_carry <= "0011";
    -- wait for 10 ns;
    -- assert (SUM = expected_sum and CARRY_OUT = expected_carry_out and CARRY = expected_carry)
    --   report "Test Case 2 Failed!" severity error;

    -- -- Test Case 3
    -- A <= "1111"; B <= "1111";
    -- expected_sum <= "1110"; expected_carry_out <= '1'; expected_carry <= "0111";
    -- wait for 10 ns;
    -- assert (SUM = expected_sum and CARRY_OUT = expected_carry_out and CARRY = expected_carry)
    --   report "Test Case 3 Failed!" severity error;

    -- End of the simulation
    wait;
  end process;

end sim;



