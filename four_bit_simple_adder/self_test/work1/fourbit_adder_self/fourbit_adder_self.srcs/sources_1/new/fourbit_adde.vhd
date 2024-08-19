library ieee;
use ieee.std_logic_1164.all;

--entity declaration
entity fourbit_adder is
  port (
    A, B        : in std_logic_vector(3 downto 0);
    SUM         : out std_logic_vector(3 downto 0);
    CARRY_OUT   : out std_logic; 
    CARRY       : out std_logic_vector(3 downto 0) 
  );
end fourbit_adder;

--architecture declaration
architecture behavioural of fourbit_adder is
  signal C : std_logic_vector(4 downto 0); 
begin
    C(0)  <= '0'; -- Initial carry in as 0

  -- Loop for full adder logic for each bit
  gen_adders: for i in 0 to 3 generate
    SUM(i)  <= A(i) xor B(i) xor C(i);
    C(i+1)  <= (A(i) and B(i)) or ((A(i) xor B(i)) and C(i));
  end generate gen_adders;

  CARRY_OUT <= C(4); -- Final carry out
  CARRY     <= C(3 downto 0); -- Carry bits
end behavioural;
