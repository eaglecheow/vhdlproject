----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:34 02/13/2020 
-- Design Name: 
-- Module Name:    SPIMaster - Behavioral 
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

entity SPIController is
	port (
		SCLK : out STD_LOGIC;
		MISO : in STD_LOGIC;
		MOSI : out STD_LOGIC;
		CS : out STD_LOGIC;
		CLK : in STD_LOGIC;
		DOUT : out std_logic_vector(15 downto 0));
end SPIController;

architecture Behavioral of SPIController is

	signal iClockDiv : std_logic_vector(3 downto 0) := (others => '0');
	signal iClock : std_logic := '0';
	type StateType is (stIdle, stData);
	signal state : StateType;
	signal iNoBitsReceived : std_logic_vector(5 downto 0) := (others => '0');
	signal iBuffer : std_logic_vector(15 downto 0) := (others => '0');
begin

	MOSI <= '1';

	process (CLK)
	begin
		if rising_edge(CLK) then

			if iClockDiv > "1100" then

				iClockDiv <= (others => '0');

			else

				iClockDiv <= iClockDiv + '1';

			end if;

		end if;

	end process;

	iClock <= iClockDiv(3);
	SCLK <= iClock;
	process (iClock)
	begin

		if falling_edge(iClock) then

			CS <= '1';

			case state is

				when stIdle =>
					CS <= '0';
					iBuffer <= iBuffer(14 downto 0) & MISO;
					iNoBitsReceived <= iNoBitsReceived + '1';
					state <= stData;

				when stData =>
					if iNoBitsReceived < "10000" then

						CS <= '0';
						iBuffer <= iBuffer(14 downto 0) & MISO;
						iNoBitsReceived <= iNoBitsReceived + '1';
						state <= stData;

					else

						DOUT <= iBuffer;
						iBuffer <= (others => '0');
						iNoBitsReceived <= (others => '0');
						state <= stIdle;

					end if;

			end case;

		end if;

	end process;

end Behavioral;