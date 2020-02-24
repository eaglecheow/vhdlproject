--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:21:44 02/24/2020
-- Design Name:   
-- Module Name:   C:/Users/user/Desktop/VHLDProject/Attempt3/tb_LEDController.vhd
-- Project Name:  Attempt3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LEDController
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
 
ENTITY tb_LEDController IS
END tb_LEDController;
 
ARCHITECTURE behavior OF tb_LEDController IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LEDController
    PORT(
         DataIn : IN  std_logic_vector(23 downto 0);
         Clock : IN  std_logic;
         An : OUT  std_logic_vector(5 downto 0);
         Ca : OUT  std_logic;
         Cb : OUT  std_logic;
         Cc : OUT  std_logic;
         Cd : OUT  std_logic;
         Ce : OUT  std_logic;
         Cf : OUT  std_logic;
         Cg : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn : std_logic_vector(23 downto 0) := (others => '0');
   signal Clock : std_logic := '0';

 	--Outputs
   signal An : std_logic_vector(5 downto 0);
   signal Ca : std_logic;
   signal Cb : std_logic;
   signal Cc : std_logic;
   signal Cd : std_logic;
   signal Ce : std_logic;
   signal Cf : std_logic;
   signal Cg : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LEDController PORT MAP (
          DataIn => DataIn,
          Clock => Clock,
          An => An,
          Ca => Ca,
          Cb => Cb,
          Cc => Cc,
          Cd => Cd,
          Ce => Ce,
          Cf => Cf,
          Cg => Cg
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
      DataIn <= "000000000010001001110101";

      wait for Clock_period*100;

      DataIn <= "000000000001010100100101";

      wait;
   end process;

END;
