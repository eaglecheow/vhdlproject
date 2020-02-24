----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:23 02/24/2020 
-- Design Name: 
-- Module Name:    LEDController - Behavioral 
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
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LEDController is
    port (
        DataIn : in STD_LOGIC_VECTOR (23 downto 0);
        Clock : in STD_LOGIC;
        An : out std_logic_vector(5 downto 0);
        Ca : out STD_LOGIC;
        Cb : out STD_LOGIC;
        Cc : out STD_LOGIC;
        Cd : out STD_LOGIC;
        Ce : out STD_LOGIC;
        Cf : out STD_LOGIC;
        Cg : out STD_LOGIC);
end LEDController;

architecture Behavioral of LEDController is

    signal iClock : std_logic_vector(2 downto 0) := (others => '0');
    signal inputData : std_logic_vector(23 downto 0) := (others => '0');
    signal displayDigit : std_logic_vector(3 downto 0) := (others => '0');
    signal sevenSegmentDisplay : std_logic_vector(6 downto 0) := (others => '0');

begin

    process (Clock)
    begin

        if rising_edge(Clock) then

            iClock <= iClock + '1';

            if iClock > "101" then

                iClock <= "000";
                inputData <= DataIn;

            end if;

        end if;

    end process;

    with iClock select
        An <= "011111" when "001",
        "101111" when "010",
        "110111" when "011",
        "111011" when "100",
        "111101" when "101",
        "111110" when "110",
        "111111" when others;

    with iClock select
        displayDigit <= inputData(23 downto 20) when "000",
        inputData(19 downto 16) when "001",
        inputData(15 downto 12) when "010",
        inputData(11 downto 8) when "011",
        inputData(7 downto 4) when "100",
        inputData(3 downto 0) when others;

    with displayDigit select
        sevenSegmentDisplay <= "1111110" when "0000",
        "0110000" when "0001",
        "1101101" when "0010",
        "1111001" when "0011",
        "0110011" when "0100",
        "1011011" when "0101",
        "1011111" when "0110",
        "1110000" when "0111",
        "1111111" when "1000",
        "1111011" when "1001",
        "0000000" when others;

    Ca <= sevenSegmentDisplay(6);
    Cb <= sevenSegmentDisplay(5);
    Cc <= sevenSegmentDisplay(4);
    Cd <= sevenSegmentDisplay(3);
    Ce <= sevenSegmentDisplay(2);
    Cf <= sevenSegmentDisplay(1);
    Cg <= sevenSegmentDisplay(0);

end Behavioral;