module alu(
    input [31:0]      srca, srcb,
    input [2:0]       alucontrol,
    output reg [31:0] aluout,
    output zero
    );
	 
  wire[31:0] srcb2, sum, slt;
  
  assign srcb2 = alucontrol[2] ? ~srcb : srcb;
  assign sum   = srca + srcb2 + alucontrol[2];
  assign slt   = sum[31];
  
  always @(*)
    case (alucontrol[1:0])
	   2'b00: aluout = srca & srcb2;
		2'b01: aluout = srca | srcb2;
		2'b10: aluout = sum;
		2'b11: aluout = slt;
    endcase
	 
	 assign zero = (aluout[31:0]==0);
  
endmodule
