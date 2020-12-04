`ifndef PARAM
	`include "../parameter.v"
`endif

module Controlador_multiciclo(
	input iCLK,
	input [31:0] iInst,
	output oEscrevePCCondicional,
	output oEscrevePC,
	output oIouD,
	output oEscreveMem,
	output oLeMem, 
	output oEscreveIR,
	output oEscrevePCBack,
	output oEscreveReg,
	output [2:0] oMemPraReg,
	output [2:0] oOrigPC,
	output [2:0] oULAControl,
	output [2:0] oOrigAULA,
	output [2:0] oOrigBULA,
	output [5:0] oState
);

reg  [5:0] pr_state;
wire [5:0] nx_state;

wire [6:0] Opcode = iInst[6:0];
wire [2:0] Funct3 = iInst[14:12];
wire [6:0] Funct7 = iInst[31:25];

assign oState = pr_state;

reg [4:0] contador;

initial 
begin
	pr_state <= ST_FETCH;
	contador <= 5'd0;
end

always @(posedge iCLK)
begin
	pr_state <= nx_state;	
end

always @(*)
	case (pr_state)
	
		ST_FETCH:		// fetch
		begin 
			oEscreveIR 					<= 1'b1;
			oEscrevePC 					<= 1'b1;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b1;
			oOrigAULA 					<= 3'b010;
			oOrigBULA 					<= 3'b001;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b1;
			oULAControl					<= 3'b010;
			
			nx_state 					<= ST_DECODE;
		end
		
//		ST_FETCH1:		// fetch_1
//		begin
//			oEscreveIR 					<= 1'b1;
//			oEscrevePC 					<= 1'b1;
//			oEscrevePCCondicional 	<= 1'b0;
//			oEscrevePCBack 			<= 1'b1;
//			oOrigAULA 					<= 3'b001;
//			oOrigBULA 					<= 3'b001;
//			oMemPraReg 					<= 3'b000;
//			oOrigPC 						<=	3'b000;
//			oIouD							<= 1'b0;
//			oEscreveReg					<= 1'b0;
//			oEscreveMem					<= 1'b0;
//			oLeMem						<= 1'b1;
//			oULAControl					<= 3'b010; // add
//			
//			nx_state 					<= ST_DECODE;
//		end
		
		ST_DECODE: 		// decode
		begin		
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b011;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'b010; 
			
			case(Opcode)
				OPC_LOAD,
				OPC_STORE: nx_state		<= ST_LWSW;
				OPC_RTYPE: nx_state		<= ST_RTYPE;
				OPC_BRANCH: nx_state		<= ST_BRANCH;
				OPC_JAL:		nx_state		<= ST_JAL;
			endcase
		end
		
		ST_LWSW:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b001;
			oOrigBULA 					<= 3'b010;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'b010; 
			
			case(Opcode)
				OPC_LOAD: nx_state	<= ST_LW;
				OPC_STORE:nx_state	<= ST_SW;
			endcase
		end
		
		ST_LW:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b1;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b1;
			oULAControl					<= 3'b000; 
			
			nx_state 					<= ST_LW1;
		end
		
		ST_LW1:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b010;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b1;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'bx; 
			
			nx_state 					<= ST_FETCH;
		end
		
//		ST_LW2:
//		begin
//			oEscreveIR 					<= 1'b0;
//			oEscrevePC 					<= 1'b0;
//			oEscrevePCCondicional 	<= 1'b0;
//			oEscrevePCBack 			<= 1'b0;
//			oOrigAULA 					<= 3'b000;
//			oOrigBULA 					<= 3'b000;
//			oMemPraReg 					<= 3'b010;
//			oOrigPC 						<=	3'b000;
//			oIouD							<= 1'b0;
//			oEscreveReg					<= 1'b1;
//			oEscreveMem					<= 1'b0;
//			oLeMem						<= 1'b0;
//			oULAControl					<= 3'bx; 
//			
//			nx_state						<= ST_FETCH;
//		end
		
		ST_SW:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b1;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b1;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'bx; 
			
			nx_state						<= ST_FETCH;
		end
		
//		ST_SW1:
//		begin
//			oEscreveIR 					<= 1'b0;
//			oEscrevePC 					<= 1'b0;
//			oEscrevePCCondicional 	<= 1'b0;
//			oEscrevePCBack 			<= 1'b0;
//			oOrigAULA 					<= 3'b000;
//			oOrigBULA 					<= 3'b000;
//			oMemPraReg 					<= 3'b000;
//			oOrigPC 						<=	3'b000;
//			oIouD							<= 1'b0;
//			oEscreveReg					<= 1'b0;
//			oEscreveMem					<= 1'b0;
//			oLeMem						<= 1'b0;
//			oULAControl					<= 3'bx;
//		
//			nx_state						<= ST_FETCH;
//		end
		
		ST_RTYPE:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b001;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			
			nx_state 					<= ST_ULAREGWRITE;
			
			case(Funct7)
				FUNCT7_ADD,
				FUNCT7_SUB:
					case(Funct3)
						FUNCT3_ADD,
						FUNCT3_SUB:
							if(Funct7 == FUNCT7_SUB)	oULAControl <= 3'b110;
							else								oULAControl <= 3'b010;
						FUNCT3_SLT:							oULAControl <= 3'b111;
						FUNCT3_OR:							oULAControl <= 3'b001;
						FUNCT3_AND:							oULAControl <= 3'b000;
					endcase
			endcase
		end
		
		ST_ULAREGWRITE:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b1;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'bx;
			
			nx_state						<= ST_FETCH;
		end
		
		ST_BRANCH:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b1;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b001;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b001;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'b110;
			
			nx_state						<= ST_FETCH;
		end
		
		ST_JAL:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b1;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b001;
			oOrigPC 						<=	3'b001;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b1;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'bx;
		
			nx_state						<= ST_FETCH;
		end
		
		default:
		begin
			oEscreveIR 					<= 1'b0;
			oEscrevePC 					<= 1'b0;
			oEscrevePCCondicional 	<= 1'b0;
			oEscrevePCBack 			<= 1'b0;
			oOrigAULA 					<= 3'b000;
			oOrigBULA 					<= 3'b000;
			oMemPraReg 					<= 3'b000;
			oOrigPC 						<=	3'b000;
			oIouD							<= 1'b0;
			oEscreveReg					<= 1'b0;
			oEscreveMem					<= 1'b0;
			oLeMem						<= 1'b0;
			oULAControl					<= 3'b0;
			
			nx_state 					<= 6'b0;
		end
		
	endcase

	
endmodule 