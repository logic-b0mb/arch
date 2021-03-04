`timescale 1ns / 1ps
module tb_instmem;

reg [31:0] a;
wire [31:0] inst;

instmem uut(.a(a), .inst(inst));

initial begin
    a = 16;
end

endmodule
