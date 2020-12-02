module PC(
	input iCLK,
	input [31:0] iEnt,
	output [31:0] oSaida
);

initial
begin
	oSaida = 32'h00400000;
end

always @(posedge iCLK)
begin
	oSaida <= iEnt;
end

endmodule 