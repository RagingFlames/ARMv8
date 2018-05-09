module CLA_testbench (); //written 2/4/18
	
	reg [63:0] A, B; //2 main inputs for ALU
	reg Cin;
	
	wire [63:0] Sum;
	wire Cout;
	initial begin
		A <= 64'd0;
		B <= 64'd0;
		Cin <= 1'b0;
	#1024 $stop; 
	end

	always begin
	#5 A <= A + 1'b1; //every 5 ticks
	#5	A <= {32'd0, 16'd0, $random};
	#5	B <= {32'd0, 16'd0, $random};
	#5	Cin <= {$random};
	end

	CLA_64bit dut (Sum, Cout, A, B, Cin); //instantiating CLA module

endmodule
