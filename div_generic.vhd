library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY div_generic IS
	generic(fclk : 		integer 	  := 50000;  --Frecuencia del reloj de la FPGA (kHz).
				data_rate : integer	  := 100);	 --Velocidad de comunicación deseada (kbps).
	PORT (clk_in: in 		std_logic;
			reset: in 		std_logic;
			clk_out: out 	std_logic);
	END div_generic;

ARCHITECTURE structure OF div_generic IS
	constant divisor : 	integer 		:=(fclk/8)/data_rate;
	signal count   : 		integer 		range 0 to divisor;
	signal estado  : 		std_logic 	:='0';
	BEGIN

	PROCESS(clk_in, reset)
	
	
	BEGIN
			IF(reset = '0') THEN
				count <= 0;
				estado <= '0';
				ELSE
				IF (clk_in'EVENT AND clk_in='1') THEN
					count <= count + 1;
					
					IF(count = divisor) THEN
					estado <= not estado;
					
					END IF;
				END IF;
			END IF;
	END PROCESS;
			clk_out <= estado;
END structure;