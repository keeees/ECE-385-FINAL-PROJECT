
//-------------------------------------------------------------------------
//    aiBall.sv                                                            --
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


module  AIball ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [15:0]  keycode,
					//input 		  is_collision,
               output logic  is_aiball,             // Whether current pixel belongs to aiBall or background 
					input[9:0] BallX,BallY
					
              );
    
    parameter [9:0] aiBall_X_Center=320;  // Center position on the X axis
    parameter [9:0] aiBall_Y_Center=120;  // Center position on the Y axis
    parameter [9:0] aiBall_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] aiBall_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] aiBall_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] aiBall_Y_Max=479;     // Bottommost point on the Y axis
    logic [9:0] aiBall_X_Step=10'b000000001;      // Step size on the X axis
    logic [9:0] aiBall_Y_Step=10'b000000001;      // Step size on the Y axis
    logic [9:0] aiBall_Size = 6;        // aiBall size
    
    logic [9:0] aiBall_X_Pos, aiBall_X_Motion, aiBall_Y_Pos, aiBall_Y_Motion;
    logic [9:0] aiBall_X_Pos_in, aiBall_X_Motion_in, aiBall_Y_Pos_in, aiBall_Y_Motion_in;
	 //logic [9:0] progress_in;

    
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY;
    assign DistX = DrawX - aiBall_X_Pos;
    assign DistY = DrawY - aiBall_Y_Pos;
    //assign Size = aiBall_Size;

	
	 
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed;
    logic frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
    end
    assign frame_clk_rising_edge = (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    // Update aiBall position and motion
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            aiBall_X_Pos <= aiBall_X_Center;  
            aiBall_Y_Pos <= aiBall_Y_Center;
            aiBall_X_Motion <= 10'b0;
            aiBall_Y_Motion <= aiBall_Y_Step;
				aiBall_Size <= 6;
				//progress = 0;
        end
		 
		 
		  else if ((frame_clk_rising_edge)&& 
		  (((BallX - aiBall_X_Pos)*(BallX - aiBall_X_Pos) + (BallY - aiBall_Y_Pos)*(BallY - aiBall_Y_Pos)) <= ((aiBall_Size)*(aiBall_Size))))        
        
		  begin
		      aiBall_Size <= 0;
            aiBall_X_Pos <= aiBall_X_Pos_in;
            aiBall_Y_Pos <= aiBall_Y_Pos_in;
            aiBall_X_Motion <= aiBall_X_Motion_in;
            aiBall_Y_Motion <= aiBall_Y_Motion_in;
			  
        end
        else if (frame_clk_rising_edge)        
        begin
		      
            aiBall_X_Pos <= aiBall_X_Pos_in;
            aiBall_Y_Pos <= aiBall_Y_Pos_in;
            aiBall_X_Motion <= aiBall_X_Motion_in;
            aiBall_Y_Motion <= aiBall_Y_Motion_in;
			  
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    always_comb
    begin
	 
        // Update the aiBall's position with its motion
       aiBall_X_Pos_in = aiBall_X_Pos + aiBall_X_Motion;
       aiBall_Y_Pos_in = aiBall_Y_Pos + aiBall_Y_Motion;
    
			
		 // By default, keep motion unchanged
       aiBall_X_Motion_in = aiBall_X_Motion;
       aiBall_Y_Motion_in = aiBall_Y_Motion;
		        
		case(BallX)
		  10'b00000000010: // up w
		begin
			aiBall_X_Motion_in = 10'b0;
			if( (aiBall_Y_Pos + aiBall_Size) >= aiBall_Y_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_Y_Motion_in = (~(aiBall_Y_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_Y_Pos <= (aiBall_Y_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_Y_Motion_in = aiBall_Y_Step;
			else if( (aiBall_X_Pos + aiBall_Size) >= aiBall_X_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_X_Motion_in = (~(aiBall_X_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_X_Pos <= (aiBall_X_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_X_Motion_in = aiBall_X_Step;
			else 
				aiBall_Y_Motion_in = (~(aiBall_Y_Step) + 1'b1);
		end
		 
			10'b00000001000://down s
		 begin
			aiBall_X_Motion_in = 10'b0;
				if( (aiBall_Y_Pos + aiBall_Size) >= aiBall_Y_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_Y_Motion_in = (~(aiBall_Y_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_Y_Pos <= (aiBall_Y_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_Y_Motion_in = aiBall_Y_Step;
			else if( (aiBall_X_Pos + aiBall_Size) >= aiBall_X_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_X_Motion_in = (~(aiBall_X_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_X_Pos <= (aiBall_X_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_X_Motion_in = aiBall_X_Step;
			else 
				aiBall_Y_Motion_in =aiBall_Y_Step;
		 end
			
			10'b0000100000://left a
		begin
			aiBall_Y_Motion_in = 10'b0;
			if( (aiBall_Y_Pos + aiBall_Size) >= aiBall_Y_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_Y_Motion_in = (~(aiBall_Y_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_Y_Pos <= (aiBall_Y_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_Y_Motion_in = aiBall_Y_Step;
			else if( (aiBall_X_Pos + aiBall_Size) >= aiBall_X_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_X_Motion_in = (~(aiBall_X_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_X_Pos <= (aiBall_X_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_X_Motion_in = aiBall_X_Step;
			else 
			aiBall_X_Motion_in = (~(aiBall_X_Step) + 1'b1);
		end

			10'b0100000000://right d
		 begin
			aiBall_Y_Motion_in = 10'b0;
			if( (aiBall_Y_Pos + aiBall_Size) >= aiBall_Y_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_Y_Motion_in = (~(aiBall_Y_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_Y_Pos <= (aiBall_Y_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_Y_Motion_in = aiBall_Y_Step;
			else if( (aiBall_X_Pos + aiBall_Size) >= aiBall_X_Max )  // aiBall is at the bottom edge, BOUNCE!
            aiBall_X_Motion_in = (~(aiBall_X_Step) + 1'b1);  // 2's complement.  
         else if ( aiBall_X_Pos <= (aiBall_X_Min + aiBall_Size) )  // aiBall is at the top edge, BOUNCE!
            aiBall_X_Motion_in = aiBall_X_Step;
			else 
			aiBall_X_Motion_in = aiBall_X_Step;
		 end
		 
		 
		  endcase
		  		
		  
		  


        if ( ( DistX*DistX + DistY*DistY) <= (aiBall_Size * aiBall_Size) ) 
            is_aiball = 1'b1;
        else
            is_aiball = 1'b0;
				
		
        
		  
				

        
    end
    
endmodule
