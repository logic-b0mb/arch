//test bench for add-shift multiplier
module mul_add_shift3_tb;

reg [3:0] a, b;
reg start;
wire [7:0] prod;


//display variables
initial			
$monitor ("a = %b, b = %b, prod = %b",
					a, b, prod);


//apply input vectors
initial	
begin
		#0			start = 1'b0;
					a = 4'b0110;					b = 4'b0110;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 4'b0010;					b = 4'b0110;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 4'b0111;					b = 4'b0101;
		#10		start = 1'b1;
		#10		start = 1'b0;				

		#10		a = 4'b0111;					b = 4'b0111;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 4'b0101;					b = 4'b0101;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 4'b0111;					b = 4'b0011;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		a = 4'b0100;					b = 4'b0110;
		#10		start = 1'b1;
		#10		start = 1'b0;

		#10		$stop;
end

//instantiate the module into the test bench
mul_add_shift3 inst1 (
		.a(a),
		.b(b),
		.prod(prod),
		.start(start)
		);

endmodule
