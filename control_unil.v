module control_unit(load_r0,load_r1,load_r2,load_r3,load_z,load_y,load_ir,load_addr_reg,load_pc,inc_pc,write,instruction,clk,rst,zero,sel_bus_1_mux,sel_bus_2_mux);
parameter word_size=8, state_size=4, opcode_size=4;
parameter dest_size=2,src_size=2,sel_bus1_size=3,sel_bus2_size=2;

parameter r0=0,r1=1,r2=2,r3=3;
parameter NOP=0,ADD=1,SUB=2,AND=3,NOT=4;
parameter RD=5,WR=6,BR=7,BRZ=8;

parameter s_idle=0,s_fet1=1,s_fet2=2,s_dec=3,s_exec=4,s_rd1=5,s_rd2=6,s_wr1=7,s_wr2=8,s_br1=9,s_br2=10,s_halt=11;

output load_r0,load_r1,load_r2,load_r3,load_z,load_y,load_ir,load_addr_reg,load_pc,inc_pc,write;
output [sel_bus1_size-1 : 0] sel_bus_1_mux;
output [sel_bus2_size-1 : 0] sel_bus_2_mux;

input [word_size-1: 0] instruction;
input clk,rst,zero;

reg [state_size-1 : 0] state, next_state;
reg load_r0,load_r1,load_r2,load_r3,load_z,load_y,load_ir,load_addr_reg,load_pc,inc_pc,write;
reg sel_r0,sel_r1,sel_r2,sel_r3,sel_pc,sel_bus_1,sel_alu,sel_mem;
reg [sel_bus1_size-1 : 0] sel_bus_1_mux;
reg [sel_bus2_size-1 : 0] sel_bus_2_mux;
reg err_flag;

wire [opcode_size-1:0]opcode=instruction[word_size-1:word_size-opcode_size];
wire [src_size-1:0]src=instruction[dest_size+src_size-1:dest_size];
wire [dst_size-1:0]dst=instruction[dest_size-1:0];

// mux selections

assign sel_bus_1_mux[sel_bus1_size-1:0]=sel_r0?0:sel_r1?1:sel_r2?2:sel_r3?3:sel_pc?4:3'bx
assign sel_bus_2_mux[sel_bus2_size-1:0]=sel_alu?0:sel_bus_1?1:sel_mem?2:2'bx

always@(posedge clk or negedge rst)
begin:state_transitions
if(rst==0)
state<=s_idle;
else
state<=next_state;
end

always@(state or opcode or src or dest or zero)
begin:output_and_input_state
load_r0=0;load_r1=0;load_r2=0;load_r3=0;load_z=0;
load_y=0;load_ir=0;load_addr_reg=0;load_pc=0;inc_pc=0;write=0;
sel_r0=0;sel_r1=0;sel_r2=0;sel_r3=0;sel_pc=0;sel_bus_1=0;sel_alu=0;sel_mem=0;
sel_bus_1_mux=0;sel_bus_2_mux=0;err_flag=0;
next_state=state;

case(state) 
s_idle: next_state=s_fet1;
s_fet1: 
	begin
	next_state=s_fet2;
	sel_pc=1
	sel_bus_1=1;
	load_addr_reg=1;
	end
s_fet2:
	begin
	next_state=s_dec;          
	sel_mem=1;
	load_ir=1;
	inc_pc=1;
	end
s_dec:
	begin
		case(opcode)
			NOP:next_state=s_fet1;
			ADD,SUB,AND:
				begin
					next_state=s_exec;
					load_y=1;
					sel_bus_1=1;
					case(src)
					r0:sel_r0=1;
					r1:sel_r1=1;
					r2:sel_r2=1;
					r3:sel_r3=1;
					default err_flag=1;
					endcase
				end
			NOT:
			begin
				next_state=s_fet1;
				load_reg_z=1;
				sel_bus_1=1;
				sel_alu=1;// PRAI:Fix me looks like bug why do we want do this here it should be in exec cycle
				case(src)
				r0:sel_r0=1;
				r1:sel_r1=1;
				r2:sel_r2=1;
				r3:sel_r3=1;
				default err_flag=1;
				endcase

				case(dest) // PRAI:Fix me looks like bug why do we want do this here it should be in exec cycle
				r0:load_r0=1;
				r1:load_r1=1;
				r2:load_r2=1;
				r3:load_r3=1;
				default err_flag=1;
				endcase
                        end

			RD:
			begin
				next_state=s_rd1;
				sel_pc=1;
				sel_bus_1=1;
				load_addr_reg=1;
			end

			WR:
			begin
				next_state=s_wr1;
				sel_pc=1;
				sel_bus_1=1;
				load_addr_reg=1;
			end

			BR:
			begin
				next_state=s_br1;
				sel_pc=1;
				sel_bus_1=1;
				load_addr_reg=1;
			end

			BRZ:
			if(zero==1)
			begin
				next_state=s_br1;
				sel_pc=1;
				sel_bus_1=1;
				load_addr_reg=1;
			end
			else 
			begin
				next_state=s_fet1;
				inc_pc=1;
			end
			default:next_state=s_halt;
			endcase

s_exec:
	begin
		next_state=s_fet1;
		load_z=1;
		sel_alu=1
		case(dest)
		r0:load_r0=1;
		r1:load_r1=1;
		r2:load_r2=1;
		r3:load_r3=1;
		default err_flag=1;
		endcase
	end

s_rd1:
	begin
		next_state=s_rd2;
		sel_mem=1;
		load_addr_reg=1;
		inc_pc=1;
	end

s_wr1:
	begin
		next_state=s_wr2;
		sel_mem=1;
		load_addr_reg=1;
		inc_pc=1;
	end

s_rd2:
	begin
		next_state=s_fet1;
		sel_mem=1;
		case(dest)
		r0:load_r0=1;
		r1:load_r1=1;
		r2:load_r2=1;
		r3:load_r3=1;
		default err_flag=1;
		endcase
	end

s_wr2:
	begin
		next_state=s_fet1;
		write=1;
		case(src)
		r0:sel_r0=1;
		r1:sel_r1=1;
		r2:sel_r2=1;
		r3:sel_r3=1;
		default err_flag=1;
		endcase
	end

s_br1:
	begin
		next_state=s_br2;
		sel_mem=1;
		load_addr_reg=1;
	end
s_br2:
	begin
		next_state=s_fet1;
		sel_mem=1;
		load_pc=1;
	end

s_halt:
	next_state=s_halt;
	default: next_state=s_idle;

endcase
end
endmodule



























































































































