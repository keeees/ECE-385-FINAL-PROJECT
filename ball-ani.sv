module ball_ani(
					input [9:0] x,
					input [9:0] y,
					output logic [7:0] R,
					output logic [7:0] G,
					output logic [7:0] B
						);
	logic [1:0] pixel;
	logic [0:9][0:9][0:1] matrix;
	always_comb begin
	R=8'h0;
	G=8'h0;
	B=8'h0;
		pixel = matrix[x][y];
		case(pixel)
		2'd0: begin
			R = 8'd66;
			G = 8'd99;
			B = 8'd22;
		end
		2'd1: begin
			R = 8'd150;
			G = 8'd30;
			B = 8'd90;
		end
		2'd2: begin
			R = 8'd200;
			G = 8'd88;
			B = 8'd150;
		end
		2'd3: begin
			R = 8'd100;
			G = 8'd150;
			B = 8'd10;
		end
		
	endcase
		

matrix = '{
'{2'd0, 2'd1, 2'd2, 2'd3,2'd0, 2'd1, 2'd2, 2'd3, 2'd0,2'd1},
'{2'd2, 2'd3, 2'd0, 2'd1,2'd2, 2'd3, 2'd0, 2'd1, 2'd2,2'd3},
'{2'd0, 2'd1, 2'd2, 2'd3,2'd0, 2'd1, 2'd2, 2'd3, 2'd0,2'd1},
'{2'd2, 2'd3, 2'd0, 2'd1,2'd2, 2'd3, 2'd0, 2'd1, 2'd2,2'd3},
'{2'd0, 2'd1, 2'd2, 2'd3,2'd0, 2'd1, 2'd2, 2'd3, 2'd0,2'd1},
'{2'd2, 2'd3, 2'd0, 2'd1,2'd2, 2'd3, 2'd0, 2'd1, 2'd2,2'd3},
'{2'd0, 2'd1, 2'd2, 2'd3,2'd0, 2'd1, 2'd2, 2'd3, 2'd0,2'd1},
'{2'd2, 2'd3, 2'd0, 2'd1,2'd2, 2'd3, 2'd0, 2'd1, 2'd2,2'd3},
'{2'd0, 2'd1, 2'd2, 2'd3,2'd0, 2'd1, 2'd2, 2'd3, 2'd0,2'd1},
'{2'd2, 2'd3, 2'd0, 2'd1,2'd2, 2'd3, 2'd0, 2'd1, 2'd2,2'd3}


};
end
endmodule

















