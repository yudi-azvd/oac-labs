module shiftLeft(
	input [31:0] iEntrada,
	output [31:0] oSaida
);

assign oSaida = iEntrada << 1'b1;

endmodule 