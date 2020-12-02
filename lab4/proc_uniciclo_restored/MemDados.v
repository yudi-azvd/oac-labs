module MemDados(
	input wire iCLK,
	input [31:0] iEnd,
	input [31:0] iDadoEscrita,
	input wire iEscMem, iLeMem,
	output [31:0] oDado,
	output [31:0] oDebug
);

reg [31:0] BancoMem[0:255];

reg [8:0] i;	

initial 
begin
	for(i = 0; i <= 255; i = i + 1'b1)
		BancoMem[i] = 32'b0;
	BancoMem[0] = 32'b1;			// valor inicializado hardcoded para o valor de a0
	BancoMem[1] = 32'd2;			
	BancoMem[2] = 32'd3;
	BancoMem[3] = 32'd4;
	BancoMem[4] = 32'd5;			// valor inicializado hardcoded para o valor de a1
	BancoMem[5] = 32'd6;
	BancoMem[6] = 32'd7;
	BancoMem[7] = 32'd8;
end

always @(posedge iCLK)
begin
	if(iEscMem)
	begin
		BancoMem[iEnd>>2] <= iDadoEscrita;
		oDebug <= iDadoEscrita;
	end
end

assign oDado = (iLeMem == 1'b1) ? BancoMem[iEnd>>2] : 32'b0;

endmodule 