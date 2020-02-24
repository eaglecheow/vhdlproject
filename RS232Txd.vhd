----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:55:35 02/24/2020 
-- Design Name: 
-- Module Name:    RS232Txd - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS232Txd is
    Port ( DataIn : in  STD_LOGIC_VECTOR (23 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Txd : out  STD_LOGIC);
end RS232Txd;

architecture Behavioral of RS232Txd is

    signal clockDivider: std_logic_vector(3 downto 0) := (others => '0');
    signal internalClock: std_logic := '0';
    type StateType is (stIdle, stPrepChar, stSendChar);
    signal state: StateType;
    
    signal inputData: std_logic_vector(23 downto 0) := (others => '0');
    signal numCharacterSent: std_logic_vector(3 downto 0) := (others => '0'); 

begin

    process(Clk)
    begin

        if rising_edge(Clk) then

            clockDivider <= clockDivider + '1';

        end if;

    end process;


    internalClock <= clockDivider(3);

    process(internalClock)
    begin

        if rising_edge(internalClock) then

            case state is

                when stIdle =>
                    inputData <= DataIn;
                    state <= stPrepChar;

                when stPrepChar =>
                    case numCharacterSent is

                        when "0000" =>
                        when "0001" =>
                        when "0010" =>
                        when "0011" =>
                        when "0100" =>
                        when "0101" =>
                        when "0110" =>
                        when "0111" =>
                        when "1000" =>

                    end case;

                when stSendChar =>

            end case;

        end if;

    end process;


end Behavioral;

