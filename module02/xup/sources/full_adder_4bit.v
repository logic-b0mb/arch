`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2016 08:00:50 PM
// Design Name: 
// Module Name: full_adder_4bit
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


module full_adder_4bit(a,b,cin,sum,cout);
    input [3:0] a;
    input [3:0] b;
    input cin;
    output [3:0] sum;
    output cout;
    wire c1,c2,c3;
    
    //instantiate 1-bit adders
    full_adder FA0(a[0],b[0],cin,sum[0],c1);
    full_adder FA1(a[1],b[1],cin,sum[1],c2);
    full_adder FA2(a[2],b[2],cin,sum[2],c3);
    full_adder FA3(a[3],b[3],cin,sum[3],cout);
endmodule
