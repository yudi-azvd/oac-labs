module PC(
	input iCLK, // tem clock ?
	input iEscrevePc,
	input [31:0] iEnt,
	output [31:0] oSaida
);

initial
begin
	oSaida = 32'h00400000;
end

always @(posedge iCLK)
begin
	if (iEscrevePc)
	begin
		oSaida <= iEnt;
	end
end

endmodule 