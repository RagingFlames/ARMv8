module ALU_LEGv8(A, B, FS, C0, F, status);
		input [63:0]A, B;
		input C0;
		input [4:0]FS; //use least significant bits for a_invert and b_invert
		
		// FS[0] is going to Ainvert, FS[1] is going to be Binvert, FS[4:2] output mux(000) (0-4, 0-3, 0-2) 000 - AND, 001 - OR, 010 - ADD, 011 - XOR,
		// 100 - shiftl, 101 shift R
		
		output [63:0]F;
		output [3:0]status;
		
		wire [63:0] A_signal, B_signal;
		
	assign A_signal = FS[0] ? ~A:A; //mux selecting between A or ~A
	assign B_signal = FS[1] ? ~B:B; //...B or ~B
		
		wire Z, N, C, V;
		assign status = {V, C, N, Z};
		assign N = F[63];
		assign Z = (F == 64'b0) ? 1'b1 : 1'b0;
		assign V = ~(A_signal[63] ^ B_signal[63]) & (F[63] ^ A_signal[63]);
		
		wire [63:0] and_out, or_out, xor_out, add_out, shift_left, shift_right;
		
		assign and_out = A_signal & B_signal;
		assign or_out = A_signal | B_signal;
		assign xor_out = A_signal ^ B_signal;

	CLA_64bit adder_inst(add_out, C, A_signal, B_signal, C0);
		//Adder adder_inst(A_signal, B_signal, C0, add_out, C);
    //In the case of catastrophic CLA problems, restore the line above
		
		shifter shift_inst(A, B[5:0], shift_left, shift_right);
		
		Mux8to1Nbit main_mux(F, FS[4:2], and_out, or_out, add_out, xor_out, shift_left, shift_right, 64'b0, 64'b0);
		
		endmodule
		
module Adder(A, B, C_in, S, C_out);
			input [63:0]A, B;
			
			input C_in;
			
			output [63:0]S;
			output C_out;
			
			
			assign {C_out, S} = A + B + C_in;
			
endmodule

			
