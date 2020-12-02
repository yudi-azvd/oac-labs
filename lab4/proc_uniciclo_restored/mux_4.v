module mux_4(
	input iEsc,
	input reg [31:0] iA, iB,
	output reg [31:0] oSaida
);

always @(*)
begin
	case(iEsc)
	2'b00 : oSaida <= iA;
	2'b01 : oSaida <= iB;
	default : oSaida <= 32'b0;
	endcase
end

endmodule
