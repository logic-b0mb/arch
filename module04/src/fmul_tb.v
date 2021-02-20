/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/
`timescale 1ns/1ns
module fmul_tb;
    reg  [31:0] a, b;
    reg   [1:0] rm;
    wire [31:0] s;
    fmul fm (a,b,rm,s);
    initial begin
            rm = 0;
            a  = 32'h440e11ec; // 568.28d
            b  = 32'h4311c7ae; // 145.78d
        #10 a  = 32'h41074bc7; // 8.456d
            b  = 32'hc1ae3d71; // -21.78d
    end
endmodule
