module processing_unit(instruction,zero_flag,addres,mem_word,load_r0,load_r1,load_r2,load_r3,load_pc,load_y,load_z,load_ir,load_addr,inc_pc,sel_bus_1_mux,sel_bus_2_mux,clk,rst,bus_1);

parameter word_size=8;
parameter op_size=4;
parameter sel1_size=3;
parameter sel2_size=2;


output [word_size-1 : 0] instruction, address, bus_1;
output zero_flag;
input [word_size-1:0] mem_word;
input load_r0,load_r1,load_r2,load_r3,load_pc,load_y,load_z,load_ir,load_addr,inc_pc;

input [sel1_size-1:0] sel_bus_1_mux;
input [sel2_size-1:0] sel_bus_2_mux;

input clk,rst;

wire load_r0,load_r1,load_r2,load_r3;
wire [word_size-1:0] bus_2;
wire [word_size-1:0] r0_out,r1_out,r2_out,r3_out;
wire [word_size-1:0] pc_count,y_value,alu_out;
wire alu_zero_flag;
wire [op_size-1:0] opcode=instruction[word_size-1:word_size-op_size];

register_unit r0 (r0_out,bus_2,load_r0,clk,rst);
register_unit r1 (r1_out,bus_2,load_r1,clk,rst);
register_unit r2 (r2_out,bus_2,load_r2,clk,rst);
register_unit r3 (r3_out,bus_2,load_r3,clk,rst);
register_unit ry (ry_out,bus_2,load_ry,clk,rst);
d_flip_flop rz (zero_flag,alu_zero_flag,load_z,clk,rst);
address_register add_r (address,bus_2,load_addr,clk,rst);
instruction_register ir(instruction,bus_2,load_ir,clk,rst);
program_counter pc (pc_count,bus_2,load_pc,inc_pc,clk,rst);

multiplexer_5ch mux_1 (bus_1,r0_out,r1_out,r2_out,r3_out,pc_count,sel_bus_1_mux);
multiplexer_3ch mux_2 (bus_2,alu_out,bus_1,mem_word,sel_bus_2_mux);
alu_risc alu(alu_zero_flag,alu_out,y_value,bus_1,opcode);
endmodule


