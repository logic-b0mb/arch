//test bench for nonrestoring division
module div_nonrestoring_tb;

//define inputs
reg [7:0] a;
reg [3:0] b;
reg start;

//define output
wire [7:0] rslt;

//display variables
initial
$monitor ("a = %b, b = %b, quot = %b, rem = %b",
					a, b, rslt[3:0], rslt[7:4]);

//apply input vectors
initial
begin
		#0			start = 1'b0;
					a = 8'b0000_0111;							b = 4'b0011;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 8'b0000_1101;							b = 4'b0101;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 8'b0011_1100;							b = 4'b0111;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 8'b0101_0010;							b = 4'b0110;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 8'b0011_1000;							b = 4'b0111;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 8'b0110_0100;							b = 4'b0111;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 8'b0110_1110;							b = 4'b0111;
		#10		start = 1'b1;
		#10		start = 1'b0;
		#10		$stop;
end

//instantiate the module into the test bench
div_nonrestoring inst1 (
		.a(a),
		.b(b),
		.start(start),
		.rslt(rslt)
		);

endmodule
