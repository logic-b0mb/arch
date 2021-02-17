`timescale 1ns / 1ps
module tb_i2f;

reg     [31:0]    d         ;
wire    [31:0]    a         ;
wire              p_lost    ;

i2f uut (
    .d         (    d         ),
    .a         (    a         ),
    .p_lost    (    p_lost    )
);

parameter PERIOD = 10;

initial begin
    $dumpfile("db_tb_i2f.vcd");
    $dumpvars(0, tb_i2f);
    clk = 1'b0;
    #(PERIOD/2);
    forever
        #(PERIOD/2) clk = ~clk;
end

endmodule
