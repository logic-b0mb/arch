//test bench for nonrestoring division
module div_nonrestoring_tb;
    //define inputs
    reg [7:0] a;
    reg [3:0] b;
    reg start;
    
    //define output
    wire [7:0] rslt;
    
    //instantiate the module into the test bench
    div_nonrestoring inst1 (.a(a), .b(b), .start(start), .rslt(rslt));
    
    //display variables
    initial
    $monitor ("a = %d, b = %d, quot = %d, rem = %d, start = %d", a, b, rslt[3:0], rslt[7:4], start);
    
    //apply input vectors
    initial
    begin
    	#0		start = 1'b0;
    	
    	// a = 8
    	// b = 10
    	// quot = 0
    	// rem = 10
      			a = 8'b00001000; b = 4'b1010;
   		#10		start = 1'b1;
   		#10		start = 1'b0;
    
        // a = 137
    	// b = 4
    	// quot = 34
    	// rem = 1
   		#10		a = 8'b10001001; b = 4'b0100;
   		#10		start = 1'b1;
   		#10		start = 1'b0;
    
        // a = 221
    	// b = 5
    	// quot = 44
    	// rem = 1
   		#10		a = 8'b11011101; b = 4'b0101;
        #10		start = 1'b1;
    	#10		start = 1'b0;
    
        // a = 127
    	// b = 9
    	// quot = 14
    	// rem = 1
   		#10		a = 8'b01111111; b = 4'b1001;
   		#10		start = 1'b1;
   		#10		start = 1'b0;
   		#10		$finish;
    end
endmodule