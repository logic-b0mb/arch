`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2016 01:08:20 PM
// Design Name: 
// Module Name: MultModel
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


module MultModel #(parameter SIZE=8)(
    input [SIZE-1:0] a, //Number a
    input [SIZE-1:0] b, //Number b
    output[SIZE+SIZE-1:0] q //Multiplication Output
    );
     reg [SIZE+SIZE-1:0] q;
    
    always @(a or b)
    begin
      q<= a*b;
    end
endmodule
