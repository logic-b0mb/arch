`timescale 1ns / 1ps

module i2f (clk, valid, d1, d2, a1, a2, p_lost); // convert integer to float
    input clk, valid;                 // clk and valid
    input  [31:0] d1, d2;             // integer
    output [31:0] a1, a2;             // float
    output        p_lost;             // precision lost
    
    wire sign = d1[31];               // sign
    wire [31:0] f5 = sign ? -d1 : d1; // absolute
    wire [31:0] f4,f3,f2,f1,f0;
    wire [4:0] sa;                    // shift amount (to 1.f)

    assign sa[4] = ~| f5[31:16]; // 16-bit 0
    assign f4 = sa[4]? {f5[15:0],16'b0} : f5;
    assign sa[3] = ~| f4[31:24]; // 8-bit 0
    assign f3 = sa[3]? {f4[23:0], 8'b0} : f4;
    assign sa[2] =~| f3[31:28];  // 4-bit 0
    assign f2 = sa[2]? {f3[27:0], 4'b0} : f3;
    assign sa[1] = ~| f2[31:30]; // 2-bit 0
    assign f1 = sa[1]? {f2[29:0], 2'b0} : f2;
    assign sa[0] = ~| f1[31];    // 1-bit 0
    assign f0 = sa[0]? {f1[30:0], 1'b0} : f1;
    assign p_lost = |f0[7:0];    // not 0
    
    wire [22:0] fraction = f0[30:8];          // f0[31] = 1, hidden bit
    wire [7:0]  exponent = 8'h9e - {3'h0,sa}; // 0x9e = 158 = 127 + 31
    
    assign a1 = (d1 == 0)? 0 : {sign,exponent,fraction};
    
    floating_point_0 fp_instan (
        .aclk(clk),
        .s_axis_a_tvalid(valid),
        .s_axis_a_tdata(d2),
        .m_axis_result_tdata(a2)
    );
endmodule