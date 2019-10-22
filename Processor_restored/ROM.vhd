library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;         -- Needed for shift

entity rom is
    Port ( A : in   std_logic_vector (31 downto 0);
           D : out  std_logic_vector (31 downto 0));
end rom;

architecture Behavioral of rom is
  signal W : unsigned(31 downto 0);

  -- The ROM is represented as an array
  --
  -- TODO: change the value 7 to reflect the size of your ROM. In this
  -- there are 8 words, numbered 0 to 7.
  --
  type rom_type is array (0 to 17) of std_logic_vector (31 downto 0);   
  
  -- These are the contents of the ROM in 32 bit hex words
  -- The contents of address zero comes first in this array
  --
  -- TODO: change the contents to be what you want - the array must be
  --       the same size as the value you entered above
  -- 
  constant ROMarr : rom_type :=
   (x"00004820",	-- add $t1, $0, $0
	x"00005020",	-- add $t2, $0, $0
	x"00005820",	-- add $t3, $0, $0
	x"200c0064",	-- addi $t4, $0, 100
	--loop:
	x"ac09fff0",	--	sw $t1, 0xFFFFFFF0
	x"114c0009",	-- beq $t2, $t4, reset
	x"00004820",	-- add $t1, $0, $0
	x"214a0001",	-- addi $t2, $t2, $0
	x"01405820",	-- add $t3, $t2, $0
	x"0800000a",	-- j square
	-- square:
	x"1160fff9",	-- beq $t3, $0, loop
	x"012a4820",	-- add $t1, $t1, $t2
	x"20010001",	-- subi $t3, $t3, 1
	x"01615822",	-- 
	x"0800000a",	-- j square
	-- reset:
	x"00004820",	-- add $t1, $0, $0
	x"00005020",	-- add $t2, $0, $0
	x"08000004");	-- j loop

  
  
--  ( x"00004820",	-- add $t1, $0, $0
--    x"200a0009",  -- addi $t2, $0, 9
--	 -- loop:
--    x"ac09fff0",  -- sw $t1, 0xFFFFFFF0
--    x"112a0002",  -- beq $t1, $t2, reset
--    x"21290001",  -- addi, $t1, $t1, 1
--    x"08000002",  -- j loop
--	 -- reset:
--    x"00004820",  -- add $t1, $0, $0
--    x"08000002"); -- j loop



begin
  W <= shift_right(unsigned(A), 2); -- The address is in bytes and we want a word address
  D <= ROMarr(to_integer(W));       -- Get the value from the array
end Behavioral;
