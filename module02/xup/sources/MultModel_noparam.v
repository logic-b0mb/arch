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


module MultModel(
    a, //Number a
    b, //Number b
    q //Multiplication Output
    );
    input [7:0] a;// 4 bit input
    input [7:0] b;// 4 bit input
    output [15:0] q;// 8 bit output
    reg [15:0] q;
    
    always @(a or b)
    begin
      q<= a*b;
    end
endmodule
