/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/
module mux2x64 (a0,a1,s,y);                    // multiplexer, 64 bits
    input  [63:0] a0, a1;                      // inputs, 64 bits
    input         s;                           // input,   1 bit
    output [63:0] y;                           // output, 64 bits
    assign        y = s ? a1 : a0;             // if (s==1) y=a1; else y=a0;
endmodule
