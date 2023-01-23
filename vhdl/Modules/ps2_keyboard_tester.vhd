LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ps2_keyboard_tester IS
	PORT(
		clk	    : in std_logic;
		ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
		ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
		ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
		ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --code received from PS/2
END ps2_keyboard_tester;

ARCHITECTURE behaviour OF ps2_keyboard_tester IS

	component shift_register is
		generic
		(
			NUM_STAGES : natural := 8
		);
		port 
		(
			clk	    : in std_logic;
			enable	: in std_logic;
			reset   : in std_logic;
			sr_in	    : in std_logic;
			sr_out	: out std_logic;
			par_out	: out std_logic_vector (NUM_STAGES - 1 downto 0)
		);
	end component;
	
BEGIN

	shiftreg : shift_register port map (clk, ps2_clk, '0', ps2_data, ps2_code_new, ps2_code);

END behaviour;