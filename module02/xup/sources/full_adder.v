`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2016 08:00:50 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(a,b,cin,
                sum,cout);
    input a;
    input b;
    input cin;
    output sum;
    output cout;
    reg sum, cout;
    
    always @(a or b or cin)
      begin
        sum=a^b^cin;
        cout=(a&b)|(a&cin)|(b&cin);
      end 
endmodule
