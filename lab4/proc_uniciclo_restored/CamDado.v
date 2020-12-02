// AAAAAAAAAAAAAAA TEM MTA COISA FALTANDO TEM Q VER AS COISAS AI EMBAIXO

module CamDado(
	// input e clock
	input wire iCLK, iRST,
	input wire [31:0] iPCInicial,
	
	// Sinais de monitoramento
	output wire [31:0] mPC,
   output wire [31:0] mInst,
	output wire [31:0] mDebug,	 
   output wire [31:0] mRead1,
	output wire [31:0] mRead2,
	output wire [31:0] mRegWrite,
	output wire [31:0] mULA
	
);

// sinais de controle
wire [31:0] wInst;
wire wCRegWrite;
wire wCMemWrite;
wire wCMemRead;
wire [2:0] wCMem2Reg;
wire [2:0] wCOrigPC;
wire [4:0] wCULAControl;
wire [1:0] wCOrigBUla;


// Monitoramento
assign mPC 					= PC;
assign mInst 				= wInst;
assign mDebug				= escolhePC;
assign mRead1				= wRead1;
assign mRead2				= wRead2;
assign mRegWrite			= wRegWrite;
assign mULA					= wULAResult;
//assign mEscolhePC 		= escolhePC;
	

// inicializando o PC

reg [31:0] PC;

initial
begin
	PC = 32'b0;//iPCInicial;		// qualquer coisa a gente troca o endereço inicial para o do riscV
end 

wire [31:0] wPC4			= PC + 32'h00000001; 		// serase ?
wire [31:0] wBranchPC	= PC + wImmediate;

//wire [4:0] wRs1 			= wInst[19:15];
//wire [4:0] wRs2			= wInst[24:20];
//wire [4:0] wRd				= wInst[11:7];
//wire [2:0] wFunct3 		= wInst[14:12];
// wire [6:0] wOpcode	= wInst[6:0];

// BR

wire [31:0] wRead1, wRead2;

BancoReg BR0 (
	.iCLK(iCLK),
	.iRST(iRST),
	.iRs1(wRs1),
	.iRs2(wRs2),
	.iRegWrite(wCRegWrite),
	.iWriteRegister(wRd),
	.iWriteData(wRegWrite),
	.oDado1(wRead1),
	.oDado2(wRead2)
);

// gerador de imediato

GerImm IMMGEN0 (
	.iInst(wInst),
	.oSaida(wImmediate)
);

// ULA - Unidade Lógica-Aritmetica

wire [31:0] wULAResult;
wire Zero;

ULA ULA0 (
	.iControl(wCULAControl),
	.iA(wOrigAULA),
	.iB(wOrigBULA),
	.oResult(wULAResult),
	.oZero(Zero)
);

// Controlador

wire SaidaBranch, SaidaJump;

Controlador CTRL0 (
	.iInst(wInst),
	.oBranch(SaidaBranch),
	.oLeMem(wCMemRead),
	.oEscMem(wCMemWrite),
	.oMemPraReg(wCMem2Reg),
	.oEscReg(wCRegWrite),
	.oJump(SaidaJump),
	.oULActrl(wCULAControl),
	.oOBULA(wCOrigBUla)
);


// barramento de instruções

//wire [31:0] ILeInst;
//wire [31:0] ISaidaInst;

// Memória de instrução

MemInst MI0 (
	.iCLK(iCLK),
	.iLeInst(PC),
	.oInst(wInst)
);

// barramento de dados

// memoria de dados

wire [31:0] MemSaida;

MemDados MEMD0 (
	.iCLK(iCLK),
	.iEnd(wULAResult),
	.iDadoEscrita(wRead2),
	.iEscMem(wCMemWrite),
	.iLeMem(wCMemRead),
	.oDado(MemSaida)
);


// multiplexadores

wire [31:0] wOrigBULA;

always @(*)
	case(wCOrigBUla)
		2'b00   : wOrigBULA <= wRead2;
		2'b01   : wOrigBULA <= wImmediate;
		default : wOrigBULA <= 32'b0;
	endcase 

	

wire [31:0] wRegWrite;
	
always @(*)
	case(wCMem2Reg)
		2'b0 : wRegWrite <= wULAResult;
		2'b1 : wRegWrite <= MemSaida;
		default: wRegWrite <= 32'b0;
	endcase 

// fazer um and de oBranch e Zero

wire escolhePC;

and a0 (
	escolhePC,
	oBranch,
	Zero
);

// ESCOLHE SE FAZ PC+4 OU VAI PRO ENDEREÇO DA BRANCH

wire [31:0] wiPC;
always @(*)
begin 
	case(escolhePC)
		1'b0 : wiPC <= wPC4;
		1'b1 : wiPC <= wBranchPC;
	default: wiPC <= 32'b0;
	endcase
end



// A CADA CICLO DE CLOCK ATUALIZA O PC 

always @(posedge iCLK or posedge iRST)
begin
	if (iRST)
		PC <= 32'b0;
	else
		PC <= wiPC;
end
	
endmodule 
