----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:52:58 02/20/2020 
-- Design Name: 
-- Module Name:    BCDToLCDEncoding - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCDToLCDEncoding is
    port (
        BcdIn : in STD_LOGIC_VECTOR (3 downto 0);
        LcdOut : out STD_LOGIC_VECTOR (7 downto 0));
end BCDToLCDEncoding;

architecture Behavioral of BCDToLCDEncoding is

begin

    LcdOut <= "0011" & BcdIn;
    
end Behavioral;