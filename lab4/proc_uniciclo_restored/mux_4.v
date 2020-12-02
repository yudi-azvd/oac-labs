module mux_4(
	input [1:0] iEsc,
	input reg [31:0] iA, iB, iC, iD,
	output reg [31:0] oSaida
);

always @(*)
begin
	case(iEsc)
	2'b00 : oSaida <= iA;
	2'b01 : oSaida <= iB;
	2'b10 : oSaida <= iC;
	2'b11 : oSaida <= iD;
	default : oSaida <= 32'b0;
	endcase
end

endmodule
