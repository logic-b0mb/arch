`timescale 1ns / 1ps

module logic_tb();
    reg A, B, C;
    wire F, G;
    
    logic logic_dut(.A(A), .B(B), .C(C), .F(F), .G(G));
    
    initial begin
        A = 0; B = 0; C = 0;
        #2 A = 0; B = 0; C = 1;
        #2 A = 0; B = 1; C = 0;
        #2 A = 0; B = 1; C = 1;
        #2 A = 1; B = 0; C = 0;
        #2 A = 1; B = 0; C = 1;
        #2 A = 1; B = 1; C = 0;
        #2 A = 1; B = 1; C = 1;
        #2 $finish;
    end
        
endmodule
