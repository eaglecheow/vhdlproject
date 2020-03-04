----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:36:07 03/02/2020 
-- Design Name: 
-- Module Name:    DirectTemperatureReader - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DirectTemperatureReader is
    Port ( Clock : in  STD_LOGIC;
           SPI_In : in  STD_LOGIC;
           SPI_Out: out STD_LOGIC;
           SPI_Cs : out STD_LOGIC;
           SPI_Sclk: out STD_LOGIC;
           LCD_DataOut : out  STD_LOGIC_VECTOR (3 downto 0);
           LCD_ReadWrite : out  STD_LOGIC;
           LCD_Enable : out  STD_LOGIC;
           LCD_RegisterSelect : out  STD_LOGIC;
           LED_An : out  STD_LOGIC_VECTOR (5 downto 0);
           LED_Ca : out  STD_LOGIC;
           LED_Cb : out  STD_LOGIC;
           LED_Cc : out  STD_LOGIC;
           LED_Cd : out  STD_LOGIC;
           LED_Ce : out  STD_LOGIC;
           LED_Cf : out  STD_LOGIC;
           LED_Cg : out  STD_LOGIC;
           RS232_Txd : out  STD_LOGIC);
end DirectTemperatureReader;

architecture Behavioral of DirectTemperatureReader is

    component SPIController is
        
        port (
            SCLK: out std_logic;
            MISO: in std_logic;
            MOSI: out std_logic;
            CS: out std_logic;
            CLK: in std_logic;
            DOUT: out std_logic_vector(15 downto 0)
        );
        
    end component;

    component DataConverter is

        port (
            DataIn: in std_logic_vector(15 downto 0);
            DataOut: out std_logic_vector(23 downto 0);
            Clock: in std_logic
        );

    end component;

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


    signal binaryData: std_logic_vector(15 downto 0) := (others => '0');
    signal bcdData: std_logic_vector(23 downto 0) := (others => '0');

begin

    u1: LCDController port map (
        Clock => Clock,
        DataIn => bcdData,
        DataOut => LCD_DataOut,
        LcdEnable => LCD_Enable,
        LcdRegisterSelect => LCD_RegisterSelect,
        LcdReadWrite => LCD_ReadWrite
    );

    u2: LEDController port map (
        Clock => Clock,
        DataIn => bcdData,
        An => LED_An,
        Ca => LED_Ca,
        Cb => LED_Cb,
        Cc => LED_Cc,
        Cd => LED_Cd,
        Ce => LED_Ce,
        Cf => LED_Cf,
        Cg => LED_Cg
    );

    u3: RS232Txd port map (
        Clk => Clock,
        Reset => '0',
        DataIn => bcdData,
        Txd => RS232_Txd
    );

    u4: SPIController port map (
        SCLK => SPI_Sclk,
        MISO => SPI_In,
        MOSI => SPI_Out,
        CS => SPI_Cs,
        CLK => Clock,
        DOUT => binaryData
    );

    u5: DataConverter port map (
        DataIn => binaryData,
        DataOut => bcdData,
        Clock => Clock
    );


end Behavioral;

