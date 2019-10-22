module DisplayDriver(
   input WE,
	input CLK,
	input [31:0] A,
	input [31:0] D,
   input RST,
   output reg [7:0] Digit0,
   output reg [7:0] Digit1,
   output reg [7:0] Digit2,
   output reg [7:0] Digit3,
   output reg [7:0] Digit4,
   output reg [7:0] Digit5
   );

	reg [31:0] displayVal;	// Number to display
	reg displayOn = 1;	   // Display on or off
	
	function [7:0] N2D ;
		input [3:0] N;
		begin
			case(N)
				4'b0000: N2D = 8'b11000000; // "0"     
				4'b0001: N2D = 8'b11111001; // "1" 
				4'b0010: N2D = 8'b10100100; // "2" 
				4'b0011: N2D = 8'b10110000; // "3" 
				4'b0100: N2D = 8'b10011001; // "4" 
				4'b0101: N2D = 8'b10010010; // "5" 
				4'b0110: N2D = 8'b10000010; // "6" 
				4'b0111: N2D = 8'b11111000; // "7" 
				4'b1000: N2D = 8'b10000000; // "8"     
				4'b1001: N2D = 8'b10010000; // "9" 
				4'b1010: N2D = 8'b10001000; // "A" 
				4'b1011: N2D = 8'b10000011; // "B" 
				4'b1100: N2D = 8'b11000110; // "C" 
				4'b1101: N2D = 8'b10100001; // "D" 
				4'b1110: N2D = 8'b10000110; // "E" 
				4'b1111: N2D = 8'b10001110; // "F" 
				default: N2D = 8'b11000000; // "0"
			endcase
		end
	endfunction
		
	
	always @(posedge CLK or posedge RST)
   begin
		if (RST == 1)
			displayVal = 0;
		else if (A == 32'hFFFFFFF0 && WE == 1)
			displayVal = D;
		else if (A == 32'hFFFFFFF1 && WE == 1)
			displayOn = D[0];
	end
		

	always @(*)
	begin
		if (displayOn == 0)
			begin
				Digit0 = 8'hFF;
				Digit1 = 8'hFF;
				Digit2 = 8'hFF;
				Digit3 = 8'hFF;
				Digit4 = 8'hFF;
				Digit5 = 8'hFF;			
			end
		else
			begin
				Digit0 = N2D(displayVal & 8'hFF);
				Digit1 = N2D((displayVal >>  4) & 8'hFF);
				Digit2 = N2D((displayVal >>  8) & 8'hFF);
				Digit3 = N2D((displayVal >> 12) & 8'hFF);
				Digit4 = N2D((displayVal >> 16) & 8'hFF);
				Digit5 = N2D((displayVal >> 20) & 8'hFF);			
			end
	end
		
		
		
	endmodule
