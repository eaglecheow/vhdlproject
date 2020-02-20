--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:08:41 02/19/2020
-- Design Name:   
-- Module Name:   C:/Users/user/Desktop/VHLDProject/Attempt3/tb_LCDController.vhd
-- Project Name:  Attempt3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LCDController
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_LCDController IS
END tb_LCDController;
 
ARCHITECTURE behavior OF tb_LCDController IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LCDController
    PORT(
         Clock : IN  std_logic;
         DataIn : IN  std_logic_vector(23 downto 0);
         DataOut : OUT  std_logic_vector(3 downto 0);
         LcdEnable : OUT  std_logic;
         LcdRegisterSelect : OUT  std_logic;
         LcdReadWrite : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal DataIn : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(3 downto 0);
   signal LcdEnable : std_logic;
   signal LcdRegisterSelect : std_logic;
   signal LcdReadWrite : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LCDController PORT MAP (
          Clock => Clock,
          DataIn => DataIn,
          DataOut => DataOut,
          LcdEnable => LcdEnable,
          LcdRegisterSelect => LcdRegisterSelect,
          LcdReadWrite => LcdReadWrite
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
