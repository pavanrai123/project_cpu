module multiplexer_5ch(mux_out,data_a,data_b,data_c,data_d,data_e,sel);
parameter word_size=8;
input [word_size-1 :0] data_a,data_b,data_c,data_d,data_e;
input [2:0] sel;
output [word_size-1 :0] mux_out;
assign mux_out=(sel==0)?data_a:(sel==1)?data_b:(sel==2)?data_c:(sel==3)?data_d:(sel==4)?data_e:'bx;
endmodule

