library ieee;
use ieee.std_logic_1164.all;

--entity declaration
entity fourbit_substractor is
  port (
    a,b           : in std_logic_vector(3 downto 0);
    difference    : out std_logic_vector(3 downto 0);
    borrow_out    : out std_logic; 
    borrow        : out std_logic_vector(3 downto 0)
  );
end fourbit_substractor;

--architecture declaration
architecture behavioural of fourbit_substractor is
  signal b_in : std_logic_vector(4 downto 0); 
begin
    b_in(0)  <= '0'; 

  -- Loop for full adder logic for each bit
  gen_adders: for i in 0 to 3 generate
    difference(i)  <= A(i) xor B(i) xor b_in(i);
    b_in(i+1)  <= (not A(i) and B(i)) or ((not (A(i) xor B(i))) and B_in(i));
  end generate gen_adders;

  -- Assign the borrow 
 borrow     <= b_in(3 downto 0); 
end behavioural;
