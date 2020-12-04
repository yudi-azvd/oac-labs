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
	MDI[0] = 32'h00052283;	// lw t0, 0(a0)        
	MDI[1] = 32'h0045a303;	// lw t1, 4(a1)            # t1 = 6; a1 vai ser carregado com endr de memoria. 
	MDI[2] = 32'h006303b3;	// add t2, t1, t1        # t2 = 6 + 6   = 12
	MDI[3] = 32'h40538e33;	// sub t3, t2, t0        # t3 = 12 - 1  = 11
	MDI[4] = 32'h0062feb3;	// and    t4, t0, t1        # t4 = 1 AND 6 = 0b0000
	MDI[5] = 32'h0062ef33;	// or    t5, t0, t1        # t5 = 1 OR 6  = 0b0111
	MDI[6] = 32'h0062afb3; 	// slt t6, t0, t1        # t6 = 1 < 6 ? = 1
	MDI[7] = 32'h01c000ef;	// jal ra, A_LABEL        
// EQUALS:
	MDI[8] = 32'h00628063;	//  beq t0, t1, EQUALS     # t0 deve ser diferente de t1
	MDI[9] = 32'h01c5a023;	// sw t3, 0(a1)                 # data_1[0] = 0b0111 = 11
	MDI[10] = 32'h01d5a223;	// sw t4, 4(a1)                 # data_1[1] = 0b0111 = 0
	MDI[11] = 32'h01e5a423;	// sw t5, 8(a1)                 # data_1[2] = 0b0111 = 7
	MDI[12] = 32'h01f5a623;	// sw t6, 12(a1)                 # data_1[3] = 0b0111 = 1
	MDI[13] = 32'h008000ef;	// jal ra, EXIT
// A_LABEL:	
	MDI[14] = 32'hfe5284e3;	// beq t0, t0, EQUALS
// EXIT:
	MDI[15] = 32'h00000533;	// add a0, zero, zero
	MDI[16] = 32'h000005b3;	// add a1, zero, zero 
	
	MDI[20] = 32'b1;			// valor inicializado hardcoded para o valor de a0
	MDI[21] = 32'd2;			
	MDI[22] = 32'd3;
	MDI[23] = 32'd4;
	MDI[24] = 32'd5;			// valor inicializado hardcoded para o valor de a1
	MDI[25] = 32'd6;
	MDI[26] = 32'd7;
	MDI[27] = 32'd8;
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
