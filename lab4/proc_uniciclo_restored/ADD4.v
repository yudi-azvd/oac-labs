module ADD4(
	input wire [31:0] iB,
	output wire [31:0] oSaida
);

assign oSaida = 3'b100 + iB;

endmodule 