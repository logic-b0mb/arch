`timescale 1ns / 1ps

module tb_i2f();
    reg clk, valid;
    reg  [31:0] d1, d2;
    wire [31:0] a1, a2;
    wire p_lost;

    i2f uut(.clk(clk), .valid(valid), .d1(d1), .d2(d2), .a1(a1), .a2(a2), .p_lost(p_lost));

    parameter PERIOD = 10;

    always #PERIOD clk = ~clk;
    initial begin
        clk = 0;
        d1 = 0;
        d2 = 0;
        valid = 0;
        
        #PERIOD;
        d1 = 5;
        d2 = 5;
        valid = 1;
        
        #PERIOD valid = 0;
    
        #200;
        d1 = 145;
        d2 = 145;
        valid = 1;
        
        #PERIOD valid = 0;
        
        #200;
        d1 = -71;
        d2 = -71;
        valid = 1;
        
        #PERIOD valid = 0;
        
        #200;
        d1 = 33;
        d2 = 33;
        valid = 1;
        
        #200;
        $finish;
    end
endmodule