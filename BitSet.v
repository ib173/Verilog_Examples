module BitSet(
		input [3:0] x,
		input [1:0] index,
		input value,
		output [3:0] y);
	wire[3:0] w1;

	Decoder2To4 deco(index, w1);

	Mux1Bit2To1 mux1 (x[0], value, w1[0], y[0]);
	Mux1Bit2To1 mux2 (x[1], value, w1[1], y[1]);
	Mux1Bit2To1 mux3 (x[2], value, w1[2], y[2]);
	Mux1Bit2To1 mux4 (x[3], value, w1[3], y[3]);
	
endmodule


module Mux1Bit2To1(
		input enable,
		input in,
		input selector,
		output out);
	assign out = selector ? in : enable;
endmodule

module Decoder2To4(input [1:0] a, output reg [3:0] y);
	always @(a)
	begin
		y[3] = a[1] & a[0];
		y[2] = !a[1] & a[0];
		y[1] = a[1] & !a[0];
		y[0] = !a[1] & !a[0];
	end
endmodule



module BitSetTestBench();
	reg [3:0]x;
	reg [1:0]index;
	reg value;
	wire [3:0]y;
	
	BitSet test(x, index, value, y);

	initial begin
		$monitor ("%d %b %b %b %b", $time, x, index, value, y);
		#10
			x=4'b0000;
			index =2'b00;
			value=1'b1;
		#10
			x=4'b0001;
			index=2'b01;
			value=1'b1;
		#10
			x=4'b1111;
			index=2'b10;
			value=1'b0;
		#10		
			x=4'b1111;
			index=2'b11;
			value=1'b0;
		#10
			$finish;
	end
endmodule
