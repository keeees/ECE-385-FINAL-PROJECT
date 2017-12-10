 module enemy_ball1(
					input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					//input 		  is_collision,
					input [9:0]X,Y,//coordinates of ball
					input [9:0]size,// size of ball
					input [9:0]x_step,y_step,// speed of ball
					input start_signal,
               output logic  is_eball,gameover,
					output logic[15:0] escore
					// Whether current pixel belongs to ball or background 
					//output logic [9:0]  Size,					//ball size
					//output logic [9:0]  BallX,BallY
              );
				  
     
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=1000;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=800;     // Bottommost point on the Y axis
	 
	 parameter [9:0] Ball_X_Center=2;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=2;  // Center position on the Y axis
	 
	 
    logic [9:0] Ball_X_Step=1;      // Step size on the X axis
    logic [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 
	 logic [9:0] Ball_Size = 6;        // Ball size
	
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in,Ball_Y_Pos_in, Ball_Y_Motion_in;
	 logic [9:0] Ball_X_Step_in, Ball_Y_Step_in;  
	 logic [9:0] BallX,BallY;

	 logic is_collision ;
	 
	 
	 
	 
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
            Ball_Y_Motion <= 10'd0;
				Ball_Size <= 6;
				escore <= 0;
			end	
		  else if(frame_clk_rising_edge && is_collision)
		  begin
				Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				
				escore <= escore +3;
  		  end

        
		  else if(frame_clk_rising_edge && start_signal)
		  begin
            Ball_X_Pos <= Ball_X_Center;  
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= Ball_Y_Motion;
				escore <= 0;
  		  end

        else if (frame_clk_rising_edge )        // Update only at rising edge of frame clock
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
			
				//if( Ball_Size == 6'b100000)
					//Ball_Size <= 4;
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    
	 always_comb
    begin
		  Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
		  Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
		  gameover = 0;
		  is_collision =0;

		  
		  if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
				
		   else if(((BallX - X)*(BallX - X) + (BallY - Y)*(BallY - Y)) <= ((6+size)*(6+size)) )
			begin
			   if(size > 6)
				begin
				Ball_X_Pos_in = 9'b111111111;
				Ball_Y_Pos_in = 9'b111111111;
				is_collision =1;
				
				end
				else
				begin
				gameover = 1;
				end
			end
			else if(size < 6) begin
			//get closer to ball
					if(X>BallX)begin
						if(Y>BallY)begin// go down right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else if(Y<BallY) begin// go up right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else begin//go right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 0;
						end
					end
					else if(X<BallX) begin
						if(Y>BallY)begin//go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else if(Y<BallY) begin// go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = 0;			
						end
					end
					else begin
						if(Y>BallY)begin// go down
							Ball_Y_Motion_in = Ball_Y_Step;
							Ball_X_Motion_in = 0;

						end
						else if (Y<BallY) begin // go up
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
							Ball_X_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X_Motion_in = 4;
							Ball_Y_Motion_in = 4;
						end
					end
			end
			else if (size >= 6 ) begin
			//get away from ball
					if(X>BallX)begin
						if(Y>BallY)begin//go up left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else if (Y<BallY)begin//go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else begin // go left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = 0;
						end
					end
					else if(X<BallX) begin
						if(Y>BallY)begin//go up right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else if(Y<BallY)begin//go down right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = Ball_Y_Step;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 0;
						end
					end
					else begin
						if(Y>BallY)begin// go up
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
							Ball_X_Motion_in = 0;
						end
						else if(Y<BallY) begin // go down
							Ball_Y_Motion_in = Ball_Y_Step;
							Ball_X_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X_Motion_in = 4;
							Ball_Y_Motion_in = 4;
						end
					end
			end
			else 
				begin
				Ball_Y_Motion_in = Ball_Y_Motion;
				Ball_X_Motion_in = Ball_X_Motion;
				end
				
	        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size))
            is_eball = 1'b1;
			  else
            is_eball= 1'b0;			
					
	 
	 end
	 
	
    
