library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration
entity alu is
  port (
    input_buffer  : in  std_logic_vector(10 downto 0);
    output_buffer : out std_logic_vector(3 downto 0);
    clk           : in  std_logic;
    in_valid      : in  std_logic;
    read_request  : in  std_logic;
    out_valid     : inout std_logic
  );
end alu;

-- Architecture declaration
architecture behavioural of alu is
    signal a          : std_logic_vector(3 downto 0);
    signal b          : std_logic_vector(3 downto 0);
    signal operation  : std_logic_vector(2 downto 0);
    signal result_add : std_logic_vector(3 downto 0);
    signal result_sub : std_logic_vector(3 downto 0);
    signal result_div : std_logic_vector(3 downto 0);
    signal result_and : std_logic_vector(3 downto 0);
    signal result_or  : std_logic_vector(3 downto 0);
    signal result_xor : std_logic_vector(3 downto 0);
    signal result_not : std_logic_vector(3 downto 0);
    signal mux_result : std_logic_vector(3 downto 0);
    signal temp_reminder : unsigned(3 downto 0);
    signal qui        : unsigned(3 downto 0);
    signal c1         : std_logic_vector(3 downto 0);
    signal c2         : std_logic;
    signal start      : std_logic; -- corrected to std_logic
   
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if in_valid = '1' then
                a <= input_buffer(10 downto 7);
                b <= input_buffer(6 downto 3);
                operation <= input_buffer(2 downto 0);
                start <= '1';
            else
                start <= '0';
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if start = '1' and read_request = '1' then
                case operation is
                    when "000" =>
                        mux_result <= result_and;
                    when "001" =>
                        mux_result <= result_or;
                    when "010" =>
                        mux_result <= result_xor;
                    when "011" =>
                        mux_result <= result_not;
                    when "100" =>
                        mux_result <= result_add;
                    when "101" =>
                        mux_result <= result_sub;
                    when "110" =>
                        mux_result <= result_div;
                    when others =>
                        mux_result <= (others => '0');
                end case;
                out_valid <= '1';
            else
                out_valid <= '0';
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if out_valid = '1' and read_request = '1' then
                output_buffer <= mux_result;
            end if;
        end if;
    end process;

    -- Block for AND operation
    process(a, b)
    begin
        result_and <= a and b;
    end process;

    -- Block for OR operation
    process(a, b)
    begin
        result_or <= a or b;
    end process;

    -- Block for XOR operation
    process(a, b)
    begin
        result_xor <= a xor b;
    end process;

    -- Block for NOT operation
    process(b)
    begin
        result_not <= not b;
    end process;

    -- Block for ADD operation
    process(a, b)
        variable temp_carry : std_logic_vector(4 downto 0) := (others => '0');
    begin
        temp_carry(0) := '0'; -- Initial carry bit
        for i in 0 to 3 loop
            result_add(i) <= a(i) xor b(i) xor temp_carry(i);
            temp_carry(i+1) := (a(i) and b(i)) or ((a(i) xor b(i)) and temp_carry(i));
        end loop;
        c2 <= temp_carry(4); -- Final carry out
        c1 <= temp_carry(4 downto 1); -- Carry bits
    end process;

    -- Block for SUB operation
    process(a, b)
        variable temp_borrow : std_logic_vector(4 downto 0) := (others => '0');
    begin
        temp_borrow(0) := '0'; -- Initial borrow bit
        for i in 0 to 3 loop
            result_sub(i) <= (a(i) xor b(i)) xor temp_borrow(i);
            temp_borrow(i+1) := ((not a(i)) and b(i)) or (not(a(i) xor b(i)) and temp_borrow(i));
        end loop;
        c1 <= temp_borrow(4 downto 1);
        c2 <= '0';
    end process;

    -- Block for DIV operation
    process(a, b)
        variable temp_reminder_var : unsigned(3 downto 0) := (others => '0');
        variable qui_var : unsigned(3 downto 0) := (others => '0');
    begin
        if unsigned(a) < unsigned(b) then
            temp_reminder_var := unsigned(a); -- Reminder is equal to a
        elsif unsigned(a) = unsigned(b) then
            qui_var := "0001";
        elsif unsigned(a) > unsigned(b) then
            qui_var := "0001";
            temp_reminder_var := unsigned(a) - unsigned(b);
            for i in 0 to 3 loop
                if temp_reminder_var >= unsigned(b) then
                    temp_reminder_var := temp_reminder_var - unsigned(b);
                    qui_var := qui_var + 1;
                end if;
            end loop;
        end if;
        result_div <= std_logic_vector(qui_var);
        c1 <= std_logic_vector(temp_reminder_var);
        c2 <= '0';
    end process;

end behavioural;
