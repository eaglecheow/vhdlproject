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

    signal clockDivider1: std_logic_vector(8 downto 0) := (others => '0');
    signal clockDivider2: std_logic_vector(3 downto 0) := (others => '0');

    signal internalClock: std_logic := '0';
    type StateType is (stIdle, stPrepChar, stSendChar);
    signal state: StateType;
    
    signal inputData: std_logic_vector(23 downto 0) := (others => '0');
    signal numCharacterSent: std_logic_vector(3 downto 0) := (others => '0'); 
    signal characterToSend: std_logic_vector(9 downto 0) := (others => '1');
    signal outputData: std_logic := '1';

    signal numBitsSent: std_logic_vector(3 downto 0) := (others => '0');

begin

    process(Clk)
    begin

        if rising_edge(Clk) then

            if clockDivider1 < "101000101" then

                clockDivider1 <= clockDivider1 + '1';

            else

                clockDivider1 <= (others => '0');

            end if;

        end if;

    end process;

    process(clockDivider1(8))
    begin

        if rising_edge(clockDivider1(8)) then

            clockDivider2 <= clockDivider2 + '1';

        end if;

    end process;


    internalClock <= clockDivider2(3);

    Txd <= outputData;

    process(internalClock)
    begin

        if rising_edge(internalClock) then

            case state is

                when stIdle =>
                    inputData <= DataIn;
                    numCharacterSent <= (others => '0');
                    state <= stPrepChar;

                when stPrepChar =>

                    state <= stSendChar;

                    case numCharacterSent is

                        when "0000" =>
                            characterToSend <= '0' & "0011" & inputData(23 downto 20) & '1';

                        when "0001" =>
                            characterToSend <= '0' & "0011" & inputData(19 downto 16) & '1';

                        when "0010" =>
                            characterToSend <= '0' & "0011" & inputData(15 downto 12) & '1';

                        when "0011" =>
                            characterToSend <= '0' & "0011" & inputData(11 downto 8) & '1';

                        when "0100" =>
                            characterToSend <= "0001011101"; -- Send character "."

                        when "0101" =>
                            characterToSend <= '0' & "0011" & inputData(7 downto 4) & '1';

                        when "0110" =>
                            characterToSend <= '0' & "0011" & inputData(3 downto 0) & '1';

                        when "0111" =>
                            characterToSend <= "0101110101"; -- Send character "º"

                        when "1000" =>
                            characterToSend <= "0010000111"; -- Send character "C"

                        when "1001" =>
                            characterToSend <= "0000010101"; -- Send character "\n"

                        when "1010" =>
                            characterToSend <= "0000011011"; -- Send character "\r"

                        when others =>
                            characterToSend <= (others => '0');
                            state <= stIdle;

                    end case;

                when stSendChar =>
                    if numBitsSent < "1010" then

                        outputData <= characterToSend(9);
                        characterToSend <= characterToSend(8 downto 0) & '1';
                        numBitsSent <= numBitsSent + '1';
                        state <= stSendChar;

                    else
                        
                        outputData <= '1';
                        numBitsSent <= (others => '0');
                        numCharacterSent <= numCharacterSent + '1';
                        state <= stPrepChar;

                    end if;


            end case;

        end if;

    end process;


end Behavioral;

