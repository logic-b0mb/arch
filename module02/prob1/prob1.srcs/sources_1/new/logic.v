`timescale 1ns / 1ps

module logic(
    input A, B, C,
    output F, G
    );
    
    assign F = (A & B) | C;
    assign G = (~A | B) & ~C;
endmodule
