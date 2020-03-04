--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:55:48 03/03/2020
-- Design Name:   
-- Module Name:   C:/Users/user/Desktop/VHLDProject/Attempt3/tb_DirectTemperatureReader.vhd
-- Project Name:  Attempt3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DirectTemperatureReader
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
 
ENTITY tb_DirectTemperatureReader IS
END tb_DirectTemperatureReader;
 
ARCHITECTURE behavior OF tb_DirectTemperatureReader IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DirectTemperatureReader
    PORT(
         Clock : IN  std_logic;
         SPI_In : IN  std_logic;
         SPI_Out : OUT  std_logic;
         SPI_Cs : OUT  std_logic;
         SPI_Sclk : OUT  std_logic;
         LCD_DataOut : OUT  std_logic_vector(3 downto 0);
         LCD_ReadWrite : OUT  std_logic;
         LCD_Enable : OUT  std_logic;
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
   signal SPI_In : std_logic := '0';

 	--Outputs
   signal SPI_Out : std_logic;
   signal SPI_Cs : std_logic;
   signal SPI_Sclk : std_logic;
   signal LCD_DataOut : std_logic_vector(3 downto 0);
   signal LCD_ReadWrite : std_logic;
   signal LCD_Enable : std_logic;
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
   -- constant SPI_Sclk_period : time := 10 ns;
   constant data : std_logic_vector(15 downto 0) := "1010010111110000"; 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DirectTemperatureReader PORT MAP (
          Clock => Clock,
          SPI_In => SPI_In,
          SPI_Out => SPI_Out,
          SPI_Cs => SPI_Cs,
          SPI_Sclk => SPI_Sclk,
          LCD_DataOut => LCD_DataOut,
          LCD_ReadWrite => LCD_ReadWrite,
          LCD_Enable => LCD_Enable,
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
 
   -- SPI_Sclk_process :process
   -- begin
	-- 	SPI_Sclk <= '0';
	-- 	wait for SPI_Sclk_period/2;
	-- 	SPI_Sclk <= '1';
	-- 	wait for SPI_Sclk_period/2;
   -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      loop

         wait until falling_edge(SPI_Cs);

         for i in 0 to 15 loop
   
            SPI_In <= data(i);
            wait for 280 ns;
   
         end loop;

      end loop;

      -- insert stimulus here 

      wait;
   end process;

END;
