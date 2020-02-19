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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LCDController is

	port(
		Clock					: in std_logic;
		DataIn				: in std_logic_vector(23 downto 0);
		DataOut				: out std_logic_vector(3 downto 0); -- SF_D<11:8>
		LcdEnable			: out std_logic;
		LcdRegisterSelect	: out std_logic;
		LcdReadWrite		: out std_logic
	);

end LCDController;

architecture Behavioral of LCDController is

type StateType is (stInit);
signal state: StateType;

signal outputData: std_logic_vector(3 downto 0);
signal outputEnable: std_logic;

signal initializeStep: std_logic_vector(3 downto 0) := (others => '0');
signal delayedCycles: std_logic_vector(19 downto 0) := (others => '0');

begin

	process(Clock)
	begin
	
		if rising_edge(Clock) then
		
			case state is
			
				when stInit =>
					state <= stInit;
					if initializeStep = "0000" and delayedCycles < "10110111000110110000" then
					
						delayedCycles <= delayedCycles + '1';
						state <= stInit;
						
					elsif initializeStep = "0000" then
					
						delayedCycles <= (others => '0');
						initializeStep <= initializeStep + '1';
						state <= stInit;
						
					elsif initializeStep = "0001" and delayedCycles < "10" then
					
						outputData <= "0011";
						delayedCycles <= delayedCycles + '1';
						state <= stInit;
						
					elsif initializeStep = "0001" then
					
						outputEnable <= '1';
						state <= stInit;
					
					end if;
			
			end case;
		
		end if;
	
	end process;

end Behavioral;

