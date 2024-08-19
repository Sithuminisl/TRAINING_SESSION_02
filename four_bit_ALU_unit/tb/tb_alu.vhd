library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity declaration
entity tb_alu is
end tb_alu;

--architecture declaration
architecture testbench of tb_alu is
    
    signal a,b                                : std_logic_vector(3 downto 0);
    signal operation                          : std_logic_vector(2 downto 0);
    signal result                             : std_logic_vector(3 downto 0);
    signal carry_out                          : std_logic; 
    signal carry                              : std_logic_vector(3 downto 0);
    signal remainder                          : std_logic_vector(3 downto 0);
    signal borrow_out                         : std_logic;
    signal borrow                             : std_logic_vector(3 downto 0);
    signal clk                                : std_logic := '0';
  
    constant c_clk_period                     : time := 10 ns;

    -- Procedure to apply test vectors
    procedure apply_test_vectors(
        signal a_in                           : out std_logic_vector(3 downto 0);
        signal b_in                           : out std_logic_vector(3 downto 0);
        signal operation_in                   : out std_logic_vector(2 downto 0);
        constant a_value                      : in std_logic_vector(3 downto 0);
        constant b_value                      : in std_logic_vector(3 downto 0);
        constant operation_value              : in std_logic_vector(2 downto 0)
      ) is

      begin
        a_in                                  <= a_value;
        b_in                                  <= b_value;
        operation_in                          <= operation_value;

        wait until rising_edge(clk); 
        
      end procedure apply_test_vectors;
    
  begin
    uut: entity work.alu
    port map (
        a                                     => a,
        b                                     => b,
        operation                             => operation,
        result                                => result,
        carry_out                             => carry_out,
        carry                                 => carry,
        remainder                             => remainder,
        borrow_out                            => borrow_out,
        borrow                                => borrow
    );

-- Clock generation 

        clk                                  <= not clk after c_clk_period;

    -- Test process

  stim_proc: process
  begin
        
        
        -- Test case 1: AND operation (operation = "000")
        apply_test_vectors (a, b, operation, "1101", "1010", "000");
        wait until rising_edge(clk);
        
        -- Test case 2: OR operation (operation = "001")
        apply_test_vectors (a, b, operation, "1101", "1010", "001");
        wait until rising_edge(clk);
        
        -- Test case 3: XOR operation (operation = "010")
        apply_test_vectors (a, b, operation, "1101", "1010", "010");
        wait until rising_edge(clk);
        
        -- Test case 4: NOT operation (operation = "011")
        apply_test_vectors (a, b, operation, "1101", "1010", "011");
        wait until rising_edge(clk);
        
        -- Test case 5: Addition operation (operation = "100")
        apply_test_vectors (a, b, operation, "1101", "1010", "100");
        wait until rising_edge(clk);
        
        -- Test case 6: Subtraction operation (operation = "101")
        apply_test_vectors (a, b, operation, "1101", "1010", "101");
        wait until rising_edge(clk);
        
        -- Test case 7: Multiplication operation (operation = "110")
        apply_test_vectors (a, b, operation, "1101", "1010", "110");
        wait until rising_edge(clk);
        
        -- Test case 8: Division operation (operation = "111")
        apply_test_vectors (a, b, operation, "1101", "1010", "111");
        wait until rising_edge(clk);

        -- Test case 1: AND operation (operation = "000")
        apply_test_vectors (a, b, operation, "1101", "1010", "000");
        wait until rising_edge(clk);
        
        -- Test case 2: OR operation (operation = "001")
        apply_test_vectors (a, b, operation, "1010", "1101", "001");
        wait until rising_edge(clk);
        
        -- Test case 3: XOR operation (operation = "010")
        apply_test_vectors (a, b, operation, "1010", "1101", "010");
        wait until rising_edge(clk);
        
        -- Test case 4: NOT operation (operation = "011")
        apply_test_vectors (a, b, operation, "1010", "1101", "011");
        wait until rising_edge(clk);
        
        -- Test case 5: Addition operation (operation = "100")
        apply_test_vectors (a, b, operation, "1010", "1101", "100");
        wait until rising_edge(clk);
        
        -- Test case 6: Subtraction operation (operation = "101")
        apply_test_vectors (a, b, operation, "1010", "1101", "101");
        wait until rising_edge(clk);
        
        -- Test case 7: Multiplication operation (operation = "110")
        apply_test_vectors (a, b, operation, "1010", "1101", "110");
        wait until rising_edge(clk);
        
        -- Test case 8: Division operation (operation = "111")
        apply_test_vectors (a, b, operation, "1010", "1101", "111");
        wait until rising_edge(clk);
    
        wait;
      end process;
end testbench;