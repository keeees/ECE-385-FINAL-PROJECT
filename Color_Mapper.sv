//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.

module  color_mapper ( input        frame_clk,Reset,
							  input        is_ball,is_aiball,is_eball1,is_eball2,is_eball3,            // Whether current pixel belongs to ball 
							  input 			is_rball[0:15],		//   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,     // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
      					 
							  input [9:0]  BallX,BallY,
							  input start_signal,// start signal active high 	
							  input gameover_signal,// gameover signal active high
							  input ingame_signal//ingame signal active high
							  
                      );
    
    logic [7:0] Red, Green, Blue,b_red,b_green,b_blue,go_red,go_blue,go_green,st_blue,st_green,st_red,ball_red,ball_green,ball_blue;


    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
//	 logic [9:0] DrawX_plus_progress;
//	 assign DrawX_plus_progress = DrawX + progress;
//	 
	 
//	 always_comb
//	 begin:Ball_on_proc
//	 				 
//	 if((DrawX_plus_progress >= BallX - 32)&&(DrawX_plus_progress <= BallX +31 )&&(DrawY >= BallY + 31)&&(DrawY >= BallY - 32))
//			is_ball = 1'b1;
//	 else
//	 		is_ball = 1'b0;
//	 
//	 end
    
    // Assign color based on is_ball signal
    always_comb
begin
		if(ingame_signal)
		begin
		  if (is_ball == 1'b1) 
        begin
		  
//            Red = 8'hff;
//            Green = 8'hff;
//            Blue = 8'hff;

				Red = ball_red;
				Green = ball_green;
				Blue = ball_blue;
				
        end
		  else if (is_aiball == 1'b1) 
        begin

            Red = ball_red;
				Green = ball_green;
				Blue = ball_blue;
        end
		  else if (is_eball1 == 1'b1) 
        begin
            Red = 8'd255;
            Green = 8'd255;
            Blue = 8'd0;
//				Red = ball_red;
//				Green = ball_green;
//				Blue = ball_blue;
        end
		  else if (is_eball2 == 1'b1) 
        begin
            Red = 8'd255;
            Green = 8'd0;
            Blue = 8'd255;
//				Red = ball_red;
//				Green = ball_green;
//				Blue = ball_blue;
        end
		  else if (is_eball3 == 1'b1) 
        begin
            Red = 8'd0;
            Green = 8'd255;
            Blue = 8'd255;
//				Red = ball_red;
//				Green = ball_green;
//				Blue = ball_blue;
        end
		  else if(is_rball[0] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[1] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[2] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end

		  else if(is_rball[3] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[4] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[5] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[6] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[7] == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_rball[8] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[9] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[10] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[11] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[12] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[13] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[14] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_rball[15] == 1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
		  end
        else 
        begin
            //Background with nice color gradient
//            Red = b_red;
//            Green = b_green;
//            Blue = b_blue;
				Red = 8'h80;
            Green = 8'h80;
            Blue = 8'h80;
        end
	end
	else if(start_signal)
	begin
		Red = 8'h66;
      Green = 8'h00;
      Blue = 8'hff;
//	Red = st_red;
//   Green = st_green;
//   Blue = st_blue;
	end
	
	else 

	begin
//	Red = go_red;
//   Green = go_green;
//   Blue = go_blue;
			Red = 8'h00;
       Green = 8'h00;
       Blue = 8'h00;
	end
	
end

//	background background(
//	.x(DrawX),
//	.y(DrawY),
//	.R(b_red),
//	.G(b_green),
//	.B(b_blue)
//	);	  
	
//	gameover gameover(
//	.x(DrawX),
//	.y(DrawY),
//	.R(go_red),
//	.G(go_green),
//	.B(go_blue)
//	);	
	
//	start start(
//	.Reset(Reset),       
//	.frame_clk(frame_clk), 
//	.x(DrawX),
//	.y(DrawY),
//	.R(st_red),
//	.G(st_green),
//	.B(st_blue)
//	);	

	
	ball_ani ball_ani(
	.x(DrawX),
	.y(DrawY),
	.R(ball_red),
	.G(ball_green),
	.B(ball_blue)
	);	
endmodule
