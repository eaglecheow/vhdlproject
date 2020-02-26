----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:40:26 02/26/2020 
-- Design Name: 
-- Module Name:    hwtest_LEDController - Behavioral 
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

entity hwtest_LEDController is
    port (
        Clock : in STD_LOGIC;
        An : out STD_LOGIC;
        Ca : out STD_LOGIC;
        Cb : out STD_LOGIC;
        Cc : out STD_LOGIC;
        Cd : out STD_LOGIC;
        Ce : out STD_LOGIC;
        Cf : out STD_LOGIC;
        Cg : out STD_LOGIC);
end hwtest_LEDController;

architecture Behavioral of hwtest_LEDController is

    component LEDController is
        port (
            Clock : in std_logic;
            DataIn : in std_logic_vector(23 downto 0);
            An, Ca, Cb, Cc, Cd, Ce, Cf, Cg : out std_logic
        );
    end component;

begin

    u1 : LEDController port map(
        Clock => Clock,
        DataIn => "000100100010010101110101",
        An => An,
        Ca => Ca,
        Cb => Cb,
        Cc => Cc,
        Cd => Cd,
        Ce => Ce,
        Cf => Cf,
        Cg => Cg
    );

end Behavioral;