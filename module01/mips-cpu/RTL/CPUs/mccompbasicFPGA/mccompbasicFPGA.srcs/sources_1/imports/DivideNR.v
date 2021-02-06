module div(num,denom,quotient,remainder);
input wire [31:0] num;
input wire [31:0] denom;
output wire [31:0] quotient;
output wire [31:0] remainder;

wire [4:0] numexp;
wire [4:0] denomexp;

wire [31:0] numnormal;
wire [31:0] denomnormal;
wire [31:0] quot;
reg [33:0] reg_x,reg_x1,reg_x2,reg_x3;
reg [31:0] reg_a;
reg [31:0] reg_b;
wire   [65:0] axi =  reg_x * reg_a;               //  xx.xxxxx...x
wire   [65:0] bxi =  reg_x * reg_b;               //  xx.xxxxx...x
wire   [33:0] b34 = ~bxi[64:31] + 1'b1;           //   x.xxxxx...x
wire   [65:0] axi1 =  reg_x1 * reg_a;               //  xx.xxxxx...x
wire   [65:0] bxi1 =  reg_x1 * reg_b;               //  xx.xxxxx...x
wire   [33:0] b341 = ~bxi1[64:31] + 1'b1;           //   x.xxxxx...x
wire   [65:0] axi2 =  reg_x2 * reg_a;               //  xx.xxxxx...x
wire   [65:0] bxi2 =  reg_x2 * reg_b;               //  xx.xxxxx...x
wire   [33:0] b342 = ~bxi2[64:31] + 1'b1;           //   x.xxxxx...x
wire   [65:0] axi3 =  reg_x3 * reg_a;               //  xx.xxxxx...x
wire   [67:0] x68 =  reg_x * b34;                 // xxx.xxxxx...x
wire   [67:0] x681 =  reg_x1 * b341;                 // xxx.xxxxx...x
wire   [67:0] x682 =  reg_x2 * b342;                 // xxx.xxxxx...x
//wire   [67:0] x683 =  reg_x2 * b34;                 // xxx.xxxxx...x

wire    [7:0] x0  =  rom(denomnormal[30:27]);
assign   quot  =  axi3[64:33] + |axi3[32:30];    // rounding up

wire [31:0] newQ;
wire [31:0] R;

// Normalize the numerator and denomiator and track the exponent for each

// count leading zeros for num
count_lead_zero clz1 (
        .in(num), 
        .out(numexp)
    );

// count leading zeros for remainder
count_lead_zero clz2 (
	.in(denom),
        .out(denomexp)
       );

//Now normalize the numerator
	// shift (d, sa, right, arith, sh);
	shift shiftnum (num,numexp,0,0,numnormal); // shift

//Now normalize the denom
	// shift (d, sa, right, arith, sh);
	shift shiftdenom (denom,denomexp,0,0,denomnormal); // shift

// Get the 8 bit 1/b value to start initial X0
 //    wire [7:0] X0=rom(denomnormal[31:28]);
   //  X0=rom(denomnormal[31:28]);
   always@(*) begin
reg_a <= numnormal;                  //   .1xxxx...x
reg_b <= denomnormal;                //   .1xxxx...x
reg_x<= {2'b1,x0,24'b0};             // 01.xxxx0...0
reg_x1 <= x68[66:33];                  // xx.xxxxx...x
reg_x2 <= x681[66:33];
reg_x3 <= x682[66:33];
end

 //    wire [63:0] x1prod=  $signed(denomnormal)*$signed({X0,24'h000000});

  //   wire [127:0] X1=$signed({X0,56'h0000000})*($signed(2)-$signed(x1prod));
 //    wire [63:0] x2prod = $signed(denomnormal)*$signed(X1[127:95]);
 //    wire [127:0] X2=$signed(X1[127:64])*($signed(2)- $signed(x2prod));
 //    wire [63:0] x3prod = $signed(denomnormal)*$signed(X2[127:95]);              
 //    wire [127:0] X3=$signed(X2[127:64])*($signed(2)-$signed(x3prod));
                    
 //    wire [63:0] Q=$signed(numnormal)*$signed(X3[127:95]);

     wire [4:0] offset = $signed(numexp)-$signed(denomexp);
     wire [4:0] coffset = offset-5'b1;
     shift shiftexp(quot,coffset,1,0,newQ);
  //       shift shiftexp(Q[63:32],offset,offset[4],0,newQ);
   wire [63:0] rprod=$signed(denom)*$signed(newQ);
     assign R=$signed(num)-$signed(rprod[31:0]);
      assign quotient=newQ;
      assign remainder=R;



    function  [7:0] rom;                                      // a rom table
        input [3:0] b;
        case (b)
            4'h0: rom = 8'hff;            4'h1: rom = 8'hdf;
            4'h2: rom = 8'hc3;            4'h3: rom = 8'haa;
            4'h4: rom = 8'h93;            4'h5: rom = 8'h7f;
            4'h6: rom = 8'h6d;            4'h7: rom = 8'h5c;
            4'h8: rom = 8'h4d;            4'h9: rom = 8'h3f;
            4'ha: rom = 8'h33;            4'hb: rom = 8'h27;
            4'hc: rom = 8'h1c;            4'hd: rom = 8'h12;
            4'he: rom = 8'h08;            4'hf: rom = 8'h00;
        endcase
    endfunction
endmodule
