//mixed-design for restoring division
module div_restoring (a, b, start, rslt);
input [7:0] a;
input [3:0] b;
input start;
output [7:0] rslt;

wire [3:0] b_bar;

//define internal registers
reg [3:0] b_neg;
reg [7:0] rslt;
reg [3:0] count;

assign b_bar = ~b;

always @ (b_bar)
		b_neg = b_bar + 1;

always @ (posedge start)
begin
		rslt = a;
		count = 4'b0100;

		if ((a!=0) && (b!=0))					//if a or b = 0, exit
			while (count)							//else do while loop
			begin
				rslt = rslt << 1;
				rslt = {(rslt[7:4] + b_neg), rslt[3:0]};
					if (rslt[7] == 1)
						begin
							rslt = {(rslt[7:4] + b), rslt[3:1], 	1'b0};
							count = count - 1;
						end
	
					else
						begin
							rslt = {rslt[7:1], 1'b1};
							count = count - 1;
						end
			end
end

endmodule
