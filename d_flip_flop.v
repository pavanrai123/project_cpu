module d_flip_flop(data_out,data_in,load,rst,clk);
output data_out;
reg data_out;
input data_in;
input load;
input rst;
input clk;
always@(posedge clk or negedge rst)
begin 
if(rst ==0)
data_out<=0;
else if(load==1)
data_out<=data_in;
end
endmodule
