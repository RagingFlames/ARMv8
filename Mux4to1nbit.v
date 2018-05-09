module Mux4to1nbit (F, S, I00, I01, I02, I03);
Parameter N = 4;
input [1:0] S;
input [n-1:0] I00, I01, I02, I03;
output reg [N-1:0] F;
always @(*) begin
 case (S)
   2'b00: F <= I00;
   2'b01: F <= I01;
   2'b10: F <= I02;
   2'b11: F <= I03;
 endcase 
end
endmodule
