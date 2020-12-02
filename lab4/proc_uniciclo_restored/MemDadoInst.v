module MemDadoInst (
	input wire iCLK,
	input [31:0] iEnd,
	input [31:0] iDadoEscrita,
	input wire iEscMem, iLeMem,
	output [31:0] oDado,
	output [31:0] oDebug
);

reg [31:0] MDI[0:255];

integer i;

initial
begin
	for(i = 0; i <= 255; i = i + 1'b1)
		MDI[i] = 32'b0;
	MDI[0] = 32'hFCAF1ADA;
end


always @(posedge iCLK)
begin
	if(iEscMem)
	begin
		MDI[iEnd>>2] <= iDadoEscrita;
		oDebug <= iDadoEscrita;
	end
	else if (iLeMem)
	begin
		oDado <= (iLeMem == 1'b1) ? MDI[iEnd>>2] : 32'b0;
		oDebug <= (iLeMem == 1'b1) ? MDI[iEnd>>2] : 32'b0;
	end
end

endmodule 
