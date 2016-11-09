module instruction_register(data_out, data_in, rst, clk, load);
parameter word_size=8;
input [word_size-1: 0] data_in;
output [word_size-1: 0] data_out;
reg [word_size-1: 0] data_out;
input rst;
input clk;
input load;
always@(posedge clk or negedge rst)
begin
if(rst==0)
data_out<=8'b0000_0000;
else if (load==1)
data_out<=data_in;
end
endmodule
