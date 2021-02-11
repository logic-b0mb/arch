module carrysave(s,c,a,b);
    output [3:0]s;
    output c;
    input [3:0]a,b;
    wire [2:0]c2,c0;
    fa u1(s[0],c0[0],a[0],b[0],1'b0);
    dff1 u2(c2[0],c0[0],clk);
    fa u3(s[1],c0[1],a[1],b[1],c2[0]);
    dff1 u4(c2[1],c0[1],clk);
    fa u5(s[2],c0[2],a[2],b[2],c2[1]);
    dff1 u6(c2[2],c0[2],clk);
    fa u7(s[3],c,a[3],b[3],c2[2]);
endmodule