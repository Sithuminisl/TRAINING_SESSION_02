library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryDivision is
    Port (
        dividend        :   in  STD_LOGIC_VECTOR(3 downto 0);           -- for the dividend
        divisor         :   in  STD_LOGIC_VECTOR(3 downto 0);           -- for the divisor                       
        quotient        :   out STD_LOGIC_VECTOR(3 downto 0);           -- for the quotient    
        remainder       :   out STD_LOGIC_VECTOR(3 downto 0)            -- for the remainder   
    );
end BinaryDivision;

architecture Behavioral of BinaryDivision is
begin
    process(dividend, divisor)
        variable qui : unsigned(3 downto 0);         -- for the quotient
        variable temp_reminder : unsigned(3 downto 0);  -- using a variable for temporary remainder
    begin
        qui := (others => '0');
        temp_reminder := (others => '0');

        if (unsigned(dividend) < unsigned(divisor)) then     
            qui := (others => '0');
            temp_reminder := unsigned(dividend);   -- if the dividend is less than the divisor
        elsif (unsigned(dividend) = unsigned(divisor)) then
            qui := "0001";
            temp_reminder := (others => '0');      -- if the dividend is equal to the divisor
        elsif (unsigned(dividend) > unsigned(divisor)) then
            qui := "0001";
            temp_reminder := unsigned(dividend) - unsigned(divisor);
            for i in 0 to 3 loop
                if temp_reminder >= unsigned(divisor) then
                    temp_reminder := temp_reminder - unsigned(divisor);
                    qui := qui + "0001";
                end if;
            end loop;    
        end if;
        
        quotient <= std_logic_vector(qui);             -- assigning the quotient
        remainder <= std_logic_vector(temp_reminder);  -- assigning the remainder
    end process;
end Behavioral;
