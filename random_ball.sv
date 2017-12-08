module  random_ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk, // The clock indicating a new frame (~60Hz)
					input is_ball,
					input [9:0] BallX,BallY,
					input [9:0] randomx,
					input [9:0] randomy,
                    input [9:0]   DrawX ,
                    input [9:0]   DrawY ,					// Current pixel coordinates
					   //input    isCollision[0:15],
						//input [9:0] Size,
						output logic is_collision1,
						output logic is_collision2,
						//output logic  is_rball 
                  output logic  is_rball[0:15],             // Whether current pixel belongs to ball or background
						output logic[31:0] rscore
              );
    

    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis

    parameter [9:0] Ball_size=4;        // Ball Size
    
    logic [9:0] Ball_X_Pos[0:15];
    logic [9:0] Ball_Y_Pos[0:15];
	 logic [9:0] Ball_X_Pos_in[0:15];
    logic [9:0] Ball_Y_Pos_in[0:15];
    int   DX[16];
	 int   DY[16];
//	 logic [9:0] Ball_X_Pos;
//    logic [9:0] Ball_Y_Pos;
//	 logic [9:0] Ball_X_Pos_in;
//    logic [9:0] Ball_Y_Pos_in;
//	 int   DX;
//	 int   DY;
    
	 //DX[0],DX[1],DX[2],DX[3],DX[4],DX[5],DX[6],DX[7],DX[8],DX[9],DX[10],DX[11],DX[12],DX[13],DX[14],DX[15];
	 //DY[0],DY[1],DY[2],DY[3],DY[4],DY[5],DY[6],DY[7],DY[8],DY[9],DY[10],DY[11],DY[12],DY[13],DY[14],DY[15];
    
    logic[9:0] rSize;
	 logic[9:0] bSize = 4;
    assign rSize = Ball_size;
	 
	 //assign DX = DrawX - Ball_X_Pos;
	 //assign DY = DrawY - Ball_Y_Pos;
