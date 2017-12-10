//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1,HEX2,HEX3,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
				 inout 					PS2_CLK, PS2_DAT,

             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
                    );
    
    logic Reset_h, Clk,Reset_b;
    logic [15:0] keycode;
	 logic [9:0] RandomX,RandomY;
	 logic [9:0] BallX,BallY,ballsize,xstep,ystep,progressx,progressy;
	 logic [9:0] mouse_x,mouse_y;
	 logic gameover1,gameover2,gameover3;
	 logic [7:0] st_blue,st_green,st_red;
	 logic [15:0] escore,rscore,escore1,escore2,escore3;
	 logic rightButton,leftButton;
	 assign escore = escore1 + escore2 + escore3;
	 assign gameover = gameover1 || gameover2 || gameover3;
	
	 //logic [9:0] progress;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
		  Reset_b <= ~(KEY[1]);
    end
	 always_ff@(posedge Clk)
	 begin	
		if(Reset_h)
			VGA_CLK <= 1;
		else
			VGA_CLK <= ~VGA_CLK;
	 end
	 
	 logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs;
	 logic [9:0] DrawX,DrawY;
	 logic is_ball,is_collision1,is_collision2,is_aiball,is_eball1,is_eball2,is_eball3;
	 logic  start_signal,gameover_signal,ingame_signal;
	 //logic  is_rball;
	 logic  is_rball[0:15];
	 
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),    
                            .OTG_RST_N(OTG_RST_N)
    );
	 // You need to make sure that the port names here match the ports in Qsys-generated codes.
     nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_out_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w)
    );
  
    /*// Use PLL to generate the 25MHZ VGA_CLK. Do not modify it.
    vga_clk vga_clk_instance(
        .clk_clk(Clk),
        .reset_reset_n(1'b1),
        .altpll_0_c0_clk(VGA_CLK),
        .altpll_0_areset_conduit_export(),    
        .altpll_0_locked_conduit_export(),
        .altpll_0_phasedone_conduit_export()
    );*/
    
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(
	  .Clk(Clk),        
	  .Reset(Reset_h),      
	  .VGA_HS(VGA_HS),     
	  .VGA_VS(VGA_VS),     
	  .VGA_CLK(VGA_CLK),    
	  .VGA_BLANK_N(VGA_BLANK_N),
	  .VGA_SYNC_N(VGA_SYNC_N),              
	  .DrawX(DrawX),      
	  .DrawY(DrawY),
	  .progressx(progressx),
	  .progressy(progressy)
	 );
    
    // Which signal should be frame_clk?
    ball ball_instance(
	 
	 .start_signal(start_signal),
	 .Clk(Clk),         
	 .Reset(Reset_b), 
	 .gameover(gameover),	 
	 .frame_clk(VGA_VS),   
	 .DrawX(DrawX),
	 .DrawY(DrawY),
	 .keycode(keycode),
	 .is_ball(is_ball),
	 .is_collision1(is_collision1),
	 .is_collision2(is_collision2),
	 .BallX(BallX),//
	 .BallY(BallY),//
	 .Ball_Size(ballsize),
	 .Ball_X_Motion(xstep),
	 .Ball_Y_Motion(ystep),
	 .progressx(progressx),
	 .progressy(progressy)
	 );
	 

	 
	 enemy_ball1 enemy1(
	 
	 .Clk(Clk),         
	 .Reset(Reset_b),       
	 .frame_clk(VGA_VS),   
	 .DrawX(DrawX),
	 .DrawY(DrawY),
	 .is_eball(is_eball1),
	 .gameover(gameover1),//
	  .start_signal(start_signal),
	 //.is_collision1(is_collision1),//
	 //.is_collision2(is_collision2),//
	 .X(BallX),
	 .Y(BallY),
	 .x_step(xstep),//speed of ball
	 .y_step(ystep),//speed of ball
	 .size(ballsize),// size of ball
	 .escore(escore1)
	 );
	 
	 
	 enemy_ball2 enemy2(
	 
	 .Clk(Clk),         
	 .Reset(Reset_b),       
	 .frame_clk(VGA_VS),   
	 .DrawX(DrawX),
	 .DrawY(DrawY),
	 .is_eball(is_eball2),
	 .gameover(gameover2),//
	 
	 //.is_collision1(is_collision1),//
	 //.is_collision2(is_collision2),//
	 .X(BallX),
	 .Y(BallY),
	 .x_step(xstep),//speed of ball
	 .y_step(ystep),//speed of ball
	 .size(ballsize),// size of ball
	  .start_signal(start_signal),
	 .escore(escore2)
	 );
	 
	 enemy_ball3 enemy3(
	 
	 .Clk(Clk),         
	 .Reset(Reset_b),       
	 .frame_clk(VGA_VS),   
	 .DrawX(DrawX),
	 .DrawY(DrawY),
	 .is_eball(is_eball3),
	 .gameover(gameover3),//
	 .start_signal(start_signal),
	 //.is_collision1(is_collision1),//
	 //.is_collision2(is_collision2),//
	 .X(BallX),
	 .Y(BallY),
	 .x_step(xstep),//speed of ball
	 .y_step(ystep),//speed of ball
	 .size(ballsize),// size of ball
	 .escore(escore3)
	 );

    
	 
	  AIball aiball_instance(
	 
	 .Clk(Clk),         
	 .Reset(Reset_b),       
	 .frame_clk(VGA_VS),   
	 .DrawX(DrawX),
	 .DrawY(DrawY),
	 .BallX(BallX),//
	 .BallY(BallY),//
	 //.is_collision(is_collision),
	 .keycode(keycode),
	 .is_aiball(is_aiball),
	 .size(ballsize)
	 );
	 
    color_mapper color_instance(
	 	.Reset(Reset_b),       
	.frame_clk(VGA_VS),
	 .is_ball(is_ball),  
	 .is_rball(is_rball),
	 .DrawX(DrawX),
	 .DrawY(DrawY),      
	 .VGA_R(VGA_R),
	 .VGA_G(VGA_G),
	 .VGA_B(VGA_B),
	 //.progress(progress),//
	 .BallX(BallX),//
	 .BallY(BallY),//
	 .is_aiball(is_aiball),
	 .is_eball1(is_eball1),
	 .is_eball2(is_eball2),
	 .is_eball3(is_eball3),

	 .start_signal(start_signal),
	 .gameover_signal(gameover_signal),
	 .ingame_signal(ingame_signal)
	 //mouse
	 .mouse_x(mouse_x),
	 .mouse_y(mouse_y),
	 .leftButton(leftButton),
	 .rightButton(rightButton)
	 );
	 random_ball randomball( .Clk(Clk),                // 50 MHz clock
                             .Reset(Reset_b),              // Active-high reset signal
                             .frame_clk(VGA_VS), // The clock indicating a new frame (~60Hz)
					.is_ball(is_ball),
					
					.randomx(RandomX),
					.randomy(RandomY),
               .DrawX(DrawX) ,
					.is_collision1(is_collision1),
					.is_collision2(is_collision2),
               .DrawY(DrawY) ,					// Current pixel coordinates
               .is_rball(is_rball),            // Whether current pixel belongs to ball or backgr
				   .BallX(BallX),//
					.BallY(BallY),//
					.rscore(rscore),
					 .start_signal(start_signal)
              );
				  
		gamestate fsm(
		      .Clk(Clk),
				.keycode(keycode),//from keyboard
				.gameover(gameover),
				.Reset(Reset_b),//reset ball signal
				.start_signal(start_signal),
				.gameover_signal(gameover_signal),
	         .ingame_signal(ingame_signal)

				);				  
	


	
				  
	LFSRX lfsrx(
    .Clk(Clk),
    .Reset(Reset_b),
    .RandomX(RandomX) 
    );
	LFSRY lfsry(
    .Clk(Clk),
    .Reset(Reset_b),
    .RandomY(RandomY) 
    );
	 //mouse 
	 
	 Mouse_interface mouse(	
				.CLOCK_50(Clk),
				.KEY(KEY),
				.PS2_CLK(PS2_CLK),
				.PS2_DAT(PS2_DAT),
				.leftButton(leftButton),
				//middleButton, 
				.rightButton(rightButton),
				.cursorX(mouse_x), 
				.cursorY(mouse_y)
				);
 
 
