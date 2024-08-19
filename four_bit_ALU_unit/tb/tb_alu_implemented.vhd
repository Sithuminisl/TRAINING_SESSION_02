library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity declaration
entity tb_alu is
end tb_alu;

--architecture declaration
architecture testbench of tb_alu is
    
    signal input_buffer                      : std_logic_vector(10 downto 0);
    signal output_buffer                     : std_logic_vector(3 downto 0);
    signal clk                              : std_logic := '0';
    signal in_valid                         : std_logic := '0';
    signal read_request                     : std_logic := '0';
    signal out_valid                        : std_logic := '0';

  
    constant c_clk_period                     : time := 10 ns;

    -- Procedure to apply test vectors
    procedure apply_test_vectors(
        signal input_buffer                           : out std_logic_vector(10 downto 0);
        constant a_value                      : in std_logic_vector(3 downto 0);
        constant b_value                      : in std_logic_vector(3 downto 0);
        constant operation_value              : in std_logic_vector(2 downto 0)
      ) is

      begin
        input_buffer                                  <= a_value & b_value & operation_value;

        wait until rising_edge(clk); 
        
      end procedure apply_test_vectors;
    
  begin
    uut: entity work.alu
    port map (
        input_buffer => input_buffer,
        output_buffer => output_buffer,
        clk => clk,
        in_valid => in_valid,
        read_request => read_request,
        out_valid => out_valid
        
    );

-- Clock generation 

        clk                                  <= not clk after c_clk_period/2;

    -- Test process

  stim_proc: process
  begin
        
        
        in_valid <= '1';
        read_request <= '1';
        apply_test_vectors (input_buffer, "1101", "1010", "000");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "001");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "010");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "011");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "100");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "101");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "110");
        wait until rising_edge(clk);
        
        
        apply_test_vectors (input_buffer, "1101", "1010", "111");
        wait until rising_edge(clk);

        -- -- Test case 1: AND operation (operation = "000")
        -- apply_test_vectors (input_buffer, "1101", "1010", "000");
        -- wait until rising_edge(clk);
        
        -- -- Test case 2: OR operation (operation = "001")
        -- apply_test_vectors (input_buffer, "1010", "1101", "001");
        -- wait until rising_edge(clk);
        
        -- -- Test case 3: XOR operation (operation = "010")
        -- apply_test_vectors (input_buffer, "1010", "1101", "010");
        -- wait until rising_edge(clk);
        
        -- -- Test case 4: NOT operation (operation = "011")
        -- apply_test_vectors (input_buffer, "1010", "1101", "011");
        -- wait until rising_edge(clk);
        
        -- -- Test case 5: Addition operation (operation = "100")
        -- apply_test_vectors (input_buffer, "1010", "1101", "100");
        -- wait until rising_edge(clk);
        
        -- -- Test case 6: Subtraction operation (operation = "101")
        -- apply_test_vectors (input_buffer, "1010", "1101", "101");
        -- wait until rising_edge(clk);
        
        -- -- Test case 7: Multiplication operation (operation = "110")
        -- apply_test_vectors (input_buffer, "1010", "1101", "110");
        -- wait until rising_edge(clk);
        
        -- -- Test case 8: Division operation (operation = "111")
        -- apply_test_vectors (input_buffer, "1010", "1101", "111");
        -- wait until rising_edge(clk);
    
        wait;
      end process;
end testbench;