//	 for(int j = 0 ; j < 16 ; j++);
//	 begin
//	 assign DX[i] = DrawX - Ball_X_Pos[i];
//	 assign DY[i] = DrawY - Ball_Y_Pos[i];
//	 end
    assign DX[0] =  DrawX -  Ball_X_Pos[0];
    assign DX[1] =  DrawX -  Ball_X_Pos[1];
    assign DX[2] =  DrawX -  Ball_X_Pos[2];
    assign DX[3] =  DrawX -  Ball_X_Pos[3];
    assign DX[4] =  DrawX -  Ball_X_Pos[4];
    assign DX[5] =  DrawX -  Ball_X_Pos[5];
    assign DX[6] =  DrawX -  Ball_X_Pos[6];
    assign DX[7] =  DrawX -  Ball_X_Pos[7];
    assign DX[8] =  DrawX -  Ball_X_Pos[8];
    assign DX[9] =  DrawX -  Ball_X_Pos[9];
    assign DX[10] = DrawX - Ball_X_Pos[10];
    assign DX[11] = DrawX - Ball_X_Pos[11];
    assign DX[12] = DrawX - Ball_X_Pos[12];
    assign DX[13] = DrawX - Ball_X_Pos[13];
    assign DX[14] = DrawX - Ball_X_Pos[14];
    assign DX[15] = DrawX - Ball_X_Pos[15];
    assign DY[0] =  DrawY -  Ball_Y_Pos[0];
    assign DY[1] =  DrawY -  Ball_Y_Pos[1];
    assign DY[2] =  DrawY -  Ball_Y_Pos[2];
    assign DY[3] =  DrawY -  Ball_Y_Pos[3];
    assign DY[4] =  DrawY -  Ball_Y_Pos[4];
    assign DY[5] =  DrawY -  Ball_Y_Pos[5];
    assign DY[6] =  DrawY -  Ball_Y_Pos[6];
    assign DY[7] =  DrawY -  Ball_Y_Pos[7];
    assign DY[8] =  DrawY -  Ball_Y_Pos[8];
    assign DY[9] =  DrawY -  Ball_Y_Pos[9];
    assign DY[10] = DrawY - Ball_Y_Pos[10];
    assign DY[11] = DrawY - Ball_Y_Pos[11];
    assign DY[12] = DrawY - Ball_Y_Pos[12];
    assign DY[13] = DrawY - Ball_Y_Pos[13];
    assign DY[14] = DrawY - Ball_Y_Pos[14];
    assign DY[15] = DrawY - Ball_Y_Pos[15];
 


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
//		  Ball_X_Pos <=10'd320;
//      Ball_Y_Pos <=10'd20 ;
            Ball_X_Pos[0] <=150 ;  
            Ball_Y_Pos[0] <=300 ;
            Ball_X_Pos[1] <=12 ;  
            Ball_Y_Pos[1] <=7 ;
            Ball_X_Pos[2] <=17 ;  
            Ball_Y_Pos[2] <=58 ;
            Ball_X_Pos[3] <=45 ;  
            Ball_Y_Pos[3] <=69 ;
            Ball_X_Pos[4] <=66 ;  
            Ball_Y_Pos[4] <=88 ;
            Ball_X_Pos[5] <=77 ;  
            Ball_Y_Pos[5] <=92 ;
            Ball_X_Pos[6] <=89 ;  
            Ball_Y_Pos[6] <=120 ;
            Ball_X_Pos[7] <=100 ;  
            Ball_Y_Pos[7] <=130 ;
            Ball_X_Pos[8] <=200 ;  
            Ball_Y_Pos[8] <=66 ;
            Ball_X_Pos[9] <=300 ;  
            Ball_Y_Pos[9] <=99 ;
            Ball_X_Pos[10] <=400 ;  
            Ball_Y_Pos[10] <=89 ;
            Ball_X_Pos[11] <=455 ;  
            Ball_Y_Pos[11] <=300 ;
            Ball_X_Pos[12] <=543 ;  
            Ball_Y_Pos[12] <=400 ;
            Ball_X_Pos[13] <=602 ;  
            Ball_Y_Pos[13] <=38 ;
            Ball_X_Pos[14] <=625 ;  
            Ball_Y_Pos[14] <=5 ;
            Ball_X_Pos[15] <=644 ;  
            Ball_Y_Pos[15] <=79 ;
				bSize <= 4;
				rsocre<= 0;
				end
				
		  else if(frame_clk_rising_edge && is_collision1)
		  begin
		  Ball_X_Pos[0]  <= Ball_X_Pos_in[0];
        Ball_Y_Pos[0]  <= Ball_Y_Pos_in[0];
        Ball_X_Pos[1]  <= Ball_X_Pos_in[1];
        Ball_Y_Pos[1]  <= Ball_Y_Pos_in[1];
        Ball_X_Pos[2]  <= Ball_X_Pos_in[2];
        Ball_Y_Pos[2]  <= Ball_Y_Pos_in[2];
        Ball_X_Pos[3]  <= Ball_X_Pos_in[3];
        Ball_Y_Pos[3]  <= Ball_Y_Pos_in[3];
        Ball_X_Pos[4]  <= Ball_X_Pos_in[4];
        Ball_Y_Pos[4]  <= Ball_Y_Pos_in[4];
        Ball_X_Pos[5]  <= Ball_X_Pos_in[5];
        Ball_Y_Pos[5]  <= Ball_Y_Pos_in[5];
        Ball_X_Pos[6]  <= Ball_X_Pos_in[6];
        Ball_Y_Pos[6]  <= Ball_Y_Pos_in[6];
        Ball_X_Pos[7]  <= Ball_X_Pos_in[7];
        Ball_Y_Pos[7]  <= Ball_Y_Pos_in[7];
        Ball_X_Pos[8]  <= Ball_X_Pos_in[8];
        Ball_Y_Pos[8]  <= Ball_Y_Pos_in[8];
        Ball_X_Pos[9]  <= Ball_X_Pos_in[9];
        Ball_Y_Pos[9]  <= Ball_Y_Pos_in[9];
        Ball_X_Pos[10] <= Ball_X_Pos_in[10];
        Ball_Y_Pos[10] <= Ball_Y_Pos_in[10];
        Ball_X_Pos[11] <= Ball_X_Pos_in[11];
        Ball_Y_Pos[11] <= Ball_Y_Pos_in[11];
        Ball_X_Pos[12] <= Ball_X_Pos_in[12];
        Ball_Y_Pos[12] <= Ball_Y_Pos_in[12];
        Ball_X_Pos[13] <= Ball_X_Pos_in[13];
        Ball_Y_Pos[13] <= Ball_Y_Pos_in[13];
        Ball_X_Pos[14] <= Ball_X_Pos_in[14];
        Ball_Y_Pos[14] <= Ball_Y_Pos_in[14];
        Ball_X_Pos[15] <= Ball_X_Pos_in[15];
        Ball_Y_Pos[15] <= Ball_Y_Pos_in[15];
		  rsocre = rscore +1;
		  if(bSize != 10)
		  bSize <= bSize + 1;
		  end

		  else if(frame_clk_rising_edge && is_collision2)
		  begin
		  Ball_X_Pos[0]  <= Ball_X_Pos_in[0];
        Ball_Y_Pos[0]  <= Ball_Y_Pos_in[0];
        Ball_X_Pos[1]  <= Ball_X_Pos_in[1];
        Ball_Y_Pos[1]  <= Ball_Y_Pos_in[1];
        Ball_X_Pos[2]  <= Ball_X_Pos_in[2];
        Ball_Y_Pos[2]  <= Ball_Y_Pos_in[2];
        Ball_X_Pos[3]  <= Ball_X_Pos_in[3];
        Ball_Y_Pos[3]  <= Ball_Y_Pos_in[3];
        Ball_X_Pos[4]  <= Ball_X_Pos_in[4];
        Ball_Y_Pos[4]  <= Ball_Y_Pos_in[4];
        Ball_X_Pos[5]  <= Ball_X_Pos_in[5];
        Ball_Y_Pos[5]  <= Ball_Y_Pos_in[5];
        Ball_X_Pos[6]  <= Ball_X_Pos_in[6];
        Ball_Y_Pos[6]  <= Ball_Y_Pos_in[6];
        Ball_X_Pos[7]  <= Ball_X_Pos_in[7];
        Ball_Y_Pos[7]  <= Ball_Y_Pos_in[7];
        Ball_X_Pos[8]  <= Ball_X_Pos_in[8];
        Ball_Y_Pos[8]  <= Ball_Y_Pos_in[8];
        Ball_X_Pos[9]  <= Ball_X_Pos_in[9];
        Ball_Y_Pos[9]  <= Ball_Y_Pos_in[9];
        Ball_X_Pos[10] <= Ball_X_Pos_in[10];
        Ball_Y_Pos[10] <= Ball_Y_Pos_in[10];
        Ball_X_Pos[11] <= Ball_X_Pos_in[11];
        Ball_Y_Pos[11] <= Ball_Y_Pos_in[11];
        Ball_X_Pos[12] <= Ball_X_Pos_in[12];
        Ball_Y_Pos[12] <= Ball_Y_Pos_in[12];
        Ball_X_Pos[13] <= Ball_X_Pos_in[13];
        Ball_Y_Pos[13] <= Ball_Y_Pos_in[13];
        Ball_X_Pos[14] <= Ball_X_Pos_in[14];
        Ball_Y_Pos[14] <= Ball_Y_Pos_in[14];
        Ball_X_Pos[15] <= Ball_X_Pos_in[15];
        Ball_Y_Pos[15] <= Ball_Y_Pos_in[15];
		  rsocre = rscore +1;
		  if(bSize != 1)
		  bSize <= bSize - 1;
		  end

		  
        else if (frame_clk_rising_edge)       
        begin
