----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:58:02 02/17/2020 
-- Design Name: 
-- Module Name:    DataConverter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataConverter is
    Port ( DataIn : in  STD_LOGIC_VECTOR (15 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (23 downto 0);
			  Clock: in std_logic);
end DataConverter;

architecture Behavioral of DataConverter is

type StateType is (stAccept, stCheck, stShift);
signal state: StateType;
signal noBitsShifted: std_logic_vector(3 downto 0) := (others => '0');

signal bcdOut: std_logic_vector(23 downto 0) := (others => '0');
signal bcdData: std_logic_vector(15 downto 0) := (others => '0');
signal bcdDecimal: std_logic_vector(7 downto 0) := (others => '0');

signal binaryData: std_logic_vector(9 downto 0) := (others => '0');
signal binaryDecimal: std_logic_vector(1 downto 0) := (others => '0');

signal isCheckCompleted: std_logic_vector(3 downto 0) := (others => '0');

begin
	
	process (Clock)
    begin

        DataOut <= bcdOut;
        binaryDecimal <= DataIn(4 downto 3);

        case state is
            
            when stAccept =>
                binaryData <= DataIn(14 downto 5);

                if binaryDecimal = "00" then
					 
						bcdDecimal <= "00000000";
						
					 elsif binaryDecimal = "01" then
					 
						bcdDecimal <= "00100101";
						
					 elsif binaryDecimal = "10" then
					 
						bcdDecimal <= "01010000";
						
					 else
					 
						bcdDecimal <= "01110101";
					 
					 end if;

                state <= stCheck;

            when stCheck =>
                if noBitsShifted > "1001" then

                    bcdOut <= bcdData & bcdDecimal;

                    noBitsShifted <= (others => '0');
                    bcdData <= (others => '0');
                    bcdDecimal <= (others => '0');
                    binaryData <= (others => '0');
                    --binaryDecimal <= (others => '0');

                    state <= stAccept;
						  
					 elsif (bcdData(15 downto 12) > "0100") and (isCheckCompleted(3) = '0') then

                    bcdData(15 downto 12) <= bcdData(15 downto 12) + "11";
						  isCheckCompleted(3) <= '1';
                    state <= stCheck;
						  
					 elsif (bcdData(11 downto 8) > "0100") and (isCheckCompleted(2) = '0') then

                    bcdData(11 downto 8) <= bcdData(11 downto 8) + "11";
						  isCheckCompleted(2) <= '1';
                    state <= stCheck;
						  
					 elsif (bcdData(7 downto 4) > "0100") and (isCheckCompleted(1) = '0') then

                    bcdData(7 downto 4) <= bcdData(7 downto 4) + "11";
						  isCheckCompleted(1) <= '1';
                    state <= stCheck;

                elsif (bcdData(3 downto 0) > "0100") and (isCheckCompleted(0) = '0') then

                    bcdData(3 downto 0) <= bcdData(3 downto 0) + "11";
						  isCheckCompleted(0) <= '1';
                    state <= stShift;          

                else

                    state <= stShift;
						  isCheckCompleted <= (others => '0');

                end if;

            when stShift =>
                    bcdData <= bcdData(14 downto 0) & binaryData(9);
                    binaryData <= binaryData(8 downto 0) & '0';
                    noBitsShifted <= noBitsShifted + '1';
                    state <= stCheck;
            
        end case;
	
	end process;

end Behavioral;

