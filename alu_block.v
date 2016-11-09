module alu_block(alu_zero_flag,alu_out,data_1,data_2,sel);
parameter word_size=8;
parameter NOP=4'b0000;
parameter ADD=4'b0001;
parameter SUB=4'b0010;
parameter AND=4'b0011;
parameter NOT=4'b0100;
parameter RD=4'b0101;
parameter WR=4'b0110;
parameter BR=4'b0111;
parameter BRZ=4'b1000;
input [word_size-1: 0] data_1,data_2;
input [3:0] sel;
output [word_size-1: 0] alu_out;
reg [word_size-1: 0] alu_out;
output alu_zero_flag;
assign alu_zero_flag=~(alu_out[0]|alu_out[1]|alu_out[2]|alu_out[3]|alu_out[4]|alu_out[5]|alu_out[6]|alu_out[7]);
//or
// assign alu_zero_flag=~|alu_out

always@(sel or data_1 or data_2)
begin
case(sel)
NOP: alu_out=0;
ADD: alu_out=data_1+data_2;
SUB: alu_out=data_1-data_2;
AND: alu_out=data_1 & data_2;
NOT: alu_out=~data_2;
default alu_out=0;
endcase
end
endmodule


