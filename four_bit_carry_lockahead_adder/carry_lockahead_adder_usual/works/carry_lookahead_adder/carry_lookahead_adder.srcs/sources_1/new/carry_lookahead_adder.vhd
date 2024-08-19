library ieee;
use ieee.std_logic_1164.all;

--entity declaration
entity carry_lookahead_adder is
  port (
    a,b        : in std_logic_vector(3 downto 0);
    sum        : out std_logic_vector(3 downto 0);
    carry_out   : out std_logic; 
    carry       : out std_logic_vector(3 downto 0) 
  );
end carry_lookahead_adder;

--architecture declaration
architecture behavioural of carry_lookahead_adder is 
  signal p,g : std_logic_vector(3 downto 0); -- Propagate and generate signals
  signal c    : std_logic_vector(4 downto 0); -- Carry signals

  begin
      -- Initialize carry-in to '0'
    C(0) <= '0';

    -- Generate the propagate and generate signals
    p <= a xor b;
    g <= a and b;

  -- Generate the carry signals
  C(1) <= G(0) or (P(0) and C(0));
  C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and C(0));
  C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and C(0));
  C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and C(0));

 
  sum <= p(3 downto 0) xor c(3 downto 0); -- Generate the sum bits
  carry_out <= c(4); -- Final carry out
  carry     <= c(3 downto 0); -- Carry bits
end behavioural;
