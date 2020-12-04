`ifndef PARAM
	`include "../parameter.v"
`endif

module regA (
	input iCLK,
	input [31:0] iEntrada,
	output [31:0] oSaida
);

initial
begin
	oSaida = ZERO;
end

always @(posedge iCLK)
begin
	oSaida <= iEntrada;
end

endmodule 