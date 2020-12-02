module RegInst(
	input iCLK, 
	input escreveIR,
	input [31:0] iEntrada,
	output oSaida
);

always @(posedge iCLK)
begin
	if(escreveIR)
		oSaida <= iEntrada;
end

endmodule 