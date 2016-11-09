module multiplexer_3ch_tb;
parameter word_size=8;
reg  [word_size-1: 0] data_a,data_b,data_c;
reg [1:0] sel; //inputs are written in reg they go inside in intial
wire [word_size-1: 0] mux_out; //outputs are written in wire


initial begin
#100 $finish;
end

//always #5 clk=~clk;

initial
  begin
        $dumpfile("multiplexer_3ch.vcd");
        $dumpvars(0, utt);
        $monitor("data_a=%b, data_b=%b, data_c=%b, mux_out=%b,sel=$sel", data_a,data_b,data_c,mux_out,sel);
        #20 data_a=8'b11111100;data_b=8'b11111101;data_c=8'b11111110;sel=3'b000;
        #20 data_a=8'b11111100;data_b=8'b11111101;data_c=8'b11111110;sel=3'b001;
        #20 data_a=8'b11111100;data_b=8'b11111101;data_c=8'b11111110;sel=3'b010;
        #20 data_a=8'b11111100;data_b=8'b11111101;data_c=8'b11111110;sel=3'b011;
        #20 data_a=8'b11111100;data_b=8'b11111101;data_c=8'b11111110;sel=3'b100;

     end

multiplexer_3ch utt(mux_out,data_a,data_b,data_c,sel);

endmodule

