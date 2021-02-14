/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/
`timescale 1ns/1ns
module wallace_8x8_product_tb;
    reg  [07:00] a;
    reg  [07:00] b;
    wire [15:00] z;
    wallace_8x8_product test (a,b,z);
    initial begin
        // a = 6
        // b = 9
        // prod = 54
        #10
        a = 32'b00000000000000000000000000000110;
        b = 32'b00000000000000000000000000001001;

        // a = 14
        // b = 12
	   // prod = 168
	   #10
	   a = 32'b00000000000000000000000000001110;
	   b = 32'b00000000000000000000000000001100;
		
	   // a = 10
	   // b = 11
	   // prod = 110
	   #10
	   a = 32'b00000000000000000000000000001010;
	   b = 32'b00000000000000000000000000001011;

       // a = 15
	   // b = 15
	   // prod = 225
	   #10
	   a = 32'b00000000000000000000000000001111;
	   b = 32'b00000000000000000000000000001111;
	   
	   #10 $finish;
    end
endmodule
