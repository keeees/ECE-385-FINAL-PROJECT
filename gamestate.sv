module gamestate(
				input         Clk,
				input [15:0] keycode,//from keyboard
				input gameover,//eaten by enemy ball
				input Reset,//reset ball signal
				output logic start_signal,// start signal active high 	
				output logic gameover_signal,// gameover signal active high
				output logic ingame_signal,//ingame signal active high
				input [9:0] mouse_x,mouse_y,
				input leftButton,rightButton
				);
				
	enum logic [2:0] { start,gameover_state,ingame
									}   State, Next_state;   // Internal state logic
        
    always_ff @ (posedge Clk)
    begin
        if (Reset) 
            State <= start;
        else 
            State <= Next_state;
    end
   
    always_comb
    begin 
        // Default next state is staying at current state
        Next_state = State;
     
        unique case (State)
            start : begin 
                if ((leftButton || rightButton) && ((mouse_x >= 361 && mouse_x <=367 &&mouse_y >= 244 && mouse_y <= 273) ||(mouse_x >= 398 && mouse_x <=403 &&mouse_y >= 246 && mouse_y <= 273))) //game start! if press w
                    Next_state = ingame;
				end 
				ingame : begin
					if (gameover)
						Next_state = gameover_state;
				end 
				
				gameover_state : begin
					if((leftButton || rightButton) && (mouse_x >= 107 && mouse_x <=154 &&mouse_y >= 340 && mouse_y <= 433))//game restart if press d
						Next_state = start;
				end 
						
				default: ;
			endcase
			
			
			start_signal = 0;
			ingame_signal = 0;
			gameover_signal = 0;
			
			case(State)
				start : start_signal = 1;
				ingame : ingame_signal = 1;
				gameover_state : gameover_signal = 1;
				default : ;
			endcase 
end			
endmodule
            
	