//test bench for add-shift multiplier
module mul_add_shift3_tb;
    reg [3:0] a, b;
    reg start;
    wire [7:0] prod;
    
    //instantiate the module into the test bench
    mul_add_shift3 inst1 (.a(a), .b(b), .prod(prod), .start(start));
    
    //display variables
    initial $monitor ("a = %d, b = %d, prod = %d, start = %d", a, b, prod, start);
    
    //apply input vectors
    initial	begin
    		#0		start = 1'b0;
    		
    		// a = 6
    		// b = 9
    		// prod = 54
    				a = 4'b0110; b = 4'b1001;
    		#10		start = 1'b1;
    		#10		start = 1'b0;
    
            // a = 14
    		// b = 12
    		// prod = 168
    		#10		a = 4'b1110; b = 4'b1100;
    		#10		start = 1'b1;
    		#10		start = 1'b0;
    		
    		// a = 10
    		// b = 11
    		// prod = 110
    		#10		a = 4'b1010; b = 4'b1011;
    		#10		start = 1'b1;
    		#10		start = 1'b0;
    
            // a = 15
    		// b = 15
    		// prod = 225
    		#10		a = 4'b1111; b = 4'b1111;
    		#10		start = 1'b1;
    		#10		start = 1'b0;
    
    		#10		$stop;
    end
endmodule