endmodule




















 module enemy_ball2(
					input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					//input 		  is_collision,
					input [9:0]X,Y,//coordinates of ball
					input [9:0]size,// size of ball
					input start_signal,
					input [9:0]x_step,y_step,// speed of ball
               output logic  is_eball,gameover,
					output logic[15:0] escore
					// Whether current pixel belongs to ball or background 
					//output logic [9:0]  Size,					//ball size
					//output logic [9:0]  BallX,BallY
              );
				  
     
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=100;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=800;     // Bottommost point on the Y axis
	 
	 parameter [9:0] Ball_X_Center=600;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=400;  // Center position on the Y axis
	 
	 
    logic [9:0] Ball_X_Step=1;      // Step size on the X axis
    logic [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 
	 logic [9:0] Ball_Size = 7;        // Ball size
	
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in,Ball_Y_Pos_in, Ball_Y_Motion_in;
	 logic [9:0] Ball_X_Step_in, Ball_Y_Step_in;  
	 logic [9:0] BallX,BallY;

	 logic is_collision ;
	 
	 
	 
	 
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
            Ball_Y_Motion <= 10'd0;
				Ball_Size <= 7;
				escore <=0;
			end
			else if(frame_clk_rising_edge && is_collision)
		  begin
				Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				escore <= escore +3;
  		  end	

        
		   else if(frame_clk_rising_edge && start_signal)
		  begin
            Ball_X_Pos <= Ball_X_Center;  
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= 10'd0;
				escore <= 0;
  		  end

        else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
			
				//if( Ball_Size == 6'b100000)
					//Ball_Size <= 4;
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    
	 always_comb
    begin
		  Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
		  Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
		  gameover = 0;
		  is_collision =0;
		  

		  
		  if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
		   else if(((BallX - X)*(BallX - X) + (BallY - Y)*(BallY - Y)) <= ((7+size)*(7+size)) )
			begin
			   if(size > 7)
				begin
				Ball_X_Pos_in = 9'b111111111;
				Ball_Y_Pos_in = 9'b111111111;
				is_collision =1;
				end
				else
				begin
				gameover = 1;
				end
			end
			else if(size < 7) begin
			//get closer to ball
					if(X>BallX)begin
						if(Y>BallY)begin// go down right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else if(Y<BallY) begin// go up right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else begin//go right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 0;
						end
					end
					else if(X<BallX) begin
						if(Y>BallY)begin//go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else if(Y<BallY) begin// go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = 0;			
						end
					end
					else begin
						if(Y>BallY)begin// go down
							Ball_Y_Motion_in = Ball_Y_Step;
							Ball_X_Motion_in = 0;

						end
						else if (Y<BallY) begin // go up
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
							Ball_X_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X_Motion_in = 3;
							Ball_Y_Motion_in = 3;
						end
					end
			end
			else if (size >= 7 ) begin
			//get away from ball
					if(X>BallX)begin
						if(Y>BallY)begin//go up left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else if (Y<BallY)begin//go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else begin // go left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = 0;
						end
					end
					else if(X<BallX) begin
						if(Y>BallY)begin//go up right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else if(Y<BallY)begin//go down right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = Ball_Y_Step;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 0;
						end
					end
					else begin
						if(Y>BallY)begin// go up
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
							Ball_X_Motion_in = 0;
						end
						else if(Y<BallY) begin // go down
							Ball_Y_Motion_in = Ball_Y_Step;
							Ball_X_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X_Motion_in = 3;
							Ball_Y_Motion_in = 3;
						end
					end
			end
			else 
				begin
				Ball_Y_Motion_in = Ball_Y_Motion;
				Ball_X_Motion_in = Ball_X_Motion;
				end
				
	        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size))
            is_eball = 1'b1;
			  else
            is_eball= 1'b0;			
					
	 
	 end
	 
	
    
