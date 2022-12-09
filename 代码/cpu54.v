`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 10:20:02
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu54(
    input clk,
    input rst,
    input [31:0] instr,
    input [31:0] rdata,
    output [31:0] pc,
    output [31:0] waddr,
    output [31:0] wdata,
    output dm_we,
    output dm_re
    );
    wire rsPos;//rs????-

    wire [1:0]m1;//0-- || ,1--cp0,2--Z,3--Rs
    wire [1:0]m2;//01--ext5,1--rs,2--pc,3--xx
    wire m3;//0--ir[10:6],1--rs
    wire [1:0]m4;//0--rt,1--ext18,2--ext16,3--4
    wire [2:0]m5;//0--Z,1--dmem,2--hi,3--lo,4--cp0
    wire [1:0]m6;//0--rd,1--rt,2--31
    wire m7;//0--alu,1--clz
    wire [2:0]m8;//0--Z,1--cp0,2--div,3--divu,4--mul,5--multu,6--rs
    wire [2:0]m9;//0--Z,1--cp0,2--div,3--divu,4--mul,5--multu,6--rs
    wire [1:0]m10;//0--lw,1--lh,2--lb
    wire [1:0]m11;//0--sw,1--sh,2--sb
    wire [31:0] res_m1;
    wire [31:0] res_m2;
    wire [4:0] res_m3;
    wire [31:0] res_m4;
    wire [31:0] res_m5;
    wire [4:0] res_m6;
    wire [31:0] res_m7;
    wire [31:0] res_m8;
    wire [31:0] res_m9;
    wire [31:0] res_m10;
    wire [31:0] res_m11;
    wire div_start;
    wire zin;
    wire zout;
    wire ir_in;
    wire decoder_ena;
    wire hi_ena;
    wire lo_ena;
    wire pc_ena;
    wire cp0_ena;

    wire pc_ena2;
    wire [3:0]aluc;
    wire rf_w;
    wire rf_clk;
    wire sext;
    
    wire zero;
    wire carry;
    wire negative;
    wire overflow;
    
    wire [53:0]decoded_instr;
    
    wire [31:0] res_alu;
    wire [31:0] res_pc;
    wire [31:0] res_pc2;

    wire [31:0] rs;
    wire [31:0] rt;
    wire [31:0] rd;

    wire [31:0] res_z;
    wire [31:0] res_hi;
    wire [31:0] res_lo;
    wire [31:0] res_ext5;
    wire [31:0] res_ext16;
    wire [31:0] res_ext18;
    wire [31:0] IR;
    wire [31:0] res_ii;
    wire busy;//???busy??
    wire [31:0] res_q;//?
    wire [31:0] res_r;//??
    wire [31:0] res_qu;//?
    wire [31:0] res_ru;//??
    wire [63:0] res_mul;
    wire [63:0] res_multu;
    // wire [31:0] zaddr;
//    wire [31:0] res_z;
    wire [31:0] res_clz;
    wire [31:0] res_ext16_dm;
    wire [31:0] res_ext8_dm;
    wire [31:0] res_ext16_rt;
    wire [31:0] res_ext8_rt;
    wire [4:0] rd_addr;
    wire[4:0] rt_addr;
    assign waddr = res_z;

    assign pc = res_pc2;
    assign rd_addr=IR[15:11];
    assign rt_addr=IR[20:16];
    wire [31:0] cp0_rdata,exc_addr,cp0_status;
    wire [4:0] cp0_cause;

    wire [31:0] empty=32'bz;
    assign rsPos=!rs[31];
    control_unit cu(.clk(clk),.rst(rst),.z(zero),.rsPos(rsPos),.instr(decoded_instr),
    .mux1(m1),.mux2(m2),.mux3(m3),.mux4(m4),.mux5(m5),.mux6(m6),.mux7(m7),.mux8(m8),.mux9(m9),.mux10(m10),.mux11(m11),
    .div_start(div_start),.zin(zin),.zout(zout),.ir_in(ir_in),.aluc(aluc),.rf_w(rf_w),.dm_we(dm_we),
    .dm_re(dm_re),.hi_ena(hi_ena),.lo_ena(lo_ena),.decoder_ena(decoder_ena),.sext(sext),.cause(cp0_cause),.pc_ena(pc_ena),.pc_ena2(pc_ena2),.cp0_ena(cp0_ena));

    IR irreg(.instr(instr),.ir_in(ir_in),.ir(IR));
   
    instr_decoder id(.instr_code(IR),.decoder_ena(decoder_ena),.i(decoded_instr));
    
    pc1 mypc(.rst(rst),.we(pc_ena),.data_in(res_m1),.data_out(res_pc));

    pc1 realpc(.rst(rst),.we(pc_ena2),.data_in(res_pc),.data_out(res_pc2));

    II cpu_ii(res_pc[31:28],IR[25:0],res_ii);
    
    alu myalu(res_m2,res_m4,aluc,res_alu,zero,carry,negative,overflow);
    
    RF cpu_ref(.rst(rst),.we(rf_w),.raddr1(IR[25:21]),.raddr2(IR[20:16]),.waddr(res_m6),.wdata(res_m5),.rdata1(rs),.rdata2(rt));

    cp0 my_cp0(.clk(clk),.rst(rst),.ena(cp0_ena),.mfc0(decoded_instr[44]),.mtc0(decoded_instr[45]),.pc(res_pc),.cp0_addr(rd_addr),
    .wdata(rt),.exception(decoded_instr[53]||decoded_instr[52]||decoded_instr[51]),.eret(decoded_instr[50]),.cause(cp0_cause),.rdata(cp0_rdata),.status(cp0_status),.exc_addr(exc_addr));

    RegZ regZ(.rst(rst),.zin(zin),.zout(zout),.wdata(res_m7),.rdata(res_z));

    HILO hi(.wena(hi_ena),.rst(rst),.wdata(res_m8),.rdata(res_hi));
    HILO lo(.wena(lo_ena),.rst(rst),.wdata(res_m9),.rdata(res_lo));

    DIVU divu(.dividend(rs),.divisor(rt),.start(div_start),.clock(clk),.reset(rst),.q(res_qu),.r(res_ru),.busy(busy));
    DIV  div (.dividend(rs),.divisor(rt),.start(div_start),.clock(clk),.reset(rst),.q(res_q),.r(res_r),.busy(busy));
    MULT  mult (.clk(clk),.reset(rst),.a(rs),.b(rt), .z(res_mul));
    MULTU multu(.clk(clk),.reset(rst),.a(rs),.b(rt), .z(res_multu));
    clz CLZ(.num(rs),.result(res_clz));

    mux4 #(32) selector1(.a(res_ii),.b(exc_addr),.c(res_z),.d(rs),.choose(m1),.res(res_m1));
    mux4 #(32) selector2(.a(res_ext5),.b(rs),.c(res_pc),.d(empty),.choose(m2),.res(res_m2));
    mux  #(5) selector3(.a(IR[10:6]),.b(rs[4:0]),.choose(m3),.res(res_m3));
    mux4 #(32) selector4(.a(rt),.b(res_ext18),.c(res_ext16),.d(32'd4),.choose(m4),.res(res_m4));
    mux8 #(32) selector5(.a(res_z),.b(res_m10),.c(res_hi),.d(res_lo),.e(cp0_rdata),.f(res_mul[31:0]),.g(empty),.h(empty),.choose(m5),.res(res_m5));//0--Z,1--dmem,2--hi,3--lo,4--cp0
//0--rd,1--rt,2--31
    mux4 #(5) selector6(.a(rd_addr),.b(rt_addr),.c(5'd31),.d(5'bz),.choose(m6),.res(res_m6));
//0--alu,1--clz
    mux  #(32) selector7(.a(res_alu),.b(res_clz),.choose(m7),.res(res_m7));
//0--Z,1--cp0,2--div,3--divu,4--mul,5--multu,6--rs   hi //Òª¸Ä!!!!!!!!!!!!
    mux8 #(32) selector8(.a(res_z),.b(cp0_rdata),.c(res_r),.d(res_ru),.e(empty),.f(res_multu[63:32]),.g(rs),.h(empty),.choose(m8),.res(res_m8));
    mux8 #(32) selector9(.a(res_z),.b(cp0_rdata),.c(res_q),.d(res_qu),.e(empty),.f(res_multu[31:0]),.g(rs),.h(empty),.choose(m9),.res(res_m9));
/*    wire [1:0]m10;//0--lw,1--lh,2--lb
    wire [1:0]m11;//0--sw,1--sh,2--sb*/
    
    mux4 #(32) selector10(.a(rdata),.b(res_ext16_dm),.c(res_ext8_dm),.d(32'bz),.choose(m10),.res(res_m10));
    mux4 #(32) selector11(.a(rt),.b(res_ext16_rt),.c(res_ext8_rt),.d(32'bz),.choose(m11),.res(wdata));

    EXT #(5)   ext5 (.numb(res_m3),.isSign(sext),.res(res_ext5));
    EXT #(16)  ext16(.numb(IR[15:0]),.isSign(sext),.res(res_ext16));
    EXT #(18)  ext18(.numb({IR[15:0],2'b00}),.isSign(sext),.res(res_ext18));

    EXT #(16)  ext16_dm(.numb(rdata[15:0]),.isSign(sext),.res(res_ext16_dm));
    EXT #(8)   ext8_dm(.numb(rdata[7:0]),.isSign(sext),.res(res_ext8_dm));
    
    EXT #(16)  ext16_rt(.numb(rt[15:0]),.isSign(sext),.res(res_ext16_rt));
    EXT #(8)   ext8_rt(.numb(rt[7:0]),.isSign(sext),.res(res_ext8_rt));
    
endmodule
