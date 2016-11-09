module alu_block_tb;
parameter word_size=8;
reg  [word_size-1: 0] data_1,data_2;
reg [3:0] sel; //inputs are written in reg they go inside in intial
wire alu_zero_flag;
wire [word_size-1: 0] alu_out; //outputs are written in wire


initial begin
#400 $finish;
end

//always #5 clk=~clk;

initial
  begin
        $dumpfile("alu_block.vcd");
        $dumpvars(0, utt);
        $monitor("data_1=%b, data_2=%b, alu_out=%b,sel=%b,alu_zero_flag=%b", data_1,data_2,alu_out,sel,alu_zero_flag);
        #20 data_1=8'b11111100;data_2=8'b00000001;sel=4'b0000;
        #20 data_1=8'b11111100;data_2=8'b00000001;sel=4'b0001;
        #20 data_1=8'b11111100;data_2=8'b00000001;sel=4'b0010;
        #20 data_1=8'b11111100;data_2=8'b00000001;sel=4'b0011;
        #20 data_1=8'b11111100;data_2=8'b00000001;sel=4'b0100;
     end

alu_block utt(alu_zero_flag,alu_out,data_1,data_2,sel);

endmodule


