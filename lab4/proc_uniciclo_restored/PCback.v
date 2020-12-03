module PCback (
	input iCLK, iEscrevePC,
	input [31:0] iPC,
	output [31:0] oPC
);

always @(posedge iCLK)
begin
	if(iEscrvePC)
	begin
		oPC <= iPC;
	end
end

endmodule 