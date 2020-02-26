----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:09 02/26/2020 
-- Design Name: 
-- Module Name:    hwtest_Display - Behavioral 
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

entity hwtest_Display is
    port (
        Clock : in STD_LOGIC;
        LCD_DataOut : out STD_LOGIC_VECTOR (3 downto 0);
        LCD_Enable : out STD_LOGIC;
        LCD_ReadWrite : out STD_LOGIC;
        LCD_RegisterSelect : out STD_LOGIC;
        LED_An : out STD_LOGIC_VECTOR (5 downto 0);
        LED_Ca : out STD_LOGIC;
        LED_Cb : out STD_LOGIC;
        LED_Cc : out STD_LOGIC;
        LED_Cd : out STD_LOGIC;
        LED_Ce : out STD_LOGIC;
        LED_Cf : out STD_LOGIC;
        LED_Cg : out STD_LOGIC;
        RS232_Txd : out STD_LOGIC);
end hwtest_Display;

architecture Behavioral of hwtest_Display is

    component LCDController

        port (
            Clock : in std_logic;
            DataIn : in std_logic_vector(23 downto 0);
            DataOut : out std_logic_vector(3 downto 0);
            LcdEnable, LcdRegisterSelect, LcdReadWrite : out std_logic
        );

    end component;

    component LEDController is

        port (
            Clock : in std_logic;
            DataIn : in std_logic_vector(23 downto 0);
            An : out std_logic_vector(5 downto 0);
            Ca, Cb, Cc, Cd, Ce, Cf, Cg : out std_logic
        );

    end component;

    component RS232Txd is

        port (
            DataIn : in std_logic_vector(23 downto 0);
            Clk, Reset : in std_logic;
            Txd : out std_logic
        );

    end component;

begin

    u1 : LCDController port map(
        Clock => Clock,
        DataIn => "000100100010010101110101",
        DataOut => LCD_DataOut,
        LcdEnable => LCD_Enable,
        LcdRegisterSelect => LCD_RegisterSelect,
        LcdReadWrite => LCD_ReadWrite
    );

    u2 : LEDController port map(
        Clock => Clock,
        DataIn => "000100100010010101110101",
        An => LED_An,
        Ca => LED_Ca,
        Cb => LED_Cb,
        Cc => LED_Cc,
        Cd => LED_Cd,
        Ce => LED_Ce,
        Cf => LED_Cf,
        Cg => LED_Cg
    );

    u3 : RS232Txd port map(
        Clk => Clock,
        Reset => '0',
        DataIn => "000100100010010101110101",
        Txd => RS232_Txd
    );

end Behavioral;