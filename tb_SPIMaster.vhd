--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:28:23 02/17/2020
-- Design Name:   
-- Module Name:   C:/Users/user/Desktop/VHLDProject/Attempt3/tb_SPIMaster.vhd
-- Project Name:  Attempt3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SPIMaster
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
 
ENTITY tb_SPIMaster IS
END tb_SPIMaster;
 
ARCHITECTURE behavior OF tb_SPIMaster IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SPIMaster
    PORT(
         SCLK : OUT  std_logic;
         MISO : IN  std_logic;
         MOSI : OUT  std_logic;
         CS : OUT  std_logic;
         CLK : IN  std_logic;
         DOUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal MISO : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal SCLK : std_logic;
   signal MOSI : std_logic;
   signal CS : std_logic;
   signal DOUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
--   constant SCLK_period : time := 10 ns;
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SPIMaster PORT MAP (
          SCLK => SCLK,
          MISO => MISO,
          MOSI => MOSI,
          CS => CS,
          CLK => CLK,
          DOUT => DOUT
        );

   -- Clock process definitions
--   SCLK_process :process
--   begin
--		SCLK <= '0';
--		wait for SCLK_period/2;
--		SCLK <= '1';
--		wait for SCLK_period/2;
--   end process;
 
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

--      wait for SCLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
