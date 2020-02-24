--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:56:09 02/24/2020
-- Design Name:   
-- Module Name:   C:/Users/user/Desktop/VHLDProject/Attempt3/tb_RS232Txd.vhd
-- Project Name:  Attempt3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RS232Txd
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
 
ENTITY tb_RS232Txd IS
END tb_RS232Txd;
 
ARCHITECTURE behavior OF tb_RS232Txd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS232Txd
    PORT(
         DataIn : IN  std_logic_vector(23 downto 0);
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Txd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn : std_logic_vector(23 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Txd : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS232Txd PORT MAP (
          DataIn => DataIn,
          Clk => Clk,
          Reset => Reset,
          Txd => Txd
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