//        Ball_X_Pos  <= Ball_X_Pos_in;
//        Ball_Y_Pos  <= Ball_Y_Pos_in;
        Ball_X_Pos[0]  <= Ball_X_Pos_in[0];
        Ball_Y_Pos[0]  <= Ball_Y_Pos_in[0];
        Ball_X_Pos[1]  <= Ball_X_Pos_in[1];
        Ball_Y_Pos[1]  <= Ball_Y_Pos_in[1];
        Ball_X_Pos[2]  <= Ball_X_Pos_in[2];
        Ball_Y_Pos[2]  <= Ball_Y_Pos_in[2];
        Ball_X_Pos[3]  <= Ball_X_Pos_in[3];
        Ball_Y_Pos[3]  <= Ball_Y_Pos_in[3];
        Ball_X_Pos[4]  <= Ball_X_Pos_in[4];
        Ball_Y_Pos[4]  <= Ball_Y_Pos_in[4];
        Ball_X_Pos[5]  <= Ball_X_Pos_in[5];
        Ball_Y_Pos[5]  <= Ball_Y_Pos_in[5];
        Ball_X_Pos[6]  <= Ball_X_Pos_in[6];
        Ball_Y_Pos[6]  <= Ball_Y_Pos_in[6];
        Ball_X_Pos[7]  <= Ball_X_Pos_in[7];
        Ball_Y_Pos[7]  <= Ball_Y_Pos_in[7];
        Ball_X_Pos[8]  <= Ball_X_Pos_in[8];
        Ball_Y_Pos[8]  <= Ball_Y_Pos_in[8];
        Ball_X_Pos[9]  <= Ball_X_Pos_in[9];
        Ball_Y_Pos[9]  <= Ball_Y_Pos_in[9];
        Ball_X_Pos[10] <= Ball_X_Pos_in[10];
        Ball_Y_Pos[10] <= Ball_Y_Pos_in[10];
        Ball_X_Pos[11] <= Ball_X_Pos_in[11];
        Ball_Y_Pos[11] <= Ball_Y_Pos_in[11];
        Ball_X_Pos[12] <= Ball_X_Pos_in[12];
        Ball_Y_Pos[12] <= Ball_Y_Pos_in[12];
        Ball_X_Pos[13] <= Ball_X_Pos_in[13];
        Ball_Y_Pos[13] <= Ball_Y_Pos_in[13];
        Ball_X_Pos[14] <= Ball_X_Pos_in[14];
        Ball_Y_Pos[14] <= Ball_Y_Pos_in[14];
        Ball_X_Pos[15] <= Ball_X_Pos_in[15];
        Ball_Y_Pos[15] <= Ball_Y_Pos_in[15];
        end            

 
    end

    
    always_comb
    begin
