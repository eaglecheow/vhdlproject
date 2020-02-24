----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:16:33 02/19/2020 
-- Design Name: 
-- Module Name:    LCDController - Behavioral 
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

entity LCDController is

	port (
		Clock : in std_logic;
		DataIn : in std_logic_vector(23 downto 0);
		DataOut : out std_logic_vector(3 downto 0); -- SF_D<11:8>
		LcdEnable : out std_logic;
		LcdRegisterSelect : out std_logic;
		LcdReadWrite : out std_logic
	);

end LCDController;

architecture Behavioral of LCDController is

	type StateType is (stInit, stWritePrep, stCharPrep, stWrite);
	signal state : StateType;

	signal outputData : std_logic_vector(3 downto 0) := (others => '0');
	signal outputEnable : std_logic := '0';
	signal outputWrite : std_logic := '1';
	signal outputRegisterSelect : std_logic := '0';

	signal stepCount : std_logic_vector(4 downto 0) := (others => '0');
	signal prevStepCount : std_logic_vector(4 downto 0) := (others => '0');
	signal delayedCycles : std_logic_vector(19 downto 0) := (others => '0');

	signal cyclesToDelay : std_logic_vector(19 downto 0) := (others => '0');
	signal dataToOutput : std_logic_vector(3 downto 0) := (others => '0');
	signal enableToOutput : std_logic := '0';
	signal writeToOutput : std_logic := '1';
	signal registerSelectToOutput : std_logic := '0';
	signal isStateExit : std_logic := '0';

	signal inputData: std_logic_vector(23 downto 0) := (others => '0');
	signal characterWritten: std_logic_vector(3 downto 0) := (others => '0');
	signal characterToWrite: std_logic_vector(7 downto 0) := (others => '0');

