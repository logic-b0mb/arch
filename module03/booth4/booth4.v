//mixed-design for the Booth multiply algorithm
module booth4 (a, b, prod);


input [7:0] a, b;
output [15:0] prod;


wire [7:0] a, b;
wire [15:0] prod;


wire [7:0] a_bar;


//define internal wires
wire [15:0] a_ext_pos;
wire [15:0] a_ext_neg;

//define internal registers
reg [7:0] a_neg;
reg [15:0] pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8;

//test b[1:0] --------------------------------------
assign a_bar = ~a;

always @ (a_bar)
    a_neg = a_bar + 1;

//define 16-bit multiplicand and 2s comp of multiplicand
assign a_ext_pos = {{8{a[7]}}, a};
assign a_ext_neg = {{8{a_neg[7]}}, a_neg};

always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[1:0])
			2'b00 :
				begin
					pp1 = 16'h00;
					pp2 = 16'h00;
				end

			2'b01 :
				begin
					pp1 = a_ext_neg;
					pp2 = {{7{a[7]}}, a[7:0], 1'b0};
				end

			2'b10 :
				begin
					pp1 = 16'h00;
					pp2 = {a_ext_neg[14:0], 1'b0};
				end




			2'b11 :
				begin
					pp1 = a_ext_neg;
					pp2 = 16'h00;
				end
		endcase

end

//test b[2:1] --------------------------------------
always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[2:1])
			2'b00: pp3 = 16'h00;

			2'b01: pp3 = {a_ext_pos[13:0], 2'b00};

			2'b10: pp3 = {a_ext_neg[13:0], 2'b00};

			2'b11: pp3 = 16'h00;
		endcase
end

//test b[3:2] --------------------------------------
always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[3:2])
			2'b00: pp4 = 16'h00;

			2'b01: pp4 = {a_ext_pos[12:0], 3'b000};

			2'b10: pp4 = {a_ext_neg[12:0], 3'b000};

			2'b11: pp4 = 16'h00;
		endcase
end

//test b[4:3] ---------------------------------------
always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[4:3])
			2'b00: pp5 = 16'h00;

			2'b01: pp5 = {a_ext_pos[11:0], 4'b0000};

			2'b10: pp5 = {a_ext_neg[11:0], 4'b0000};

			2'b11: pp5 = 16'h00;
		endcase
end

//test b[5:4] ---------------------------------------
always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[5:4])
			2'b00: pp6 = 16'h00;

			2'b01: pp6 = {a_ext_pos[10:0], 5'b00000};

			2'b10: pp6 = {a_ext_neg[10:0], 5'b00000};

			2'b11: pp6 = 16'h00;
		endcase
end

//test b[6:5] ---------------------------------------
always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[6:5])
			2'b00: pp7 = 16'h00;

			2'b01: pp7 = {a_ext_pos[9:0], 6'b000000};

			2'b10: pp7 = {a_ext_neg[9:0], 6'b000000};

			2'b11: pp7 = 16'h00;
		endcase
end

//test b[7:6] ---------------------------------------
always @ (b or a_ext_pos or a_ext_neg)
begin
		case (b[7:6])
			2'b00: pp8 = 16'h00;

			2'b01: pp8 = {a_ext_pos[8:0], 7'b0000000};

			2'b10: pp8 = {a_ext_neg[8:0], 7'b0000000};

			2'b11: pp8 = 16'h00;
		endcase
end

assign prod = pp1 + pp2 + pp3 + pp4 + pp5 + pp6 + pp7 + pp8;

endmodule