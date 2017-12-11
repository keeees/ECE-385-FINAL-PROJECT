//
// piano Wave ROM Table
//
module piano_table(
  input [7:0] index,
  output [15:0] signal
);
parameter PERIOD = 256; // length of table

assign signal = piano;
logic [15:0] piano;
        
always_ff @(index)
begin
case(index)
	8'h00: piano = 16'h0000 ;
	8'h01: piano = 16'hfd45 ;
	8'h02: piano = 16'hfa90 ;
	8'h03: piano = 16'hf7e5 ;
	8'h04: piano = 16'hf549 ;
	8'h05: piano = 16'hf2c2 ;
	8'h06: piano = 16'hf053 ;
	8'h07: piano = 16'hee02 ;
	8'h08: piano = 16'hebd3 ;
	8'h09: piano = 16'he9c9 ;
	8'h0a: piano = 16'he7e9 ;
	8'h0b: piano = 16'he636 ;
	8'h0c: piano = 16'he4b3 ;
	8'h0d: piano = 16'he363 ;
	8'h0e: piano = 16'he248 ;
	8'h0f: piano = 16'he164 ;
	8'h10: piano = 16'he0b8 ;
	8'h11: piano = 16'he046 ;
	8'h12: piano = 16'he00d ;
	8'h13: piano = 16'he00f ;
	8'h14: piano = 16'he04a ;
	8'h15: piano = 16'he0bf ;
	8'h16: piano = 16'he16b ;
	8'h17: piano = 16'he24e ;
	8'h18: piano = 16'he364 ;
	8'h19: piano = 16'he4ad ;
	8'h1a: piano = 16'he625 ;
	8'h1b: piano = 16'he7c9 ;
	8'h1c: piano = 16'he996 ;
	8'h1d: piano = 16'heb88 ;
	8'h1e: piano = 16'hed9c ;
	8'h1f: piano = 16'hefcc ;
	8'h20: piano = 16'hf216 ;
	8'h21: piano = 16'hff75 ;
	8'h22: piano = 16'hf6e4 ;
	8'h23: piano = 16'hf95e ;
	8'h24: piano = 16'hfbe0 ;
	8'h25: piano = 16'hfe64 ;
	8'h26: piano = 16'h00e7 ;
	8'h27: piano = 16'h0364 ;
	8'h28: piano = 16'h05d7 ;
	8'h29: piano = 16'h083b ;
	8'h2a: piano = 16'h0a8d ;
	8'h2b: piano = 16'h0cc9 ;
	8'h2c: piano = 16'h0eeb ;
	8'h2d: piano = 16'h10f2 ;
	8'h2e: piano = 16'h12d9 ;
	8'h2f: piano = 16'h149f ;
	8'h30: piano = 16'h1641 ;
	8'h31: piano = 16'h17bd ;
	8'h32: piano = 16'h1912 ;
	8'h33: piano = 16'h1a40 ;
	8'h34: piano = 16'h1b44 ;
	8'h35: piano = 16'h1c1f ;
	8'h36: piano = 16'h1cd1 ;
	8'h37: piano = 16'h1d5a ;
	8'h38: piano = 16'h1dba ;
	8'h39: piano = 16'h1df4 ;
	8'h3a: piano = 16'h1e08 ;
	8'h3b: piano = 16'h1df8 ;
	8'h3c: piano = 16'h1dc5 ;
	8'h3d: piano = 16'h1d73;
	8'h3e: piano = 16'h1d02 ;
	8'h3f: piano = 16'h1c77 ;
	8'h40: piano = 16'h1bd4 ;
	8'h41: piano = 16'h1b1a ;
	8'h42: piano = 16'h1a4f ;
	8'h43: piano = 16'h1974 ;
	8'h44: piano = 16'h188d ;
	8'h45: piano = 16'h179d ;
	8'h46: piano = 16'h16a6 ;
	8'h47: piano = 16'h15ad ;
	8'h48: piano = 16'h14b3 ;
	8'h49: piano = 16'h1ebb ;
	8'h4a: piano = 16'h12cc ;
	8'h4b: piano = 16'h11e3 ;
	8'h4c: piano = 16'h1104 ;
	8'h4d: piano = 16'h1032 ;
	8'h4e: piano = 16'h0f6f ;
	8'h4f: piano = 16'h0ebc ;
	8'h50: piano = 16'h0e1a ;
	8'h51: piano = 16'h0d8c ;
	8'h52: piano = 16'h0d11 ;
	8'h53: piano = 16'h0cab ;
	8'h54: piano = 16'h0c59 ;
	8'h55: piano = 16'h0c1c ;
	8'h56: piano = 16'h0bf4 ;
	8'h57: piano = 16'h0be0 ;
	8'h58: piano = 16'h0bdf ;
	8'h59: piano = 16'h0bf0 ;
	8'h5a: piano = 16'h0c13 ;
	8'h5b: piano = 16'h0c45 ;
	8'h5c: piano = 16'h0c85 ;
	8'h5d: piano = 16'h0cd1 ;
	8'h5e: piano = 16'h0d27 ;
	8'h5f: piano = 16'h0d86 ;
	8'h60: piano = 16'h0dea ;
	8'h61: piano = 16'h0e52 ;
	8'h62: piano = 16'h0ebb ;
	8'h63: piano = 16'h0f22 ;
	8'h64: piano = 16'h1f87 ;
	8'h65: piano = 16'h1fe5 ;
	8'h66: piano = 16'h103b ;
	8'h67: piano = 16'h1087 ;
	8'h68: piano = 16'h10c7 ;
	8'h69: piano = 16'h10f8 ;
	8'h6a: piano = 16'h1118 ;
	8'h6b: piano = 16'h1127 ;
	8'h6c: piano = 16'h1123 ;
	8'h6d: piano = 16'h1109 ;
	8'h6e: piano = 16'h10da ;
	8'h6f: piano = 16'h1095 ;
	8'h70: piano = 16'h1039 ;
	8'h71: piano = 16'h0fc5 ;
	8'h72: piano = 16'h0f3a ;
	8'h73: piano = 16'h0e97 ;
	8'h74: piano = 16'h0dde ;
	8'h75: piano = 16'h0d0f ;
	8'h76: piano = 16'h0c2a ;
	8'h77: piano = 16'h0b31 ;
	8'h78: piano = 16'h0a26 ;
	8'h79: piano = 16'h0909 ;
	8'h7a: piano = 16'h07dd ;
	8'h7b: piano = 16'h06a3 ;
	8'h7c: piano = 16'h055d ;
	8'h7d: piano = 16'h040e ;
	8'h7e: piano = 16'h02b8 ;
	8'h7f: piano = 16'h015d ;
	
	8'h80: piano = 16'h0000 ;
	
	8'h00: piano = 16'h0000 ;
	
	8'hff: piano = ~16'hfd45 ;
	8'hfe: piano = ~16'hfa90 ;
	8'hfd: piano = ~16'hf7e5 ;
	8'hfc: piano = ~16'hf549 ;
	8'hfb: piano = ~16'hf2c2 ;
	8'hfa: piano = ~16'hf053 ;
	8'hf9: piano = ~16'hee02 ;
	8'hf8: piano = ~16'hebd3 ;
	8'hf7: piano = ~16'he9c9 ;
	8'hf6: piano = ~16'he7e9 ;
	8'hf5: piano = ~16'he636 ;
	8'hf4: piano = ~16'he4b3 ;
	8'hf3: piano = ~16'he363 ;
	8'hf2: piano = ~16'he248 ;
	8'hf1: piano = ~16'he164 ;
	8'hf0: piano = ~16'he0b8 ;
	8'hef: piano = ~16'he046 ;
	8'hee: piano = ~16'he00d ;
	8'hed: piano = ~16'he00f ;
	8'hec: piano = ~16'he04a ;
	8'heb: piano = ~16'he0bf ;
	8'hea: piano = ~16'he16b ;
	8'he9: piano = ~16'he24e ;
	8'he8: piano = ~16'he364 ;
	8'he7: piano = ~16'he4ad ;
	8'he6: piano = ~16'he625 ;
	8'he5: piano = ~16'he7c9 ;
	8'he4: piano = ~16'he996 ;
	8'he3: piano = ~16'heb88 ;
	8'he2: piano = ~16'hed9c ;
	8'he1: piano = ~16'hefcc ;
	8'he0: piano = ~16'hf216 ;
	8'hdf: piano = ~16'hff75 ;
	8'hde: piano = ~16'hf6e4 ;
	8'hdd: piano = ~16'hf95e ;
	8'hdc: piano = ~16'hfbe0 ;
	8'hdb: piano = ~16'hfe64 ;
	8'hda: piano = ~16'h00e7 ;
	8'hd9: piano = ~16'h0364 ;
	8'hd8: piano = ~16'h05d7 ;
	8'hd7: piano = ~16'h083b ;
	8'hd6: piano = ~16'h0a8d ;
	8'hd5: piano = ~16'h0cc9 ;
	8'hd4: piano = ~16'h0eeb ;
	8'hd3: piano = ~16'h10f2 ;
	8'hd2: piano = ~16'h12d9 ;
	8'hd1: piano = ~16'h149f ;
	8'hd0: piano = ~16'h1641 ;
	8'hcf: piano = ~16'h17bd ;
	8'hce: piano = ~16'h1912 ;
	8'hcd: piano = ~16'h1a40 ;
	8'hcc: piano = ~16'h1b44 ;
	8'hcb: piano = ~16'h1c1f ;
	8'hca: piano = ~16'h1cd1 ;
	8'hc9: piano = ~16'h1d5a ;
	8'hc8: piano = ~16'h1dba ;
	8'hc7: piano = ~16'h1df4 ;
	8'hc6: piano = ~16'h1e08 ;
	8'hc5: piano = ~16'h1df8 ;
	8'hc4: piano = ~16'h1dc5 ;
	8'hc3: piano = ~16'h1d73;
	8'hc2: piano = ~16'h1d02 ;
	8'hc1: piano = ~16'h1c77 ;
	8'hc0: piano = ~16'h1bd4 ;
	8'hbf: piano = ~16'h1b1a ;
	8'hbe: piano = ~16'h1a4f ;
	8'hbd: piano = ~16'h1974 ;
	8'hbc: piano = ~16'h188d ;
	8'hbb: piano = ~16'h179d ;
	8'hba: piano = ~16'h16a6 ;
	8'hb9: piano = ~16'h15ad ;
	8'hb8: piano = ~16'h14b3 ;
	8'hb7: piano = ~16'h1ebb ;
	8'hb6: piano = ~16'h12cc ;
	8'hb5: piano = ~16'h11e3 ;
	8'hb4: piano = ~16'h1104 ;
	8'hb3: piano = ~16'h1032 ;
	8'hb2: piano = ~16'h0f6f ;
	8'hb1: piano = ~16'h0ebc ;
	8'hb0: piano = ~16'h0e1a ;
	8'haf: piano = ~16'h0d8c ;
	8'hae: piano = ~16'h0d11 ;
	8'had: piano = ~16'h0cab ;
	8'hac: piano = ~16'h0c59 ;
	8'hab: piano = ~16'h0c1c ;
	8'haa: piano = ~16'h0bf4 ;
	8'ha9: piano = ~16'h0be0 ;
	8'ha8: piano = ~16'h0bdf ;
	8'ha7: piano = ~16'h0bf0 ;
	8'ha6: piano = ~16'h0c13 ;
	8'ha5: piano = ~16'h0c45 ;
	8'ha4: piano = ~16'h0c85 ;
	8'ha3: piano = ~16'h0cd1 ;
	8'ha2: piano = ~16'h0d27 ;
	8'ha1: piano = ~16'h0d86 ;
	8'ha0: piano = ~16'h0dea ;
	8'h9f: piano = ~16'h0e52 ;
	8'h9e: piano = ~16'h0ebb ;
	8'h9d: piano = ~16'h0f22 ;
	8'h9c: piano = ~16'h1f87 ;
	8'h9b: piano = ~16'h1fe5 ;
	8'h9a: piano = ~16'h103b ;
	8'h99: piano = ~16'h1087 ;
	8'h98: piano = ~16'h10c7 ;
	8'h97: piano = ~16'h10f8 ;
	8'h96: piano = ~16'h1118 ;
	8'h95: piano = ~16'h1127 ;
	8'h94: piano = ~16'h1123 ;
	8'h93: piano = ~16'h1109 ;
	8'h92: piano = ~16'h10da ;
	8'h91: piano = ~16'h1095 ;
	8'h90: piano = ~16'h1039 ;
	8'h8f: piano = ~16'h0fc5 ;
	8'h8e: piano = ~16'h0f3a ;
	8'h8d: piano = ~16'h0e97 ;
	8'h8c: piano = ~16'h0dde ;
	8'h8b: piano = ~16'h0d0f ;
	8'h8a: piano = ~16'h0c2a ;
	8'h89: piano = ~16'h0b31 ;
	8'h88: piano = ~16'h0a26 ;
	8'h87: piano = ~16'h0909 ;
	8'h86: piano = ~16'h07dd ;
	8'h85: piano = ~16'h06a3 ;
	8'h84: piano = ~16'h055d ;
	8'h83: piano = ~16'h040e ;
	8'h82: piano = ~16'h02b8 ;
	8'h81: piano = ~16'h015d ;
	
	
	default: piano = 16'h0000;
endcase
end
endmodule