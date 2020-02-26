--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:21:57 02/26/2020
-- Design Name:   
-- Module Name:   C:/Users/user/Desktop/VHLDProject/Attempt3/tb_Display.vhd
-- Project Name:  Attempt3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: hwtest_Display
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
 
ENTITY tb_Display IS
END tb_Display;
 
ARCHITECTURE behavior OF tb_Display IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT hwtest_Display
    PORT(
         Clock : IN  std_logic;
         LCD_DataOut : OUT  std_logic_vector(3 downto 0);
         LCD_Enable : OUT  std_logic;
         LCD_ReadWrite : OUT  std_logic;
         LCD_RegisterSelect : OUT  std_logic;
         LED_An : OUT  std_logic_vector(5 downto 0);
         LED_Ca : OUT  std_logic;
         LED_Cb : OUT  std_logic;
         LED_Cc : OUT  std_logic;
         LED_Cd : OUT  std_logic;
         LED_Ce : OUT  std_logic;
         LED_Cf : OUT  std_logic;
         LED_Cg : OUT  std_logic;
         RS232_Txd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';

 	--Outputs
   signal LCD_DataOut : std_logic_vector(3 downto 0);
   signal LCD_Enable : std_logic;
   signal LCD_ReadWrite : std_logic;
   signal LCD_RegisterSelect : std_logic;
   signal LED_An : std_logic_vector(5 downto 0);
   signal LED_Ca : std_logic;
   signal LED_Cb : std_logic;
   signal LED_Cc : std_logic;
   signal LED_Cd : std_logic;
   signal LED_Ce : std_logic;
   signal LED_Cf : std_logic;
   signal LED_Cg : std_logic;
   signal RS232_Txd : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hwtest_Display PORT MAP (
          Clock => Clock,
          LCD_DataOut => LCD_DataOut,
          LCD_Enable => LCD_Enable,
          LCD_ReadWrite => LCD_ReadWrite,
          LCD_RegisterSelect => LCD_RegisterSelect,
          LED_An => LED_An,
          LED_Ca => LED_Ca,
          LED_Cb => LED_Cb,
          LED_Cc => LED_Cc,
          LED_Cd => LED_Cd,
          LED_Ce => LED_Ce,
          LED_Cf => LED_Cf,
          LED_Cg => LED_Cg,
          RS232_Txd => RS232_Txd
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
