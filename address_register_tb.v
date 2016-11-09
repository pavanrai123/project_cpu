module address_register_tb;
parameter word_size=8;
reg  [word_size-1: 0] d_in;
reg clk=0,load,rst; //inputs are written in reg they go inside in intial
wire [word_size-1: 0] d_out; //outputs are written in wire


initial begin
#100 $finish;
end

always #5 clk=~clk;

initial
  begin
        $dumpfile("address_register.vcd");
        $dumpvars(0, utt);
        $monitor("din=%b, dout=%b, rst=%b, load=%b", d_in, d_out, rst,load);
        #20 d_in = 8'b11111111; rst = 1'b1; load = 1'b1;
        #20 d_in = 8'b00000000; rst = 1'b1; load = 1'b1;
        #20 d_in = 8'b11111111; rst = 1'b0; load = 1'b1;
        #20 d_in = 8'b11111111; rst = 1'b1; load = 1'b0;
     end

   address_register utt(d_out,d_in,rst,clk,load);

endmodule
