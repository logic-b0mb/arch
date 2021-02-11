//behavioral/dataflow nonrestoring division
module div_nonrestoring (a, b, start, rslt);

input [7:0] a;
input [3:0] b;
input start ;
output [7:0] rslt;

wire [3:0] b_bar;

//define internal registers
reg [3:0] b_neg;
reg [7:0] rslt;
reg [3:0] count;
reg part_rem_7;

assign b_bar = ~b;

always @ (b_bar)
		b_neg = b_bar + 1;

always @ (posedge start)
begin
		rslt = a;
		count = 4'b0100;
		part_rem_7 = 1'b0;

		if ((a!=0) && (b!=0))
			begin
				rslt = rslt << 1;

				rslt = {(rslt[7:4] + b_neg), rslt[3:0]};	//2A–B
					if (rslt[7] == 1)
						begin
							rslt = {rslt[7:1], 1'b0};
							part_rem_7 = 1'b1;
							count = count - 1;
						end

					else
						begin
							rslt = {rslt[7:1], 1'b1};
							part_rem_7 = 1'b0;
							count = count - 1;
						end
			end

		while (count)
			begin
				rslt = rslt << 1;
				if (part_rem_7 == 1)
					begin				
						rslt = {(rslt[7:4] + b), rslt[3:0]};	//2A+B
						if (rslt[7] == 1)
							begin
								rslt = {rslt[7:1], 1'b0};
								part_rem_7 = 1'b1;
								count = count - 1;
							end

						else
							begin
								rslt = {rslt[7:1], 1'b1};
								part_rem_7 = 1'b0;
								count = count - 1;
							end
					end

				else
					begin
						rslt = {(rslt[7:4] + b_neg), rslt[3:0]}; //2A–B
						if (rslt[7] == 1)
							begin
								rslt = {rslt[7:1], 1'b0};
								part_rem_7 = 1'b1;
								count = count - 1;
							end

						else
							begin
								rslt = {rslt[7:1], 1'b1};
								part_rem_7 = 1'b0;
								count = count - 1;
							end
					end
			end

	if (rslt[7] == 1)
		rslt = {(rslt[7:4] + b), rslt[3:0]};

end

endmodule
