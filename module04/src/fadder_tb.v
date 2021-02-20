/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/
`timescale 1ns/1ns
module fadder_tb;
    reg  [31:0] a, b;
    reg         sub;
    reg   [1:0] rm;
    wire [31:0] s;
    fadder fa (a,b,sub,rm,s);
    initial begin
        // test 1
            rm  = 0;
            sub = 1;
            a   = 32'h440e11ec; // 568.28d
            b   = 32'h4311c7ae; // 145.78d
        #10 rm  = 2'h1;
        #10 rm  = 2'h2;
        #10 rm  = 2'h3;
        #10 rm  = 2'h0;
            sub = 0;
        #10 rm  = 2'h1;
        #10 rm  = 2'h2;
        #10 rm  = 2'h3;
        #10 rm  = 2'h0;
        
        // test 2
            sub = 1;
            a   = 32'h41074bc7; // 8.456d
            b   = 32'h41ae3d71; // 21.78d
        #10 rm  = 2'h1;
        #10 rm  = 2'h2;
        #10 rm  = 2'h3;
        #10 rm  = 2'h0;
            sub = 0;
        #10 rm  = 2'h1;
        #10 rm  = 2'h2;
        #10 rm  = 2'h3;
        #10 rm  = 2'h0;
    end
endmodule
