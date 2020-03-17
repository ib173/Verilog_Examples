module MagnitudeComparator4Bit(input[3:0] a, input[3:0] b,output eq,output lt,output gt);
	assign eq = a == b;
	assign lt = a < b;
	assign gt = a > b;
endmodule

module MagnitudeComparator8Bit (input [7:0]a, input [7:0]b, output eq, output gt, output lt);
	wire [3:0]a1, a2, b1, b2;
	wire eq1, eq2, lt1, lt2, gt1, gt2;

	assign a1 = {a[3:0]};
	assign a2 = {a[7:4]};
	assign b1 = {b[3:0]};
	assign b2 = {b[7:4]};
	
	MagnitudeComparator4Bit c1 (a1, b1, eq1, lt1, gt1);
	MagnitudeComparator4Bit c2(a2, b2, eq2, lt2, gt2);

	assign eq = (eq1 & eq2);
	assign lt = (lt2 | (lt1 & eq2));
	assign gt = (~lt & ~eq);
endmodule

module EightBitTB;
	reg [7:0] a, b;
	wire eq, gt, lt;
	MagnitudeComparator8Bit comp1(a, b, eq, gt, lt);

	initial begin
		$monitor("%d a=%b, b=%b, eq=%b, gt=%b, lt=%b", $time, a, b, eq, gt, lt);
		
		#10
			a = 15;
			b = 15;
		#10
			a = 250;
			b = 230;
		#10
			a = 74;
			b = 80;
		#10
			a = 65;
			b = 50;
	end
endmodule	
