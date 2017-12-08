 module enemy_ball(
					input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					//input 		  is_collision,
					input [9:0]X,Y,//coordinates of ball
					input [9:0]size,// size of ball
					input [9:0]x_step,y_step,// speed of ball
               output logic  is_eball1,is_eball2,is_eball3,gameover,
					output logic[31:0] escore
					// Whether current pixel belongs to ball or background 
					//output logic [9:0]  Size,					//ball size
					//output logic [9:0]  BallX,BallY
              );
     

    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=800;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=525;     // Bottommost point on the Y axis
	 
	 parameter [9:0] Ball_X1_Center=480;  // Center position on the X axis
    parameter [9:0] Ball_Y1_Center=360;  // Center position on the Y axis
	 parameter [9:0] Ball_X1_Center=120;  // Center position on the X axis
    parameter [9:0] Ball_Y1_Center=240;  // Center position on the Y axis
	 parameter [9:0] Ball_X1_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y1_Center=60;  // Center position on the Y axis
	 
    logic [9:0] Ball_X_Step=1;      // Step size on the X axis
    logic [9:0] Ball_Y_Step=1;      // Step size on the Y axis
    logic [9:0] Ball_Size = 6;        // Ball size
    
    logic [9:0] Ball_X1_Pos, Ball_X1_Motion, Ball_Y1_Pos, Ball_Y1_Motion;
    logic [9:0] Ball_X1_Pos_in, Ball_X1_Motion_in,Ball_Y1_Pos_in, Ball_Y1_Motion_in;
	 logic [9:0] Ball_X1_Step_in, Ball_Y1_Step_in;  
	 logic [9:0] BallX1,BallY1;
	 
	 logic [9:0] Ball_X2_Pos, Ball_X2_Motion, Ball_Y2_Pos, Ball_Y2_Motion;
    logic [9:0] Ball_X2_Pos_in, Ball_X2_Motion_in,Ball_Y2_Pos_in, Ball_Y2_Motion_in;
	 logic [9:0] Ball_X2_Step_in, Ball_Y2_Step_in;  
	 logic [9:0] BallX2,BallY2;
	 
	 logic [9:0] Ball_X3_Pos, Ball_X3_Motion, Ball_Y3_Pos, Ball_Y3_Motion;
    logic [9:0] Ball_X3_Pos_in, Ball_X3_Motion_in,Ball_Y3_Pos_in, Ball_Y3_Motion_in;
	 logic [9:0] Ball_X3_Step_in, Ball_Y3_Step_in;  
	 logic [9:0] BallX3,BallY3;
	 
	 
	 logic is_collision ;
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX1, DistY1,Size1;
    assign DistX1 = DrawX - Ball_X1_Pos;
    assign DistY1 = DrawY - Ball_Y1_Pos;
    assign Size1 = Ball_Size1;
	 assign BallX1 = Ball_X1_Pos;
	 assign BallY1 = Ball_Y1_Pos;
	 
	 int DistX2, DistY2,Size2;
    assign DistX2 = Draw2 - Ball_X2_Pos;
    assign DistY2 = Draw2 - Ball_Y2_Pos;
    assign Size2 = Ball_Size2;
	 assign BallX2 = Ball_X2_Pos;
	 assign BallY2 = Ball_Y2_Pos;
	 
	 int DistX3, DistY3,Size3;
    assign DistX3 = DrawX - Ball_X3_Pos;
    assign DistY3 = DrawY - Ball_Y3_Pos;
    assign Size3 = Ball_Size3;
	 assign BallX3 = Ball_X3_Pos;
	 assign BallY3 = Ball_Y3_Pos;

	 
    
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
            Ball_X1_Pos <= Ball_X1_Center;  
            Ball_Y1_Pos <= Ball_Y1_Center;
            Ball_X1_Motion <= 10'd0;
            Ball_Y1_Motion <= Ball_Y1_Step;
				Ball_Size1 <= 6;
				
				Ball_X2_Pos <= Ball_X2_Center;  
            Ball_Y2_Pos <= Ball_Y2_Center;
            Ball_X2_Motion <= Ball_X2_Step;
            Ball_Y2_Motion <= 10'd0;
				Ball_Size2 <= 6;
				
				Ball_X3_Pos <= Ball_X3_Center;  
            Ball_Y3_Pos <= Ball_Y3_Center;
            Ball_X3_Motion <= Ball_X3_Step;
            Ball_Y3_Motion <= Ball_Y3_Step;
				Ball_Size3 <= 6;
				is_collision <= 0;
				
				escore <= 0;
        end