//	collision collision1( .Clk(Clk),                // 50 MHz clock
//                             .Reset(Reset),              // Active-high reset signal
//	 .is_ball(is_ball),                        
//	 .DrawX(DrawX),
//	 .DrawY(DrawY),      
//	 .is_collision(is_collision)
//              );
    // Display keycode on hex display
	 
	 logic [15:0] score,score_next;
	 
//	 always_ff @ (posedge Clk)
//    begin
//		if(Reset)
//			score <= 0;
//		else if (score[3:0] == 4'b1010)
//			begin
//				score <= score +1;
	 always_comb
	 begin
	 
	 if(start_signal)
	 begin
		score = 16'b0;
	 end
	 else if(ingame_signal)
	 begin
		score = escore + rscore;
		
		if(score == 16'h000A)
			score = 16'h0010;
		else if (score == 16'h000b)
			score = 16'h0011;
		else if (score == 16'h000c)
			score = 16'h0012;
		else if (score == 16'h000d)
			score = 16'h0013;
		else if (score == 16'h000E)
			score = 16'h0014;
		else if (score == 16'h000F)
			score = 16'h0015;
		else if (score == 16'h0010)
			score = 16'h0016;
		else if (score == 16'h0011)
			score = 16'h0017;
		else if (score == 16'h0012)
			score = 16'h0018;
		else if (score == 16'h0013)
			score = 16'h0019;
		else if (score == 16'h0014)
			score = 16'h0020;
		else if (score == 16'h0015)
			score = 16'h0021;
		else if (score == 16'h0016)
			score = 16'h0022;
		else if (score == 16'h0017)
			score = 16'h0023;
		else if (score == 16'h0018)
			score = 16'h0024;
		else if (score == 16'h0019)
			score = 16'h0025;
		else if (score == 16'h001A)
			score = 16'h0026;
		else if (score == 16'h001b)
			score = 16'h0027;
		else if (score == 16'h001c)
			score = 16'h0028;
		else if (score == 16'h001e)
			score = 16'h0029;
		else if (score == 16'h001d)
			score = 16'h0030;
		else if (score == 16'h001E)
			score = 16'h0031;
		else if (score == 16'h001F)
			score = 16'h0032;
		else if (score == 16'h0020)
			score = 16'h0033;
		else if (score == 16'h0021)
			score = 16'h0034;
		else if (score == 16'h0022)
			score = 16'h0035;
		else if (score == 16'h0023)
			score = 16'h0036;
		else if (score == 16'h0024)
			score = 16'h0037;
		else if (score == 16'h0025)
			score = 16'h0038;
		else if (score == 16'h0026)
			score = 16'h0039;
		else if (score == 16'h0027)
			score = 16'h0040;
	 end	
	 
	 else 
	 score = 16'b1000100010001000;
	 
	 end
	 
    HexDriver hex_inst_0 (score[3:0], HEX0);
    HexDriver hex_inst_1 (score[7:4], HEX1);
	 HexDriver hex_inst_2 (score[11:8], HEX2);
    HexDriver hex_inst_3 (score[15:12], HEX3);
	 
    
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule
