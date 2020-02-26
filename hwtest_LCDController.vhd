----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:18:47 02/26/2020 
-- Design Name: 
-- Module Name:    hwtest_LCDController - Behavioral 
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

entity hwtest_LCDController is
    port (
        Clock : in STD_LOGIC;
        DataOut : out STD_LOGIC_VECTOR (3 downto 0);
        LcdEnable : out STD_LOGIC;
        LcdRegisterSelect : out STD_LOGIC;
        LcdReadWrite : out STD_LOGIC);
end hwtest_LCDController;

architecture Behavioral of hwtest_LCDController is

    component LCDController

        port (
            Clock : in std_logic;
            DataIn : in std_logic_vector(23 downto 0);
            DataOut : out std_logic_vector(3 downto 0);
            LcdEnable, LcdRegisterSelect, LcdReadWrite : out std_logic
        );

    end component;

begin

    u1 : LCDController port map(
        Clock => Clock,
        DataIn => "000100100010010101110101",
        DataOut => DataOut,
        LcdEnable => LcdEnable,
        LcdRegisterSelect => LcdRegisterSelect,
        LcdReadWrite => LcdReadWrite
    );

end Behavioral;