//		  else if(frame_clk_rising_edge && is_collision)
//		  begin
//				Ball_X_Pos <= Ball_X_Pos_in;
//            Ball_Y_Pos <= Ball_Y_Pos_in;
//            Ball_X_Motion <= Ball_X_Motion_in;
//            Ball_Y_Motion <= Ball_Y_Motion_in;
//				Ball_Size <= 0;
//  		  end
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
        Ball_X1_Pos_in = Ball_X1_Pos + Ball_X1_Motion;
        Ball_Y1_Pos_in = Ball_Y1_Pos + Ball_Y1_Motion;
		  Ball_X1_Motion_in = Ball_X1_Motion;
        Ball_Y1_Motion_in = Ball_Y1_Motion;
		  
		  Ball_X2_Pos_in = Ball_X2_Pos + Ball_X2_Motion;
        Ball_Y2_Pos_in = Ball_Y2_Pos + Ball_Y2_Motion;
		  Ball_X2_Motion_in = Ball_X2_Motion;
        Ball_Y2_Motion_in = Ball_Y2_Motion;
		  
		  Ball_X3_Pos_in = Ball_X3_Pos + Ball_X3_Motion;
        Ball_Y3_Pos_in = Ball_Y3_Pos + Ball_Y3_Motion;
		  Ball_X3_Motion_in = Ball_X3_Motion;
        Ball_Y3_Motion_in = Ball_Y3_Motion;
		  
		  gameover = 0;
		  

	 //enemy ball motion 

       // Be careful when using comparators with "logic" datatype because compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
    		
			if( (Ball_Y1_Pos + Ball_Size1) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y1_Pos <= (Ball_Y_Min + Ball_Size1) )  // Ball is at the top edge, BOUNCE!
            Ball_Y1_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X1_Pos <= (Ball_X1_Min + Ball_Size1) )  // Ball is at the top edge, BOUNCE!
            Ball_X1_Motion_in = Ball_X1_Step;
		   else if(((BallX1 - X)*(BallX1 - X) + (BallY1 - Y)*(BallY1 - Y)) <= ((6+size)*(6+size)) )
			begin
			   if(size >= 6)
				begin
				Ball_X1_Pos_in = 10000000;
				Ball_Y1_Pos_in = 10000000;
				esocre = escore +1;
				end
				else
				begin
				gameover = 1;
				end
			end
			else if(size < Ball_Size1) begin
			//get closer to ball
					if(X>BallX1)begin
						if(Y>BallY1)begin// go down right 
							Ball_X1_Motion_in = Ball_X1_Step;
							Ball_Y1_Motion_in = Ball_Y1_Step;
						end
						else if(Y<BallY1) begin// go up right 
							Ball_X1_Motion_in = Ball_X1_Step;
							Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);
						end
						else begin//go right
							Ball_X1_Motion_in = Ball_X1_Step;
							Ball_Y1_Motion_in = 0;
						end
					end
					else if(X<BallX1) begin
						if(Y>BallY1)begin//go down left
							Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);
							Ball_Y1_Motion_in = Ball_Y1_Step;
						end
						else if(Y<BallY1) begin// go down left
							Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);
							Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go left
							Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);
							Ball_Y1_Motion_in = 0;			
						end
					end
					else begin
						if(Y>BallY1)begin// go down
							Ball_Y1_Motion_in = Ball_Y1_Step;
							Ball_X1_Motion_in = 0;

						end
						else if (Y<BallY1) begin // go up
							Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);
							Ball_X1_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X1_Motion_in = 4;
							Ball_Y1_Motion_in = 4;
						end
					end
			end
			else if (size >= Ball_Size1 ) begin
			//get away from ball
					if(X>BallX1)begin
						if(Y>BallY1)begin//go up left
							Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);
							Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);
						end
						else if (Y<BallY1)begin//go down left
							Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);
							Ball_Y1_Motion_in = Ball_Y1_Step;
						end
						else begin // go left
							Ball_X1_Motion_in = (~(Ball_X1_Step) + 1'b1);
							Ball_Y1_Motion_in = 0;
						end
					end
					else if(X<BallX1) begin
						if(Y>BallY1)begin//go up right
							Ball_X1_Motion_in = Ball_X1_Step;
							Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);
						end
						else if(Y<BallY1)begin//go down right
							Ball_X1_Motion_in = Ball_X1_Step;
							Ball_Y1_Motion_in = Ball_Y1_Step;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go right 
							Ball_X1_Motion_in = Ball_X1_Step;
							Ball_Y1_Motion_in = 0;
						end
					end
					else begin
						if(Y>BallY1)begin// go up
							Ball_Y1_Motion_in = (~(Ball_Y1_Step) + 1'b1);
							Ball_X1_Motion_in = 0;
						end
						else if(Y<BallY1) begin // go down
							Ball_Y1_Motion_in = Ball_Y1_Step;
							Ball_X1_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X1_Motion_in = 4;
							Ball_Y1_Motion_in = 4;
						end
					end
			end
			else begin
				Ball_Y1_Motion_in = Ball_Y1_Motion;
				Ball_X1_Motion_in = Ball_X1_Motion;
				end
				
				if( (Ball_Y2_Pos + Ball_Size2) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y2_Pos <= (Ball_Y_Min + Ball_Size2) )  // Ball is at the top edge, BOUNCE!
            Ball_Y2_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X2_Pos <= (Ball_X2_Min + Ball_Size2) )  // Ball is at the top edge, BOUNCE!
            Ball_X2_Motion_in = Ball_X2_Step;
		   else if(((BallX2 - X)*(BallX2 - X) + (BallY2 - Y)*(BallY2 - Y)) <= ((6+size)*(6+size)) )
			begin
			   if(size >= 6)
				begin
				esocre = escore +1;
				Ball_X2_Pos_in = 10000000;
				Ball_Y2_Pos_in = 10000000;
				end
				else
				begin
				gameover = 1;
				end
			end
			else if(size < Ball_Size2) begin
			//get closer to ball
					if(X>BallX2)begin
						if(Y>BallY2)begin// go down right 
							Ball_X2_Motion_in = Ball_X2_Step;
							Ball_Y2_Motion_in = Ball_Y2_Step;
						end
						else if(Y<BallY2) begin// go up right 
							Ball_X2_Motion_in = Ball_X2_Step;
							Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);
						end
						else begin//go right
							Ball_X2_Motion_in = Ball_X2_Step;
							Ball_Y2_Motion_in = 0;
						end
					end
					else if(X<BallX2) begin
						if(Y>BallY2)begin//go down left
							Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);
							Ball_Y2_Motion_in = Ball_Y2_Step;
						end
						else if(Y<BallY2) begin// go down left
							Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);
							Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go left
							Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);
							Ball_Y2_Motion_in = 0;			
						end
					end
					else begin
						if(Y>BallY2)begin// go down
							Ball_Y2_Motion_in = Ball_Y2_Step;
							Ball_X2_Motion_in = 0;

						end
						else if (Y<BallY2) begin // go up
							Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);
							Ball_X2_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X2_Motion_in = 4;
							Ball_Y2_Motion_in = 4;
						end
					end
			end
			else if (size >= Ball_Size2 ) begin
			//get away from ball
					if(X>BallX2)begin
						if(Y>BallY2)begin//go up left
							Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);
							Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);
						end
						else if (Y<BallY2)begin//go down left
							Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);
							Ball_Y2_Motion_in = Ball_Y2_Step;
						end
						else begin // go left
							Ball_X2_Motion_in = (~(Ball_X2_Step) + 1'b1);
							Ball_Y2_Motion_in = 0;
						end
					end
					else if(X<BallX2) begin
						if(Y>BallY2)begin//go up right
							Ball_X2_Motion_in = Ball_X2_Step;
							Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);
						end
						else if(Y<BallY2)begin//go down right
							Ball_X2_Motion_in = Ball_X2_Step;
							Ball_Y2_Motion_in = Ball_Y2_Step;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go right 
							Ball_X2_Motion_in = Ball_X2_Step;
							Ball_Y2_Motion_in = 0;
						end
					end
					else begin
						if(Y>BallY2)begin// go up
							Ball_Y2_Motion_in = (~(Ball_Y2_Step) + 1'b1);
							Ball_X2_Motion_in = 0;
						end
						else if(Y<BallY2) begin // go down
							Ball_Y2_Motion_in = Ball_Y2_Step;
							Ball_X2_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X2_Motion_in = 4;
							Ball_Y2_Motion_in = 4;
						end
					end
			end
			else begin
				Ball_Y2_Motion_in = Ball_Y2_Motion;
				Ball_X2_Motion_in = Ball_X2_Motion;
				end

				if( (Ball_Y3_Pos + Ball_Size3) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);  // 3's complement.  
         else if ( Ball_Y3_Pos <= (Ball_Y_Min + Ball_Size3) )  // Ball is at the top edge, BOUNCE!
            Ball_Y3_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);  // 3's complement.  
         else if ( Ball_X3_Pos <= (Ball_X3_Min + Ball_Size3) )  // Ball is at the top edge, BOUNCE!
            Ball_X3_Motion_in = Ball_X3_Step;
		   else if(((BallX3 - X)*(BallX3 - X) + (BallY3 - Y)*(BallY3 - Y)) <= ((6+size)*(6+size)) )
			begin
			   if(size >= 6)
				begin
				Ball_X3_Pos_in = 10000000;
				Ball_Y3_Pos_in = 10000000;
				esocre = escore +1;
				end
				else
				begin
				gameover = 1;
				end
			end
			else if(size < Ball_Size3) begin
			//get closer to ball
					if(X>BallX3)begin
						if(Y>BallY3)begin// go down right 
							Ball_X3_Motion_in = Ball_X3_Step;
							Ball_Y3_Motion_in = Ball_Y3_Step;
						end
						else if(Y<BallY3) begin// go up right 
							Ball_X3_Motion_in = Ball_X3_Step;
							Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);
						end
						else begin//go right
							Ball_X3_Motion_in = Ball_X3_Step;
							Ball_Y3_Motion_in = 0;
						end
					end
					else if(X<BallX3) begin
						if(Y>BallY3)begin//go down left
							Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);
							Ball_Y3_Motion_in = Ball_Y3_Step;
						end
						else if(Y<BallY3) begin// go down left
							Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);
							Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go left
							Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);
							Ball_Y3_Motion_in = 0;			
						end
					end
					else begin
						if(Y>BallY3)begin// go down
							Ball_Y3_Motion_in = Ball_Y3_Step;
							Ball_X3_Motion_in = 0;

						end
						else if (Y<BallY3) begin // go up
							Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);
							Ball_X3_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X3_Motion_in = 4;
							Ball_Y3_Motion_in = 4;
						end
					end
			end
			else if (size >= Ball_Size3 ) begin
			//get away from ball
					if(X>BallX3)begin
						if(Y>BallY3)begin//go up left
							Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);
							Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);
						end
						else if (Y<BallY3)begin//go down left
							Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);
							Ball_Y3_Motion_in = Ball_Y3_Step;
						end
						else begin // go left
							Ball_X3_Motion_in = (~(Ball_X3_Step) + 1'b1);
							Ball_Y3_Motion_in = 0;
						end
					end
					else if(X<BallX3) begin
						if(Y>BallY3)begin//go up right
							Ball_X3_Motion_in = Ball_X3_Step;
							Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);
						end
						else if(Y<BallY3)begin//go down right
							Ball_X3_Motion_in = Ball_X3_Step;
							Ball_Y3_Motion_in = Ball_Y3_Step;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go right 
							Ball_X3_Motion_in = Ball_X3_Step;
							Ball_Y3_Motion_in = 0;
						end
					end
					else begin
						if(Y>BallY3)begin// go up
							Ball_Y3_Motion_in = (~(Ball_Y3_Step) + 1'b1);
							Ball_X3_Motion_in = 0;
						end
						else if(Y<BallY3) begin // go down
							Ball_Y3_Motion_in = Ball_Y3_Step;
							Ball_X3_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X3_Motion_in = 4;
							Ball_Y3_Motion_in = 4;
						end
					end
			end
			else begin
				Ball_Y3_Motion_in = Ball_Y3_Motion;
				Ball_X3_Motion_in = Ball_X3_Motion;
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
        if ( ( DistX1*DistX1 + DistY1*DistY1) <= (Size1 * Size1))
            is_eball1 = 1'b1;
        else
            is_eball1= 1'b0;
		  if ( ( DistX1*DistX1 + DistY1*DistY1) <= (Size1 * Size1))
            is_eball2 = 1'b1;
        else
            is_eball2= 1'b0;
		  if ( ( DistX1*DistX1 + DistY1*DistY1) <= (Size1 * Size1))
            is_eball3 = 1'b1;
        else
            is_eball3= 1'b0;
        
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
        
    end
    
endmodule
