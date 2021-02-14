`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2021 12:12:36 PM
// Design Name: 
// Module Name: Divide_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Divide_tb(


    );
    reg clk;
    reg reset;
    reg start;
    reg [31:0] A; //Dividend
    reg [31:0] B; //Divisor
    wire [31:0] D; //Quotient;
    wire [31:0] R; //Remainder
    wire ok; // =1 when ready to get the result
    wire err; //error
   
    Divide div(
                .clk(clk),
                .reset(reset),
                .start(start),
                .A(A),
                .B(B),
                .D(D),
                .R(R),
                .ok(ok),
                .err(err));

    initial begin
        #0  clk=1;
            reset=1;
            start=0;
            A = 32'h07;
            B  = 32'h03;
        #1  reset = 0;
            start = 1;
        #2  start = 0;
        #70 
            A = 32'h0d;
            B  = 32'h05;
           start = 1;
        #2 start = 0;


        #70 
            A = 32'h3c;
            B  = 32'h07;
            start = 1;
         #2 start = 0;
     #70 
            A = 32'h52;
            B  = 32'h06;
         start = 1;
         #2 start = 0;
     #70 
            A = 32'h38;
            B  = 32'h07;
         start = 1;
        #2 start = 0;
      #70 
            A = 32'h64;
            B  = 32'h07;
          start = 1;
        #2 start = 0;
     #70 
            A = 32'h6e;
            B  = 32'h07;
         start = 1;
        #2 start = 0;

       end
       always #1 clk = !clk;
    
        
endmodule