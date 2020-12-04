`ifndef PARAM
	`include "../parameter.v"
`endif

module RegInst(
	input iCLK, 
	input escreveIR,
	input [31:0] iEntrada,
	output [31:0] oSaida
);

initial
begin
	oSaida = ZERO;
end

always @(posedge iCLK)
begin
	if(escreveIR)
		oSaida <= iEntrada;
end

endmodule 