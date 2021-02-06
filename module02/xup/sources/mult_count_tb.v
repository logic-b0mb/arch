`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2016 01:25:29 PM
// Design Name: 
// Module Name: mult_count_tb
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


module mult_count_tb();
    reg CLK;
    reg CE;
    wire[7:0]Q_1;
    wire [7:0]Q_2;
    wire [7:0] S;
    wire [15:0] q;
     
    system_wrapper DUT(.CE(CE), .CLK (CLK),.Q_1(Q_1), .Q_2(Q_2), .S(S), .q(q));
    // this process setups the free running clok
    initial begin
    CLK=0;
    forever #20 CLK=~CLK;
    end
    // This process block specifies the stimuls
    initial 
    begin
    CE=0;
    #40;
    CE=1;
    end
endmodule