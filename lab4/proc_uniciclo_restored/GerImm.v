module GerImm(
	input [31:0]iInst,
	output logic [31:0]oSaida
);

wire [6:0]OPCODE;
wire [2:0]FUNCT3;

assign OPCODE = iInst[6:0];
assign FUNCT3 = iInst[14:12];

always @(*)
begin
	case(OPCODE)
		7'b1101111 : oSaida <= {{12{iInst[31]}}, iInst[19:12], iInst[20], iInst[30:21]}; // JAL
		7'b0100011 : oSaida <= {{20{iInst[31]}}, iInst[31:25], iInst[11:7]}; // store
		7'b0000011 : oSaida <= {{20{iInst[31]}}, iInst[31:20]}; // load
		7'b1100011 : oSaida <= {{20{iInst[31]}}, iInst[7], iInst[30:25], iInst[11:8]}; // beq
		default: oSaida <= 32'b0;
	endcase
end

endmodule 