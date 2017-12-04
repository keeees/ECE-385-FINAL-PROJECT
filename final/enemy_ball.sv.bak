 module enemy_ball(
					input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input 		  is_collision,
					input [9:0]  X,Y,//coordinates of ball
					input size,// size of ball
					input x_step,y_step,// speed of ball
               output logic  is_ball,             // Whether current pixel belongs to ball or background 
					//output logic [9:0]  Size,					//ball size
					output logic [9:0]  BallX,BallY
              );
     
    parameter [9:0] Ball_X_Center=480;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=360;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    logic [9:0] Ball_X_Step=1;      // Step size on the X axis
    logic [9:0] Ball_Y_Step=1;      // Step size on the Y axis
    logic [9:0] Ball_Size = 6;        // Ball size
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
	 logic [9:0] Ball_X_Step_in, Ball_Y_Step_in;  
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
        end
		  else if(frame_clk_rising_edge && is_collision)
		  begin
				Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				Ball_Size <= Ball_Size + 1;
  		  end
        else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				if( Ball_Size == 6'b100000)
					Ball_Size <= 4;
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    always_comb
    begin
	 
        // Update the ball's position with its motion
        Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
    
	 //enemy ball motion 
	 if(Ball_Size >size) begin
	 //get closer to ball
			if(X>BallX)begin
				if(Y>BallY)begin
					Ball_X_Motion_in = Ball_X_Step;
					Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);// ball is in up right position
				end
				else begin
					Ball_X_Motion_in = Ball_X_Step;
					Ball_Y_Motion_in = Ball_Y_Step;// ball is in down right position
				end
			end
			else begin
				if(Y>BallY)begin
					Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
					Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);// ball is in up left position
				end
				else begin
					Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
					Ball_Y_Motion_in = Ball_Y_Step;// ball is in down left position
			//Ball_X_Step = (Y-BallY)/(X-BallX)
				end
			end
	 end
	 else begin
	 //get away from ball
			if(X>BallX)begin
				if(Y>BallY)begin
					Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
					Ball_Y_Motion_in = Ball_Y_Step;// ball is in up right position
				end
				else begin
					Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
					Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);// ball is in down right position
				end
			end
			else begin
				if(Y>BallY)begin
					Ball_X_Motion_in = Ball_X_Step;
					Ball_Y_Motion_in = Ball_Y_Step;// ball is in up left position
				end
				else begin
					Ball_X_Motion_in = Ball_X_Step;
					Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);// ball is in down left position
			//Ball_X_Step = (Y-BallY)/(X-BallX)
				end
			end
	 end
       // Be careful when using comparators with "logic" datatype because compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
    		
			if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
			else begin
				Ball_Y_Motion_in = Ball_Y_Motion;
				Ball_X_Motion_in = Ball_X_Motion;
				end

	  
		  
		  		  			
  
//			
			
        // TODO: Add other boundary conditions and handle keypress here.
        
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #2/2:
          Notice that Ball_Y_Pos is updated using Ball_Y_Motion. 
          Will the new value of Ball_Y_Motion be used when Ball_Y_Pos is updated, or the old? 
          What is the difference between writing
            "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;" and 
            "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;"?
          How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
          Give an answer in your Post-Lab.
    **************************************************************************************/
        
        // Compute whether the pixel corresponds to ball or background
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
        
    end
    
endmodule