//	 
//	 if ( ( DX*DX + DY*DY) <= (rSize * rSize)) 
//	 begin
//           is_rball = 1'b1;
//
//	 end
//    else
//	 begin
//           is_rball = 1'b0;
//	 end
	 
	 
//	 if(BallX - Ball_X_Pos < 10'd10 && BallY - Ball_Y_Pos < 10'd10  )
//	 begin
//	   Ball_X_Pos_in  = randomx;
//      Ball_Y_Pos_in  = randomy;
//	 end	
//	 else
//	 begin
//		Ball_X_Pos_in  = Ball_X_Pos;
//		Ball_Y_Pos_in  = Ball_X_Pos;
//	 end
	 
		  if ( ( DX[0]*DX[0] + DY[0]*DY[0]) <= (rSize * rSize) ) 
            is_rball[0] = 1'b1;
        else
            is_rball[0] = 1'b0;
				
		  if ( ( DX[1]*DX[1] + DY[1]*DY[1]) <= (rSize * rSize) ) 
            is_rball[1] = 1'b1;
        else
            is_rball[1] = 1'b0;
				
		  if ( ( DX[2]*DX[2] + DY[2]*DY[2]) <= (rSize * rSize) ) 
            is_rball[2] = 1'b1;
        else
            is_rball[2] = 1'b0;

		  if ( ( DX[3]*DX[3] + DY[3]*DY[3]) <= (rSize * rSize) ) 
            is_rball[3] = 1'b1;
        else
            is_rball[3] = 1'b0;
				
		  if ( ( DX[4]*DX[4] + DY[4]*DY[4]) <= (rSize * rSize) ) 
            is_rball[4] = 1'b1;
        else
            is_rball[4] = 1'b0;
				
		  if ( ( DX[5]*DX[5] + DY[5]*DY[5]) <= (rSize * rSize) ) 
            is_rball[5] = 1'b1;
        else
            is_rball[5] = 1'b0;
				
		  if ( ( DX[6]*DX[6] + DY[6]*DY[6]) <= (rSize * rSize) ) 
            is_rball[6] = 1'b1;
        else
            is_rball[6] = 1'b0;
				
		  if ( ( DX[7]*DX[7] + DY[7]*DY[7]) <= (rSize * rSize) ) 
            is_rball[7] = 1'b1;
        else
            is_rball[7] = 1'b0;
				
		  if ( ( DX[8]*DX[8] + DY[8]*DY[8]) <= (rSize * rSize) ) 
            is_rball[8] = 1'b1;
        else
            is_rball[8] = 1'b0;
		
		  if ( ( DX[9]*DX[9] + DY[9]*DY[9]) <= (rSize * rSize) ) 
            is_rball[9] = 1'b1;
        else
            is_rball[9] = 1'b0;
		
		  if ( ( DX[10]*DX[10] + DY[10]*DY[10]) <= (rSize * rSize) ) 
            is_rball[10] = 1'b1;
        else
            is_rball[10] = 1'b0;
				
		  if ( ( DX[11]*DX[11] + DY[11]*DY[11]) <= (rSize * rSize) ) 
            is_rball[11] = 1'b1;
        else
            is_rball[11] = 1'b0;
				
		  if ( ( DX[12]*DX[12] + DY[12]*DY[12]) <= (rSize * rSize) ) 
            is_rball[12] = 1'b1;
        else
            is_rball[12] = 1'b0;
				
		  if ( ( DX[13]*DX[13] + DY[13]*DY[13]) <= (rSize * rSize) ) 
            is_rball[13] = 1'b1;
        else
            is_rball[13] = 1'b0;
		
		  if ( ( DX[14]*DX[14] + DY[14]*DY[14]) <= (rSize * rSize) ) 
            is_rball[14] = 1'b1;
        else
            is_rball[14] = 1'b0;
				
		  if ( ( DX[15]*DX[15] + DY[15]*DY[15]) <= (rSize * rSize) ) 
            is_rball[15] = 1'b1;
        else
            is_rball[15] = 1'b0;
				
				
				
				
				
				
		 
        Ball_X_Pos_in[0]  = Ball_X_Pos[0];
        Ball_Y_Pos_in[0]  = Ball_Y_Pos[0];
        Ball_X_Pos_in[1]  = Ball_X_Pos[1];
        Ball_Y_Pos_in[1]  = Ball_Y_Pos[1];
        Ball_X_Pos_in[2]  = Ball_X_Pos[2];
        Ball_Y_Pos_in[2]  = Ball_Y_Pos[2];
        Ball_X_Pos_in[3]  = Ball_X_Pos[3];
        Ball_Y_Pos_in[3]  = Ball_Y_Pos[3];
        Ball_X_Pos_in[4]  = Ball_X_Pos[4];
        Ball_Y_Pos_in[4]  = Ball_Y_Pos[4];
        Ball_X_Pos_in[5]  = Ball_X_Pos[5];
        Ball_Y_Pos_in[5]  = Ball_Y_Pos[5];
        Ball_X_Pos_in[6]  = Ball_X_Pos[6];
        Ball_Y_Pos_in[6]  = Ball_Y_Pos[6];
        Ball_X_Pos_in[7]  = Ball_X_Pos[7];
        Ball_Y_Pos_in[7]  = Ball_Y_Pos[7];
        Ball_X_Pos_in[8]  = Ball_X_Pos[8];
        Ball_Y_Pos_in[8]  = Ball_Y_Pos[8];
        Ball_X_Pos_in[9]  = Ball_X_Pos[9];
        Ball_Y_Pos_in[9]  = Ball_Y_Pos[9];
        Ball_X_Pos_in[10] = Ball_X_Pos[10];
        Ball_Y_Pos_in[10] = Ball_Y_Pos[10];
        Ball_X_Pos_in[11] = Ball_X_Pos[11];
        Ball_Y_Pos_in[11] = Ball_Y_Pos[11];
        Ball_X_Pos_in[12] = Ball_X_Pos[12];
        Ball_Y_Pos_in[12] = Ball_Y_Pos[12];
        Ball_X_Pos_in[13] = Ball_X_Pos[13];
        Ball_Y_Pos_in[13] = Ball_Y_Pos[13];
        Ball_X_Pos_in[14] = Ball_X_Pos[14];
        Ball_Y_Pos_in[14] = Ball_Y_Pos[14];
        Ball_X_Pos_in[15] = Ball_X_Pos[15];
        Ball_Y_Pos_in[15] = Ball_Y_Pos[15];
		  is_collision1 = 0;
		  is_collision2 = 0;
        



		  
	     
		  if(((BallX - Ball_X_Pos[0])*(BallX - Ball_X_Pos[0]) + (BallY - Ball_Y_Pos[0])*(BallY - Ball_Y_Pos[0])) <= ((4+bSize)*(4+bSize)) )
        begin
		  //is_rball[0] = 1'b0;
		  
        Ball_X_Pos_in[0] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[0] <= {2'b0,randomy[7:0]};
		  is_collision1 = 1;
		  
		  end
		  
		 
		  if(((BallX - Ball_X_Pos[1])*(BallX - Ball_X_Pos[1]) + (BallY - Ball_Y_Pos[1])*(BallY - Ball_Y_Pos[1])) <= ((4+bSize)*(4+bSize)) )
        begin
        Ball_X_Pos_in[1] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[1] <= {2'b0,randomy[7:0]};
		  //is_rball[1] = 1'b0;
		  is_collision1 = 1;
		  end
		  
		 
		  if(((BallX - Ball_X_Pos[2])*(BallX - Ball_X_Pos[2]) + (BallY - Ball_Y_Pos[2])*(BallY - Ball_Y_Pos[2])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[2] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[2] <= {2'b0,randomy[7:0]};
		  //is_rball[2] = 1'b0;
		  is_collision1 = 1;
		  end
		  
		 
		  if(((BallX - Ball_X_Pos[3])*(BallX - Ball_X_Pos[3])+ (BallY - Ball_Y_Pos[3])*(BallY - Ball_Y_Pos[3])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[3] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[3] <= {2'b0,randomy[7:0]};
		  is_collision1 = 1;
		  end
		  
		  
		  if(((BallX - Ball_X_Pos[4])*(BallX - Ball_X_Pos[4]) +(BallY - Ball_Y_Pos[4])*(BallY - Ball_Y_Pos[4])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[4] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[4] <= {2'b0,randomy[7:0]};
		  is_collision1 = 1;
		  end
		  
		  
		  if(((BallX - Ball_X_Pos[5])*(BallX - Ball_X_Pos[5]) + (BallY - Ball_Y_Pos[5])*(BallY - Ball_Y_Pos[5])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[5] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[5] <= {2'b0,randomy[7:0]};
		  is_collision1 = 1;
		  end
		  
		  
		  if(((BallX - Ball_X_Pos[6])*(BallX - Ball_X_Pos[6]) + (BallY - Ball_Y_Pos[6])*(BallY - Ball_Y_Pos[6])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[6] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[6] <= {2'b0,randomy[7:0]};
		  is_collision1 = 1;
		  end
		 
		  if(((BallX - Ball_X_Pos[7])*(BallX - Ball_X_Pos[7]) + (BallY - Ball_Y_Pos[7])*(BallY - Ball_Y_Pos[7])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[7] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[7] <= {2'b0,randomy[7:0]};
		  is_collision1 = 1;
		  end
		  
		  
		  if(((BallX - Ball_X_Pos[8])*(BallX - Ball_X_Pos[8]) + (BallY - Ball_Y_Pos[8])*(BallY - Ball_Y_Pos[8])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[8] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[8] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		 
		  if(((BallX - Ball_X_Pos[9])*(BallX - Ball_X_Pos[9]) + (BallY - Ball_Y_Pos[9])*(BallY - Ball_Y_Pos[9])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[9] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[9] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		 
		  if(((BallX - Ball_X_Pos[10])*(BallX - Ball_X_Pos[10]) + (BallY - Ball_Y_Pos[10])*(BallY - Ball_Y_Pos[10])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[10] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[10] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		  //if(is_ball == 1 && is_rball[11] == 1)
		  if(((BallX - Ball_X_Pos[11])*(BallX - Ball_X_Pos[11]) + (BallY - Ball_Y_Pos[11])*(BallY - Ball_Y_Pos[11])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[11] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[11] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		
		  if(((BallX - Ball_X_Pos[12])*(BallX - Ball_X_Pos[12]) + (BallY - Ball_Y_Pos[12])*(BallY - Ball_Y_Pos[12])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[12] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[12] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		  
		  if(((BallX - Ball_X_Pos[13])*(BallX - Ball_X_Pos[13]) + (BallY - Ball_Y_Pos[13])*(BallY - Ball_Y_Pos[13])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[13] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[13] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		  
		  if(((BallX - Ball_X_Pos[14])*(BallX - Ball_X_Pos[14]) + (BallY - Ball_Y_Pos[14])*(BallY - Ball_Y_Pos[14])) <= ((4+bSize)*(4+bSize)))
        begin
        Ball_X_Pos_in[14] <= {1'b0,randomx[8:0]};
        Ball_Y_Pos_in[14] <= {2'b0,randomy[7:0]};
		  is_collision2 = 1;
		  end
		  
		 
		  if(((BallX - Ball_X_Pos[15])*(BallX - Ball_X_Pos[15]) + (BallY - Ball_Y_Pos[15])*(BallY - Ball_Y_Pos[15])) <= ((4+bSize)*(4+bSize)))
        begin
		  
        Ball_X_Pos_in[15] <= randomx;
        Ball_Y_Pos_in[15] <= randomy;
		  is_collision2 = 1;
        end
		  
		 
        
        
   end
    
endmodule