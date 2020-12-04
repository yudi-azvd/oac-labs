`ifndef PARAM
	`include "../parameter.v"
`endif

module PCback (
	input iCLK, iEscrevePC,
	input [31:0] iPC,
	output [31:0] oPC
);

initial
begin
	oPC = ZERO;
end

always @(posedge iCLK)
begin
	if(iEscrevePC)
	begin
		oPC <= iPC;
	end
end

endmodule 