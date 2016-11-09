module d_flip_flop_tb;

   reg  d_in,clk=0,load,rst; //inputs are written in reg they go inside in intial

   wire d_out; //outputs are written in wire

initial begin
#100 $finish;
end

always #5 clk=~clk;

initial
  begin
        $dumpfile("d_flip_flop.vcd");
        $dumpvars(0, s);
        $monitor("din=%b, dout=%b, rst=%b, load=%b", d_in, d_out, rst,load);
        #20 d_in = 1'b1; rst = 1'b1; load = 1'b1;
        #20 d_in = 1'b0; rst = 1'b1; load = 1'b1;
        #20 d_in = 1'b1; rst = 1'b0; load = 1'b1;
        #20 d_in = 1'b1; rst = 1'b1; load = 1'b0;
     end

   d_flip_flop s(d_out,d_in,load,rst,clk);

endmodule
