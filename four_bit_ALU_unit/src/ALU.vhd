library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration
entity alu is
  port (
    a                             : in std_logic_vector(3 downto 0);
    b                             : in std_logic_vector(3 downto 0);
    operation                     : in std_logic_vector(2 downto 0);
    result                        : out std_logic_vector(3 downto 0);
    carry_out                     : out std_logic; 
    carry                         : out std_logic_vector(3 downto 0);
    remainder                     : out std_logic_vector(3 downto 0);
    borrow_out                    : out std_logic;
    borrow                        : out std_logic_vector(3 downto 0)
  );
end alu;

-- Architecture declaration
architecture behavioural of alu is
  signal temp_reminder            : unsigned(3 downto 0);
  signal qui                      : unsigned(3 downto 0);

begin
  process(a, b, operation)
    variable temp_reminder_var    : unsigned(3 downto 0) := (others => '0');
    variable temp_carry           : std_logic_vector(4 downto 0) := (others => '0');
    variable temp_borrow          : std_logic_vector(4 downto 0) := (others => '0');
    variable qui_var              : unsigned(3 downto 0) := (others => '0');

  begin

    -- Default assignments
    result                        <= (others => '0');
    carry                         <= (others => '0');
    borrow                        <= (others => '0');
    remainder                     <= (others => '0');
    carry_out                     <= '0';
    
    
    case operation is
      when "000" =>                                                                 -- bitwise AND operation
        result <= a and b;

      when "001" =>                                                                 -- bitwise OR operation
        result <= a or b;

      when "010" =>                                                                 -- bitwise XOR operation
        result <= a xor b;

      when "011" =>                                                                 -- NOT operation
        result <= not b;

      when "100" =>                                                                 -- addition operation
        temp_carry(0)               := '0';                                         -- Initial carry bit                  
                                                             
        for i in 0 to 3 loop
          result(i)                 <= a(i) xor b(i) xor temp_carry(i);
          temp_carry(i+1)           := (a(i) and b(i)) or ((a(i) xor b(i)) and temp_carry(i));
        end loop;

        carry_out                   <= temp_carry(4);                               -- Final carry out
        carry                       <= temp_carry(3 downto 0);                      -- Carry bits

      when "101" =>                                                                 -- subtraction operation
        temp_borrow(0)              :=  '0';                                        -- Initial borrow bit

        for i in 0 to 3 loop
          result(i)                 <= (a(i) xor b(i)) xor temp_borrow(i);
          temp_borrow(i+1)          := ((not a(i)) and b(i)) or (not(a(i) xor b(i)) and temp_borrow(i));
        end loop;

        borrow                      <= temp_borrow(4 downto 1);
        

      when "110" =>                                                                 -- division operation
        temp_reminder_var           := (others => '0');
        qui_var                     := (others => '0');

        if (unsigned(a) < unsigned(b)) then     
          temp_reminder_var         := unsigned(a);                                -- Reminder is equal to a
                                        
        elsif (unsigned(a) = unsigned(b)) then
          qui_var                   := "0001";

        elsif (unsigned(a) > unsigned(b)) then
          qui_var                   := "0001";
          temp_reminder_var         := unsigned(a) - unsigned(b);

          for i in 0 to 3 loop
            if temp_reminder_var    >= unsigned(b) then
              temp_reminder_var     := temp_reminder_var - unsigned(b);
              qui_var               := qui_var + 1;
            end if;

          end loop;

        end if;
        result                      <= std_logic_vector(qui_var);
        remainder                   <= std_logic_vector(temp_reminder_var);

      when others =>
        -- Default assignments 
    end case;
  end process;
end behavioural;