begin

	DataOut <= outputData;
	LcdEnable <= outputEnable;
	LcdReadWrite <= outputWrite;
	LcdRegisterSelect <= outputRegisterSelect;

	process (Clock)
	begin

		if rising_edge(Clock) then

			case state is

				when stInit =>

					case prevStepCount is

						when "00000" =>
							cyclesToDelay <= "10110111000110110000";

							dataToOutput <= "0011";
							writeToOutput <= '0';
							registerSelectToOutput <= '1';

						when "00001" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "00010" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "00011" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "00100" =>
							cyclesToDelay <= "00110010000011001000";

							dataToOutput <= "0011";
							writeToOutput <= '0';
							registerSelectToOutput <= '1';
						when "00101" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "00110" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "00111" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "01000" =>
							cyclesToDelay <= "00000001001110001000";

							dataToOutput <= "0011";
							writeToOutput <= '0';
							registerSelectToOutput <= '1';

						when "01001" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "01010" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "01011" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "01100" =>
							cyclesToDelay <= "00000000011111010000";

							dataToOutput <= "0010";
							writeToOutput <= '0';
							registerSelectToOutput <= '1';

						when "01101" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "01110" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "01111" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "10000" =>
							cyclesToDelay <= "00000000011111010000";
							isStateExit <= '1';

						when others =>

					end case;

					if isStateExit = '1' and delayedCycles < cyclesToDelay then

						delayedCycles <= delayedCycles + '1';
						state <= stInit;

					elsif isStateExit = '1' then

						state <= stWritePrep;
						delayedCycles <= (others => '0');
						stepCount <= (others => '0');
						prevStepCount <= (others => '0');
						isStateExit <= '0';

					elsif delayedCycles < cyclesToDelay then

						delayedCycles <= delayedCycles + '1';
						state <= stInit;

					else

						delayedCycles <= (others => '0');
						stepCount <= stepCount + '1';
						prevStepCount <= stepCount;

						outputData <= dataToOutput;
						outputEnable <= enableToOutput;
						outputRegisterSelect <= registerSelectToOutput;
						outputWrite <= writeToOutput;

						state <= stInit;

					end if;
				when stWritePrep =>
					-- Clear screen
					-- Move cursor to home
					case prevStepCount is

						when "00000" =>
							cyclesToDelay <= "00000000000000000100";
							
							dataToOutput <= "0000";
							writeToOutput <= '0';
							registerSelectToOutput <= '0';

						when "00001" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "00010" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "00011" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "00100" =>
							cyclesToDelay <= "00000000000000110010";

							dataToOutput <= "0001";
							writeToOutput <= '0';
							registerSelectToOutput <= '0';

						when "00101" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "00110" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "00111" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "01000" =>
							cyclesToDelay <= "00000000011111010000";

							isStateExit <= '1';
							
						when others =>

					end case;

					if isStateExit = '1' and delayedCycles < cyclesToDelay then

						delayedCycles <= delayedCycles + '1';
						state <= stWritePrep;

					elsif isStateExit = '1' then

						state <= stCharPrep;
						delayedCycles <= (others => '0');
						stepCount <= (others => '0');
						prevStepCount <= (others => '0');
						isStateExit <= '0';
						inputData <= DataIn;

					elsif delayedCycles < cyclesToDelay then

						delayedCycles <= delayedCycles + '1';
						state <= stWritePrep;

					else

						delayedCycles <= (others => '0');
						stepCount <= stepCount + '1';
						prevStepCount <= stepCount;

						outputData <= dataToOutput;
						outputEnable <= enableToOutput;
						outputRegisterSelect <= registerSelectToOutput;
						outputWrite <= writeToOutput;

						state <= stWritePrep;

					end if;

				when stCharPrep =>

					state <= stWrite;

					case characterWritten is

						when "0000" =>
							characterToWrite <= "0011" & inputData(23 downto 20);

						when "0001" =>
							characterToWrite <= "0011" & inputData(19 downto 16);

						when "0010" =>
							characterToWrite <= "0011" & inputData(15 downto 12);

						when "0011" =>
							characterToWrite <= "0011" & inputData(11 downto 8);

						when "0100" =>
							characterToWrite <= "00101110";

						when "0101" =>
							characterToWrite <= "0011" & inputData(7 downto 4);

						when "0110" =>
							characterToWrite <= "0011" & inputData(3 downto 0);

						when "0111" =>
							characterToWrite <= "11011111";

						when "1000" =>
							characterToWrite <= "01000011";

						when "1001" =>

							characterToWrite <= (others => '0');
							characterWritten <= (others => '0');
							state <= stWritePrep;

						when others =>

					end case;

				when stWrite =>

					case prevStepCount is

						when "00000" =>
							cyclesToDelay <= "00000000000000000100";

							dataToOutput <= characterToWrite(7 downto 4);
							writeToOutput <= '0';
							registerSelectToOutput <= '1';

						when "00001" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "00010" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "00011" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "00100" =>
							cyclesToDelay <= "00000000000000110010";

							dataToOutput <= characterToWrite(3 downto 0);
							writeToOutput <= '0';
							registerSelectToOutput <= '1';

						when "00101" =>
							cyclesToDelay <= "00000000000000000010";

							enableToOutput <= '1';

						when "00110" =>
							cyclesToDelay <= "00000000000000001100";

							enableToOutput <= '0';

						when "00111" =>
							cyclesToDelay <= "00000000000000000001";

							dataToOutput <= (others => '0');
							writeToOutput <= '1';
							registerSelectToOutput <= '0';

						when "01000" =>
							cyclesToDelay <= "00000000011111010000";

							isStateExit <= '1';

						when others =>

					end case;

					if isStateExit = '1' and delayedCycles < cyclesToDelay then

						delayedCycles <= delayedCycles + '1';
						state <= stWrite;

					elsif isStateExit = '1' then

						state <= stCharPrep;
						delayedCycles <= (others => '0');
						stepCount <= (others => '0');
						prevStepCount <= (others => '0');
						isStateExit <= '0';

						inputData <= DataIn;
						characterWritten <= characterWritten + '1';

					elsif delayedCycles < cyclesToDelay then

						delayedCycles <= delayedCycles + '1';
						state <= stWrite;

					else

						delayedCycles <= (others => '0');
						stepCount <= stepCount + '1';
						prevStepCount <= stepCount;

						outputData <= dataToOutput;
						outputEnable <= enableToOutput;
						outputRegisterSelect <= registerSelectToOutput;
						outputWrite <= writeToOutput;

						state <= stWrite;

					end if;

			end case;

		end if;

	end process;

end Behavioral;