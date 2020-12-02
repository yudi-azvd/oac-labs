// ULA CONTROL TEM Q SER OQ NAS INST Q NSAO TIPO-R?
module Controlador(
	input [31:0] iInst,
	output oBranch, oLeMem, oEscMem, oMemPraReg, oEscReg, oJump,
	output [3:0] oULActrl,
	output oOBULA
);

always @(*)
begin
	case(iInst[6:0])
	
	7'b0110011:  // tipo - R
	begin
		oBranch <= 1'b0;
		oLeMem <= 1'b0;
		oEscMem <= 1'b0;
		oMemPraReg <= 1'b0;
		oEscReg <= 1'b1;
		oJump <= 1'b0;
		oOBULA <= 1'b0;
		
		case(iInst[14:12]) // func 3
			3'b0: 
				case (iInst[31:25]) //func 7
					7'b0100000: // sub
						oULActrl <= 4'b0110;
					7'b0000000: //add
						oULActrl <= 4'b0010;
				endcase
			3'b111: //and
				oULActrl <= 4'b0;
			3'b110: //or
				oULActrl <= 4'b0001;
			3'b010: //slt
				oULActrl <= 4'b0111;					 
		endcase
	end

	7'b1101111 : 	// jal
	begin
		oBranch <= 1'b0;
		oLeMem <= 1'b0;
		oEscMem <= 1'b0;
		oMemPraReg <= 1'b0;
		oULActrl <= 4'bx;
		oEscReg <= 1'b1;
		oJump <= 1'b1;
		oOBULA <= 1'b0;
	end
	
	7'b0100011  :    // SW
	begin
		oBranch <= 1'b0;
		oLeMem <= 1'b0;
		oEscMem <= 1'b1;
		oMemPraReg <= 1'bx;
		oULActrl <= 4'b10;
		oEscReg <= 1'b0;
		oJump <= 1'b0;
		oOBULA <= 1'b01;
	end
	
	7'b0000011  :    //LW
	begin
		oBranch <= 1'b0;
		oLeMem <= 1'b1;
		oEscMem <= 1'b0;
		oMemPraReg <= 1'b1; 
		oULActrl <= 4'b10;
		oEscReg <= 1'b1;
		oJump <= 1'b0;
		oOBULA <= 1'b01; 
	end
	
	7'b1100011 :    // BEQ
	begin
		oBranch <= 1'b1;
		oLeMem <= 1'b0;
		oEscMem <= 1'b0;
		oMemPraReg <= 1'bx;
		oULActrl <= 4'b110;
		oEscReg <= 1'b0;
		oJump <= 1'b0;
		oOBULA <= 1'b0;
	end
	
	default:
	begin
		oBranch <= 1'b0;
		oLeMem <= 1'b0;
		oEscMem <= 1'b0;
		oMemPraReg <= 1'b0;
		oULActrl <= 4'b0;
		oEscReg <= 1'b0;
		oJump <= 1'b0;
		oOBULA <= 1'b0;
	end
	endcase
end
endmodule 