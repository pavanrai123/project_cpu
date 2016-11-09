module memory_unit(data_out,data_in,write,clk,address)
parameter word_size=8;
parameter memory_size=256;
input [word_size-1 : 0] data_in;
output [word_size-1 : 0] data_out;
input write,clk;
input [word_size-1 : 0] address;
reg [word_size-1 : 0] data_out;
reg [word_size-1 : 0] memory [memory_size-1 : 0];
always@(posedge clk)
begin
data_out[word_size-1 : 0] <=memory [word_size-1 : 0] [adddres]
if (write==1)
=memory [word_size-1 : 0] [adddres]<=data_in[word_size-1 : 0];
end
endmodule

