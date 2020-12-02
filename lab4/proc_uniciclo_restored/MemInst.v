module MemInst(
	input wire iCLK,
	input [31:0] iLeInst,
	output [31:0] oInst
);

reg [31:0] BI[0:255];

integer i;

initial 
begin
	for(i = 0; i <= 255; i = i + 1)
		BI[i] = 32'b0;

	BI[0] = 32'h00052283;	// lw t0, 0(a0)        
	BI[1] = 32'h0045a303;	// lw t1, 4(a1)            # t1 = 6; a1 vai ser carregado com endr de memoria. 
	BI[2] = 32'h006303b3;	// add t2, t1, t1        # t2 = 6 + 6   = 12
	BI[3] = 32'h40538e33;	// sub t3, t2, t0        # t3 = 12 - 1  = 11
	BI[4] = 32'h0062feb3;	// and    t4, t0, t1        # t4 = 1 AND 6 = 0b0000
	BI[5] = 32'h0062ef33;	// or    t5, t0, t1        # t5 = 1 OR 6  = 0b0111
	BI[6] = 32'h0062afb3; 	// slt t6, t0, t1        # t6 = 1 < 6 ? = 1
	BI[7] = 32'h01c000ef;	// jal ra, A_LABEL        
// EQUALS:
	BI[8] = 32'h00628063;	//  beq t0, t1, EQUALS     # t0 deve ser diferente de t1
	BI[9] = 32'h01c5a023;	// sw t3, 0(a1)                 # data_1[0] = 0b0111 = 11
	BI[10] = 32'h01d5a223;	// sw t4, 4(a1)                 # data_1[1] = 0b0111 = 0
	BI[11] = 32'h01e5a423;	// sw t5, 8(a1)                 # data_1[2] = 0b0111 = 7
	BI[12] = 32'h01f5a623;	// sw t6, 12(a1)                 # data_1[3] = 0b0111 = 1
	BI[13] = 32'h008000ef;	// jal ra, EXIT
// A_LABEL:	
	BI[14] = 32'hfe5284e3;	// beq t0, t0, EQUALS
// EXIT:
	BI[15] = 32'h00000533;	// add a0, zero, zero
	BI[16] = 32'h000005b3;	// add a1, zero, zero    
end

assign oInst = BI[iLeInst>>2];

endmodule 