endmodule















 module enemy_ball3(
					input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					//input 		  is_collision,
					input start_signal,
					input [9:0]X,Y,//coordinates of ball
					input [9:0]size,// size of ball
					input [9:0]x_step,y_step,// speed of ball
               output logic  is_eball,gameover,
					output logic[15:0] escore
					// Whether current pixel belongs to ball or background 
					//output logic [9:0]  Size,					//ball size
					//output logic [9:0]  BallX,BallY
              );
				  
     
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=1000;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=800;     // Bottommost point on the Y axis
	 
	 parameter [9:0] Ball_X_Center=800;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=0;  // Center position on the Y axis
	 
	 
    logic [9:0] Ball_X_Step=1;      // Step size on the X axis
    logic [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 
	 logic [9:0] Ball_Size = 8;        // Ball size
	
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in,Ball_Y_Pos_in, Ball_Y_Motion_in;
	 logic [9:0] Ball_X_Step_in, Ball_Y_Step_in;  
	 logic [9:0] BallX,BallY;

	 logic is_collision ;
	 
	 
	 
	 
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
            Ball_Y_Motion <= 10'd0;
				Ball_Size <= 8;
				escore <= 0;


        end
		  

		  else if(frame_clk_rising_edge && is_collision)
		  begin
				Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				escore <= escore +3;
  		  end
		  else if(frame_clk_rising_edge && start_signal)
		  begin
            Ball_X_Pos <= Ball_X_Center;  
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= Ball_X_Motion;
            Ball_Y_Motion <= 10'd0;
				escore <= 0;
  		  end
        else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
			
				//if( Ball_Size == 6'b100000)
					//Ball_Size <= 4;
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    
	 always_comb
    begin
		  Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
		  Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
		  gameover = 0;
		  is_collision =0;
		  

		  
		  if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_Y_Pos <= (Ball_Y_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_Y_Motion_in = Ball_Y_Step;
			else if( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the bottom edge, BOUNCE!
            Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
         else if ( Ball_X_Pos <= (Ball_X_Min + Ball_Size) )  // Ball is at the top edge, BOUNCE!
            Ball_X_Motion_in = Ball_X_Step;
		   else if(((BallX - X)*(BallX - X) + (BallY - Y)*(BallY - Y)) <= ((8+size)*(8+size)) )
			begin
			   if(size >8)
				begin
				Ball_X_Pos_in = 9'b111111111;
				Ball_Y_Pos_in = 9'b111111111;
				is_collision =1;
				end
				else
				begin
				gameover = 1;
				end
			end
			else if(size < 8) begin
			//get closer to ball
					if(X>BallX)begin
						if(Y>BallY)begin// go down right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else if(Y<BallY) begin// go up right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else begin//go right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 0;
						end
					end
					else if(X<BallX) begin
						if(Y>BallY)begin//go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else if(Y<BallY) begin// go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = 0;			
						end
					end
					else begin
						if(Y>BallY)begin// go down
							Ball_Y_Motion_in = Ball_Y_Step;
							Ball_X_Motion_in = 0;

						end
						else if (Y<BallY) begin // go up
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
							Ball_X_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X_Motion_in = 5;
							Ball_Y_Motion_in = 5;
						end
					end
			end
			else if (size >= 8 ) begin
			//get away from ball
					if(X>BallX)begin
						if(Y>BallY)begin//go up left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else if (Y<BallY)begin//go down left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = Ball_Y_Step;
						end
						else begin // go left
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
							Ball_Y_Motion_in = 0;
						end
					end
					else if(X<BallX) begin
						if(Y>BallY)begin//go up right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						end
						else if(Y<BallY)begin//go down right
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = Ball_Y_Step;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin //go right 
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 0;
						end
					end
					else begin
						if(Y>BallY)begin// go up
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
							Ball_X_Motion_in = 0;
						end
						else if(Y<BallY) begin // go down
							Ball_Y_Motion_in = Ball_Y_Step;
							Ball_X_Motion_in = 0;
					//Ball_X_Step = (Y-BallY)/(X-BallX)
						end
						else begin//collision?
							Ball_X_Motion_in = 5;
							Ball_Y_Motion_in = 5;
						end
					end
			end
			else 
				begin
				Ball_Y_Motion_in = Ball_Y_Motion;
				Ball_X_Motion_in = Ball_X_Motion;
				end
				
	        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size))
            is_eball = 1'b1;
			  else
            is_eball= 1'b0;			
					
	 
	 end
	 
	
    
endmodule
