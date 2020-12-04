
`define MULTICICLO
//`define PIPELINE

`ifndef PARAM
`define PARAM

parameter

// 	Usar nos arquivos q tiver q usar parametros
//	`ifndef PARAM
//		`include "../parameter.v"
//	`endif

	ON = 32'b1,
	OFF = 32'b0,
	ZERO = 32'h0,

// campo Opcode

	OPC_LOAD			= 7'b0000011,
	OPC_STORE		= 7'b0100011,
	OPC_RTYPE		= 7'b0110011,
	OPC_BRANCH 		= 7'b1100011,
	OPC_JAL			= 7'b1101111,
	
// funct7

	FUNCT7_ADD		= 7'b0000000,
	FUNCT7_SUB		= 7'b0100000,
	FUNCT7_SLT		= 7'b0000000,
	FUNCT7_AND 		= 7'b0000000,
	FUNCT7_OR		= 7'b0000000,

// funct3

	FUNCT3_LW		= 3'b010,
	FUNCT3_SW 		= 3'b010,
	FUNCT3_ADD 		= 3'b000,
	FUNCT3_SUB		= 3'b000,
	FUNCT3_SLT 		= 3'b010,
	FUNCT3_AND		= 3'b111,
	FUNCT3_OR		= 3'b110,
	FUNCT3_BEQ		= 3'b000,
	
// estados do multiciclo

	ST_FETCH 		= 6'd00,
//	ST_FETCH1		= 6'd01,
	ST_DECODE		= 6'd01,
	ST_LWSW			= 6'd02,
	ST_SW				= 6'd05,
//	ST_SW1			= 6'd05,
	ST_LW				= 6'd03,
	ST_LW1			= 6'd04,
//	ST_LW2			= 6'd08,
	ST_RTYPE			= 6'd06,
	ST_ULAREGWRITE	= 6'd07,
	ST_BRANCH		= 6'd08,
	ST_JAL			= 6'd09,

FOCAFOFA = 32'hF0CAF0FA;

`endif