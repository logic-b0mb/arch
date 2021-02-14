//behavioral add-shift multiply
module mul_add_shift3 (a, b, prod, start);

input [3:0] a, b;
input start;
output [7:0] prod;

reg [7:0] prod;
reg [3:0] b_reg;
reg [3:0] count;

always @ (posedge start)
begin
		b_reg = b;
		prod = 0;
		count = 4'b0100;

		if	((a!=0) && (b!=0))
			while (count)
				begin
					prod = {(({4{b_reg[0]}} & a) 
								+ prod[7:4]), prod[3:1]};
				b_reg = b_reg >> 1;
				count = count - 1;
				end
end
endmodule