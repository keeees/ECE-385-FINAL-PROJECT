
//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [15:0]  keycode,
					input 		  is_collision1,
					input 		  is_collision2,
               output logic  is_ball,             // Whether current pixel belongs to ball or background 
					//output logic [9:0]  Size,
					//output logic [9:0] progress,					//ball size
					output logic [9:0] BallX,BallY
					
              );
    
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    logic [9:0] Ball_X_Step=4;      // Step size on the X axis
    logic [9:0] Ball_Y_Step=4;      // Step size on the Y axis
    logic [9:0] Ball_Size = 4;        // Ball size
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
	 //logic [9:0] progress_in;

    
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY,Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = Ball_Size;
	 assign BallX = Ball_X_Pos;
	 assign BallY = Ball_Y_Pos;
	
	 
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed;
    logic frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
    end
    assign frame_clk_rising_edge = (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    // Update ball position and motion
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;  
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= Ball_Y_Step;
				Ball_Size <= 4;
				//progress = 0;
        end
		  else if(frame_clk_rising_edge && is_collision1)
		  begin
				Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				if(Ball_X_Step != 1&& Ball_Y_Step != 1 )
				begin
				Ball_X_Step <= Ball_X_Step - 1;
				Ball_Y_Step <= Ball_Y_Step - 1;
				end
				if(Ball_Size != 10)
				Ball_Size <= Ball_Size + 1;
				
  		  end
		  else if(frame_clk_rising_edge && is_collision2)
		  begin
				Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				//if(Ball_X_Step != 10'b0000000001 && Ball_Y_Step != 10'b0000000001 )
				//begin
				if(Ball_X_Step != 6&& Ball_Y_Step != 6 )
			   begin	
				Ball_X_Step <= Ball_X_Step + 1;
				Ball_Y_Step <= Ball_Y_Step + 1;
				end
				
				if(Ball_Size != 1)
				Ball_Size <= Ball_Size - 1;
				
  		  end
        else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
			  
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    always_comb
    begin
	 
        // Update the ball's position with its motion
        Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
    
			
		 // By default, keep motion unchanged
       Ball_X_Motion_in = Ball_X_Motion;
       Ball_Y_Motion_in = Ball_Y_Motion;
		        
       // Be careful when using comparators with "logic" datatype because compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
//    		progress_in = progress;
//			
//		  if((Ball_X_Pos >= progress + 10'd400)&&(Ball_X_Motion[9] == 0))
//		  begin
//		  progress_in = progress + Ball_X_Motion;
//		  end
  
	  
                       	  
		  case(keycode[15:0])
		  16'h001A: // up w
		begin
			Ball_X_Motion_in = 10'b0;
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
		end
		  16'h1A00: // up w
		begin
			Ball_X_Motion_in = 10'b0;
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
			   Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
		end

		
			16'h0016://down s
		 begin
			Ball_X_Motion_in = 10'b0;
				if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
				Ball_Y_Motion_in =Ball_Y_Step;
		 end
			16'h1600://down s
		 begin
			Ball_X_Motion_in = 10'b0;
				if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
			Ball_Y_Motion_in =Ball_Y_Step;
		 end
		 
			16'h0004://left a
		begin
			Ball_Y_Motion_in = 10'b0;
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
			Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
		end
			16'h0400://left a
		begin
			Ball_Y_Motion_in = 10'b0;
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
			Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
		end

			16'h0007://right d
		 begin
			Ball_Y_Motion_in = 10'b0;
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
			Ball_X_Motion_in = Ball_X_Step;
		 end
			16'h0700://right d
		 begin
			Ball_Y_Motion_in = 10'b0;
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else 
			Ball_X_Motion_in = Ball_X_Step;
		 end
		 
		 
			16'h1A07://upright wd
		 begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = Ball_X_Step;
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
				end
		 end
		 16'h071A://upright dw
		 begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = Ball_X_Step;
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
				end
		 end
		 
		 16'h041A://upleft aw
		 	begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1); 
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
				end
		 end
		 16'h1A04://upleft wa
		 	begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1); 
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
				end
		 end		 
		 
		 
		 16'h1604://downleft sa
		 	begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1); 
				Ball_Y_Motion_in = Ball_Y_Step;
				end
		 end		 

		 16'h0416://downleft as
		 begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1); 
				Ball_Y_Motion_in = Ball_Y_Step;
				end
		 end		 
		 
		 16'h0716://downright sd
		 begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = Ball_X_Step; 
				Ball_Y_Motion_in = Ball_Y_Step;
				end
		 end	

		 16'h1607://downright ds
		 begin
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_X_Motion_in = Ball_X_Step; 
				Ball_Y_Motion_in = Ball_Y_Step;
				end
		 end	


		 
		 default:
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
				
		  endcase
		  

        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
				
				

					
//		  if((Ball_X_Pos >= progress + 10'd400)&&(Ball_X_Motion[9] == 0))
//		  begin
//		  progress_in = progress + Ball_X_Motion;
//		  end
//     
        
    end
    
endmodule
