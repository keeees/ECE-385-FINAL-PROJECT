module LFSRY (
    input Clk,
    input Reset,
    output logic [9:0] RandomY 
    );
 
wire feedback = random[7] ^ random[3] ^ random[2] ^ random[0]; 
 
reg [9:0] random, random_done;
reg [3:0] count; //to keep track of the shifts
 
always_ff @(posedge Clk)
begin
 if (Reset)
 begin
  random <= 9'hF; //An LFSR cannot have an all 0 state, thus Reset to FF
  count <= 0;
 end
  else if(count == 4'b1000)
 begin
  count <= 0;
  random_done <= random; //assign the random number to output after 13 shifts
  end
 else
 begin
  random <= {random[8:0], feedback};
  count <= count+1'b1;
 end
end
 
//always_comb
//begin
//  random_next = {random[6:0], feedback}; //shift left the xor'd every posedge Clk
//  count_next = count + 1;
//
//  
//end
 
 
assign RandomY = random_done;
 
endmodule