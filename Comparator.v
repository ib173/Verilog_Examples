module ComparatorStructural(input a1, input a0, input b1, input b0, output gt);
	wire w1, w2, w3, w4, w5;
	not g1(w1, b1);
	not g2(w2, b0);
	and g3(w3, a1, w1);
	and g4(w4, a0, a1, w2);
	and g5(w5, a0, w1, w2);
endmodule

// b

module ComparatorDataflow(input a1, input a0, input b1, input b0, output gt);
	assign gt = (a1 & ~b1) | (a0 & a1 & ~b0) | (a0 & ~b0 & ~b1);
endmodule

// c

module ComparatorTest;
	reg a0, a1, b0, b1;
	wire gt;
	
	// c.1
	ComparatorStructural circuit(a1, a0, b1, b0, gt);
	// c.2
	ComparatorDataflow circuit(a1, a0, b1, b0, gt);

	initial begin
		$monitor("%d a1a0b1b0 = %b%b%b%b, gt = %b", $time, a1, a0, b1, b0, gt);
		#10 {a1, a0, b1, b0} = 0;
		#10 {a1, a0, b1, b0} = 1;
		#10 {a1, a0, b1, b0} = 2;
		#10 {a1, a0, b1, b0} = 3;
		#10 {a1, a0, b1, b0} = 4;
		#10 {a1, a0, b1, b0} = 5;
		#10 {a1, a0, b1, b0} = 6;
		#10 {a1, a0, b1, b0} = 7;
		#10 {a1, a0, b1, b0} = 8;
		#10 {a1, a0, b1, b0} = 9;
		#10 {a1, a0, b1, b0} = 10;
		#10 {a1, a0, b1, b0} = 11;
		#10 {a1, a0, b1, b0} = 12;
		#10 {a1, a0, b1, b0} = 13;
		#10 (a1, a0, b1, b0} = 14;
		#10 (a1, a0, b1, b0} = 15;
	end
endmodule
