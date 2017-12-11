//
// square Wave ROM Table
//
module square_table(
  input [7:0] index,
  output [15:0] signal
);
parameter PERIOD = 256; // length of table

assign signal = square;
logic [15:0] square;
        
always_ff @(index)
begin
case(index)
	8'h00: square = 16'hc001 ;//c001
	8'h01: square = 16'hc001 ;
	8'h02: square = 16'hc001 ;
	8'h03: square = 16'hc001 ;
	8'h04: square = 16'hc001 ;
	8'h05: square = 16'hc001 ;
	8'h06: square = 16'hc001 ;
	8'h07: square = 16'hc001 ;
	8'h08: square = 16'hc001 ;
	8'h09: square = 16'hc001 ;
	8'h0a: square = 16'hc001 ;
	8'h0b: square = 16'hc001 ;
	8'h0c: square = 16'hc001 ;
	8'h0d: square = 16'hc001 ;
	8'h0e: square = 16'hc001 ;
	8'h0f: square = 16'hc001 ;
	8'h10: square = 16'hc001 ;
	8'h11: square = 16'hc001 ;
	8'h12: square = 16'hc001 ;
	8'h13: square = 16'hc001 ;
	8'h14: square = 16'hc001 ;
	8'h15: square = 16'hc001 ;
	8'h16: square = 16'hc001 ;
	8'h17: square = 16'hc001 ;
	8'h18: square = 16'hc001 ;
	8'h19: square = 16'hc001 ;
	8'h1a: square = 16'hc001 ;
	8'h1b: square = 16'hc001 ;
	8'h1c: square = 16'hc001 ;
	8'h1d: square = 16'hc001 ;
	8'h1e: square = 16'hc001 ;
	8'h1f: square = 16'hc001 ;
	8'h20: square = 16'hc001 ;
	8'h21: square = 16'hc001 ;
	8'h22: square = 16'hc001 ;
	8'h23: square = 16'hc001 ;
	8'h24: square = 16'hc001 ;
	8'h25: square = 16'hc001 ;
	8'h26: square = 16'hc001 ;
	8'h27: square = 16'hc001 ;
	8'h28: square = 16'hc001 ;
	8'h29: square = 16'hc001 ;
	8'h2a: square = 16'hc001 ;
	8'h2b: square = 16'hc001 ;
	8'h2c: square = 16'hc001 ;
	8'h2d: square = 16'hc001 ;
	8'h2e: square = 16'hc001 ;
	8'h2f: square = 16'hc001 ;
	8'h30: square = 16'hc001 ;
	8'h31: square = 16'hc001 ;
	8'h32: square = 16'hc001 ;
	8'h33: square = 16'hc001 ;
	8'h34: square = 16'hc001 ;
	8'h35: square = 16'hc001 ;
	8'h36: square = 16'hc001 ;
	8'h37: square = 16'hc001 ;
	8'h38: square = 16'hc001 ;
	8'h39: square = 16'hc001 ;
	8'h3a: square = 16'hc001 ;
	8'h3b: square = 16'hc001 ;
	8'h3c: square = 16'hc001 ;
	8'h3d: square = 16'hc001 ;
	8'h3e: square = 16'hc001 ;
	8'h3f: square = 16'hc001 ;
	8'h40: square = 16'hc001 ;
	8'h41: square = 16'hc001 ;
	8'h42: square = 16'hc001 ;
	8'h43: square = 16'hc001 ;
	8'h44: square = 16'hc001 ;
	8'h45: square = 16'hc001 ;
	8'h46: square = 16'hc001 ;
	8'h47: square = 16'hc001 ;
	8'h48: square = 16'hc001 ;
	8'h49: square = 16'hc001 ;
	8'h4a: square = 16'hc001 ;
	8'h4b: square = 16'hc001 ;
	8'h4c: square = 16'hc001 ;
	8'h4d: square = 16'hc001 ;
	8'h4e: square = 16'hc001 ;
	8'h4f: square = 16'hc001 ;
	8'h50: square = 16'hc001 ;
	8'h51: square = 16'hc001 ;
	8'h52: square = 16'hc001 ;
	8'h53: square = 16'hc001 ;
	8'h54: square = 16'hc001 ;
	8'h55: square = 16'hc001 ;
	8'h56: square = 16'hc001 ;
	8'h57: square = 16'hc001 ;
	8'h58: square = 16'hc001 ;
	8'h59: square = 16'hc001 ;
	8'h5a: square = 16'hc001 ;
	8'h5b: square = 16'hc001 ;
	8'h5c: square = 16'hc001 ;
	8'h5d: square = 16'hc001 ;
	8'h5e: square = 16'hc001 ;
	8'h5f: square = 16'hc001 ;
	8'h60: square = 16'hc001 ;
	8'h61: square = 16'hc001 ;
	8'h62: square = 16'hc001 ;
	8'h63: square = 16'hc001 ;
	8'h64: square = 16'hc001 ;
	8'h65: square = 16'hc001 ;
	8'h66: square = 16'hc001 ;
	8'h67: square = 16'hc001 ;
	8'h68: square = 16'hc001 ;
	8'h69: square = 16'hc001 ;
	8'h6a: square = 16'hc001 ;
	8'h6b: square = 16'hc001 ;
	8'h6c: square = 16'hc001 ;
	8'h6d: square = 16'hc001 ;
	8'h6e: square = 16'hc001 ;
	8'h6f: square = 16'hc001 ;
	8'h70: square = 16'hc001 ;
	8'h71: square = 16'hc001 ;
	8'h72: square = 16'hc001 ;
	8'h73: square = 16'hc001 ;
	8'h74: square = 16'hc001 ;
	8'h75: square = 16'hc001 ;
	8'h76: square = 16'hc001 ;
	8'h77: square = 16'hc001 ;
	8'h78: square = 16'hc001 ;
	8'h79: square = 16'hc001 ;
	8'h7a: square = 16'hc001 ;
	8'h7b: square = 16'hc001 ;
	8'h7c: square = 16'hc001 ;
	8'h7d: square = 16'hc001 ;
	8'h7e: square = 16'hc001 ;
	8'h7f: square = 16'hc001 ;
	8'h80: square = 16'hc001 ;
	8'h81: square = 16'h3fff ;//3fff
	8'h82: square = 16'h3fff ;
	8'h83: square = 16'h3fff ;
	8'h84: square = 16'h3fff ;
	8'h85: square = 16'h3fff ;
	8'h86: square = 16'h3fff ;
	8'h87: square = 16'h3fff ;
	8'h88: square = 16'h3fff ;
	8'h89: square = 16'h3fff ;
	8'h8a: square = 16'h3fff ;
	8'h8b: square = 16'h3fff ;
	8'h8c: square = 16'h3fff ;
	8'h8d: square = 16'h3fff ;
	8'h8e: square = 16'h3fff ;
	8'h8f: square = 16'h3fff ;
	8'h90: square = 16'h3fff ;
	8'h91: square = 16'h3fff ;
	8'h92: square = 16'h3fff ;
	8'h93: square = 16'h3fff ;
	8'h94: square = 16'h3fff ;
	8'h95: square = 16'h3fff ;
	8'h96: square = 16'h3fff ;
	8'h97: square = 16'h3fff ;
	8'h98: square = 16'h3fff ;
	8'h99: square = 16'h3fff ;
	8'h9a: square = 16'h3fff ;
	8'h9b: square = 16'h3fff ;
	8'h9c: square = 16'h3fff ;
	8'h9d: square = 16'h3fff ;
	8'h9e: square = 16'h3fff ;
	8'h9f: square = 16'h3fff ;
	8'ha0: square = 16'h3fff ;
	8'ha1: square = 16'h3fff ;
	8'ha2: square = 16'h3fff ;
	8'ha3: square = 16'h3fff ;
	8'ha4: square = 16'h3fff ;
	8'ha5: square = 16'h3fff ;
	8'ha6: square = 16'h3fff ;
	8'ha7: square = 16'h3fff ;
	8'ha8: square = 16'h3fff ;
	8'ha9: square = 16'h3fff ;
	8'haa: square = 16'h3fff ;
	8'hab: square = 16'h3fff ;
	8'hac: square = 16'h3fff ;
	8'had: square = 16'h3fff ;
	8'hae: square = 16'hc626 ;
	8'haf: square = 16'h3fff ;
	8'hb0: square = 16'h3fff ;
	8'hb1: square = 16'h3fff ;
	8'hb2: square = 16'h3fff ;
	8'hb3: square = 16'h3fff ;
	8'hb4: square = 16'h3fff ;
	8'hb5: square = 16'h3fff ;
	8'hb6: square = 16'h3fff ;
	8'hb7: square = 16'h3fff ;
	8'hb8: square = 16'h3fff ;
	8'hb9: square = 16'h3fff ;
	8'hba: square = 16'h3fff ;
	8'hbb: square = 16'h3fff ;
	8'hbc: square = 16'h3fff ;
	8'hbd: square = 16'h3fff ;
	8'hbe: square = 16'h3fff ;
	8'hbf: square = 16'h3fff ;
	8'hc0: square = 16'h3fff ;
	8'hc1: square = 16'h3fff ;
	8'hc2: square = 16'h3fff ;
	8'hc3: square = 16'h3fff ;
	8'hc4: square = 16'h3fff ;
	8'hc5: square = 16'h3fff ;
	8'hc6: square = 16'h3fff ;
	8'hc7: square = 16'h3fff ;
	8'hc8: square = 16'h3fff ;
	8'hc9: square = 16'h3fff ;
	8'hca: square = 16'h3fff ;
	8'hcb: square = 16'h3fff ;
	8'hcc: square = 16'h3fff ;
	8'hcd: square = 16'h3fff ;
	8'hce: square = 16'h3fff ;
	8'hcf: square = 16'h3fff ;
	8'hd0: square = 16'h3fff ;
	8'hd1: square = 16'h3fff ;
	8'hd2: square = 16'h3fff ;
	8'hd3: square = 16'h3fff ;
	8'hd4: square = 16'h3fff ;
	8'hd5: square = 16'h3fff ;
	8'hd6: square = 16'h3fff ;
	8'hd7: square = 16'h3fff ;
	8'hd8: square = 16'h3fff ;
	8'hd9: square = 16'h3fff ;
	8'hda: square = 16'h3fff ;
	8'hdb: square = 16'h3fff ;
	8'hdc: square = 16'h3fff ;
	8'hdd: square = 16'h3fff ;
	8'hde: square = 16'h3fff ;
	8'hdf: square = 16'h3fff ;
	8'he0: square = 16'h3fff ;
	8'he1: square = 16'h3fff ;
	8'he2: square = 16'h3fff ;
	8'he3: square = 16'h3fff ;
	8'he4: square = 16'h3fff ;
	8'he5: square = 16'h3fff ;
	8'he6: square = 16'h3fff ;
	8'he7: square = 16'h3fff ;
	8'he8: square = 16'h3fff ;
	8'he9: square = 16'h3fff ;
	8'hea: square = 16'h3fff ;
	8'heb: square = 16'h3fff ;
	8'hec: square = 16'h3fff ;
	8'hed: square = 16'h3fff ;
	8'hee: square = 16'h3fff ;
	8'hef: square = 16'h3fff ;
	8'hf0: square = 16'h3fff ;
	8'hf1: square = 16'h3fff ;
	8'hf2: square = 16'h3fff ;
	8'hf3: square = 16'h3fff ;
	8'hf4: square = 16'h3fff ;
	8'hf5: square = 16'h3fff ;
	8'hf6: square = 16'h3fff ;
	8'hf7: square = 16'h3fff ;
	8'hf8: square = 16'h3fff ;
	8'hf9: square = 16'h3fff ;
	8'hfa: square = 16'h3fff ;
	8'hfb: square = 16'h3fff ;
	8'hfc: square = 16'h3fff ;
	8'hfd: square = 16'h3fff ;
	8'hfe: square = 16'h3fff ;
	8'hff: square = 16'h3fff ;
	default: square = 16'h3fff;
endcase
end
endmodule