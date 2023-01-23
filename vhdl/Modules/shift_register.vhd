-- Quartus II VHDL Template
-- One-bit wide, N-bit long shift register with asynchronous reset

library ieee;
use ieee.std_logic_1164.all;

entity shift_register is

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

end entity;

architecture rtl of shift_register is

	-- Build an array type for the shift register
	type sr_length is array ((NUM_STAGES-1) downto 0) of std_logic;

	-- Declare the shift register signal
	signal sr: sr_length;

begin

	process (clk, reset)
	begin
		if (reset = '1') then
			sr <= (others=>'0');
		elsif (rising_edge(clk)) then

			-- Shift data by one stage; data from last stage is lost
			sr((NUM_STAGES-1) downto 1) <= sr((NUM_STAGES-2) downto 0);

			-- Load new data into the first stage
			sr(0) <= sr_in;
			
			par_out(0) <= sr(NUM_STAGES-8);
			par_out(1) <= sr(NUM_STAGES-7);
			par_out(2) <= sr(NUM_STAGES-6);
			par_out(3) <= sr(NUM_STAGES-5);
			par_out(4) <= sr(NUM_STAGES-4);
			par_out(5) <= sr(NUM_STAGES-3);
			par_out(6) <= sr(NUM_STAGES-2);
			par_out(7) <= sr(NUM_STAGES-1);

		end if;
	end process;

	-- Capture the data from the last stage, before it is lost
	sr_out <= sr(NUM_STAGES-1);

end rtl;
