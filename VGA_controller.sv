//-------------------------------------------------------------------------
//      VGA controller                                                   --
//      Kyle Kloepper                                                    --
//      4-05-2005                                                        --
//                                                                       --
//      Modified by Stephen Kempf 04-08-2005                             --
//                                10-05-2006                             --
//                                03-12-2007                             --
//      Translated by Joe Meng    07-07-2013                             --
//      Modified by Po-Han Huang  10-06-2017                             --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      Used standard 640x480 vga found at epanorama                     --
//                                                                       --
//      reference: http://www.xilinx.com/bvdocs/userguides/ug130.pdf     --
//                 http://www.epanorama.net/documents/pc/vga_timing.html --
//                                                                       --
//      note: The standard is changed slightly because of 25 mhz instead --
//            of 25.175 mhz pixel clock. Refresh rate drops slightly.    --
//                                                                       --
//      For use with ECE 385 Lab 8 and Final Project                     --
//      ECE Department @ UIUC                                            --
//-------------------------------------------------------------------------


module  VGA_controller (input              Clk,         // 50 MHz clock
                                           Reset,       // Active-high reset signal
                        output logic       VGA_HS,      // Horizontal sync pulse.  Active low
                                           VGA_VS,      // Vertical sync pulse.  Active low
														 
                        input              VGA_CLK,     // 25 MHz VGA clock input
                        output logic       VGA_BLANK_N, // Blanking interval indicator.  Active low.
                                           VGA_SYNC_N,  // Composite Sync signal.  Active low.  We don't use it in this lab,
								input [9:0]  progressx,
								input [9:0]  progressy,
                                                        // but the video DAC on the DE2 board requires an input for it.
                        output logic [9:0] DrawX,       // horizontal coordinate
                                           DrawY        // vertical coordinate
                        );     
    
    // 800 pixels per line (including front/back porch
    // 525 lines per frame (including front/back porch)
    parameter [9:0] H_TOTAL = 10'd800;
    parameter [9:0] V_TOTAL = 10'd525;
	 
	
    
    logic VGA_HS_in, VGA_VS_in, VGA_BLANK_N_in;
    logic [9:0] h_counter, v_counter;
    logic [9:0] h_counter_in, v_counter_in;
    
    assign VGA_SYNC_N = 1'b0;
    assign DrawX = h_counter + progressx;
    assign DrawY = v_counter + progressy;
    
    // VGA control signals
    always_ff @ (posedge VGA_CLK)
    begin
        if (Reset)
        begin
            VGA_HS <= 1'b0;
            VGA_VS <= 1'b0;
            VGA_BLANK_N <= 1'b0;
            h_counter <= 10'd0;
            v_counter <= 10'd0;
				
        end
        else
        begin
            VGA_HS <= VGA_HS_in;
            VGA_VS <= VGA_VS_in;
				
            VGA_BLANK_N <= VGA_BLANK_N_in;
            h_counter <= h_counter_in;
            v_counter <= v_counter_in;
        end
    end
    
    always_comb
    begin
        // horizontal and vertical counter
        h_counter_in = h_counter + 10'd1;
        v_counter_in = v_counter;
        if(h_counter + 10'd1 == H_TOTAL)
        begin
            h_counter_in = 10'd0;
            if(v_counter + 10'd1 == V_TOTAL)
                v_counter_in = 10'd0;
            else
                v_counter_in = v_counter + 10'd1;
        end
        // Horizontal sync pulse is 96 pixels long at pixels 656-752
        // (Signal is registered to ensure clean output waveform)
        VGA_HS_in = 1'b1;
        if(h_counter_in >= 10'd656 && h_counter_in < 10'd752)
            VGA_HS_in = 1'b0;
        // Vertical sync pulse is 2 lines (800 pixels each) long at line 490-491
        //(Signal is registered to ensure clean output waveform)
        VGA_VS_in = 1'b1;
        if(v_counter_in >= 10'd490 && v_counter_in < 10'd492)
            VGA_VS_in = 1'b0;
        // Display pixels (inhibit blanking) between horizontal 0-639 and vertical 0-479 (640x480)
        VGA_BLANK_N_in = 1'b0;
        if(h_counter_in < 10'd640 && v_counter_in < 10'd480)
            VGA_BLANK_N_in = 1'b1;
    end
    
endmodule
