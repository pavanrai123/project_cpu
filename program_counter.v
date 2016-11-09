module program_counter(count, data_in, rst, clk, load_pc,inc_pc);
parameter word_size=8;
input [word_size-1: 0]  data_in;
output [word_size-1: 0] count;
reg [word_size-1: 0] count;
input rst;
input clk;
input load_pc;
input inc_pc;
always@(posedge clk or negedge rst)
begin
if(rst==0)
count<=8'b0000_0000;
else if (load_pc==1)
count<=data_in;
else if (inc_pc==1)
count<=count+1;
end
endmodule
