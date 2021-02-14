/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/

`timescale 1ns/1ns

module goldschmidt_tb;
    reg  [31:0] a;
    reg  [31:0] b;
    reg         start;
    reg         clk,clrn;
    wire [31:0] q;
    wire        busy;
    wire        ready;
    wire  [2:0] count;
    wire [31:0] yn;
    
    goldschmidt div (a,b,start,clk,clrn,q,busy,ready,count,yn);
    
    initial begin
        // a = 8
       	// b = 10
       	// quot = 0
       	// rem = 10
           clrn  = 0;
           start = 0;
           clk   = 1;
           a = 32'b00000000000000000000000000001000;
           b = 32'b00000000000000000000000000001010;
       #25 clrn  = 1;
           start = 1;
       
       // a = 221
       // b = 5
       // quot = 44
       // rem = 1
       #50 clrn  = 0;
           start = 0;
           clk   = 1;
           a = 32'b00000000000000000000000011011101;
           b = 32'b00000000000000000000000000000101;
       #25 clrn  = 1;
           start = 1;

       #50   
       $finish;
    end
    always #25 clk = !clk;
endmodule
