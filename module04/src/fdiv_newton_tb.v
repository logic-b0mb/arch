/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/
`timescale 1ns/1ns
module fdiv_newton_tb;
    reg  [31:0] a, b;
    reg   [1:0] rm;
    reg         fdiv;
    reg         ena;
    reg         clk, clrn;
    wire [31:0] s;
    wire        busy;
    wire        stall;
    wire  [4:0] count;
    wire [25:0] reg_x;
    fdiv_newton fdn (a,b,rm,fdiv,ena,clk,clrn,s,busy,stall,count,reg_x);
    initial begin
             clk  = 1;
             clrn = 0;
             rm   = 0;
             ena  = 1;
             fdiv = 0;
             a    = 32'h440e11ec; // 568.28d
             b    = 32'h4311c7ae; // 145.78d
        #2   clrn = 1;
        #13  fdiv = 1;
        #154 fdiv = 0;
        #71  a    = 32'h41074bc7; // 8.456d
             b    = 32'hc1ae3d71; // -21.78d
        #15  fdiv = 1;
        #154 fdiv = 0;
    end
    always #5 clk = !clk;
endmodule
