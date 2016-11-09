module program_counter_tb;
parameter word_size=8;
reg  [word_size-1: 0] d_in;
reg clk=0,load_pc,rst,inc_pc; //inputs are written in reg they go inside in intial
wire [word_size-1: 0] count; //outputs are written in wire


initial begin
#3000 $finish;
end

always #5 clk=~clk;

initial
  begin
        $dumpfile("program_counter.vcd");
        $dumpvars(0, utt);
        $monitor("din=%b, count=%b, rst=%b, load=%b", d_in, count, rst,load_pc,inc_pc);
        #20 d_in = 8'b11111111; rst = 1'b1; load_pc = 1'b1; inc_pc=1'b1 ;
        #20 d_in = 8'b11111111; rst = 1'b1; load_pc = 1'b0; inc_pc=1'b1 ;
     end

   program_counter utt(count,d_in,rst,clk,load_pc,inc_pc);

endmodule
