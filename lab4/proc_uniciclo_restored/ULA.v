// fazer esse isdef para os outros blocos

//`ifdef UNICICLO
module ULA(
	input          [3:0]  iControl,
   input signed [31:0] iA, 
   input signed [31:0] iB,
   output          [31:0] oResult, 
	output 			oZero
);

assign oZero = (oResult == 32'b0);

always @(*)
begin
	case(iControl)
		4'b0000 : oResult <= iA & iB; // essa eh a op de and
		4'b0001 : oResult <= iA | iB; // essa eh a op de or
		4'b0010 : oResult <= iA + iB; // essa eh a op de add
		4'b0110 : oResult <= iA - iB; // essa eh a op de sub
		4'b0111 : oResult <= (iA < iB) ? 32'b1 : 32'b0; // essa eh a op de zero (slt)
		default: oResult <= 32'b0;
	endcase
end

endmodule
//`elseif MULTICICLO
//
//
//`else 		// PIPELINE
//
//`endif