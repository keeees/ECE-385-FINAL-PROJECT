module gamestate(
				input [15:0] keycode,//from keyboard
				input eaten,//eaten by enemy ball
				input Reset,//reset ball signal
				output logic start_signal,// start signal active high 	
				output logic gameover_signal,// gameover signal active high
				output logic ingame_signal//ingame signal active high
				};
				
	enum logic [2:0] {  start,gameover,ingame
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
                if (keycode == 16'h071A) //game start!
                    Next_state = ingame;
				end 
				ingame : begin
					if (eaten)
						Next_state = gameover;
				end 
				
				gameover : begin
					if(keycode = 16'h1A07)
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
				gameover : gameover_signal = 1;
				default : ;
			endcase 
endmodule
            
	