`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 10:43:47
// Design Name: 
// Module Name: imem
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


module imem(
   input [31:0]addr,
   output [31:0]meminst
);

    integer i;
    wire[31:0] myaddr=(addr-32'h00400000);
   dist_mem_gen_0 uut(.a(myaddr[12:2]),.spo(meminst));

//    reg [31:0] reg_inst[2047:0];
//    initial begin
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/1_addi.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/2_addiu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/3_andi.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/4_ori.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/5_sltiu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/6_lui.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/7_xori.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/8_slti.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/9_addu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/10_and.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/11_beq.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/13_j.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/14_jal.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/15_jr.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/16.26_lwsw.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/16.26_lwsw2.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/17_xor.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/18_nor.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/19_or.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/20_sll.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/21_sllv.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/22_sltu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/23_sra.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/24_srl.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/25_subu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/27_add.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/28_sub.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/29_slt.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/30_srlv.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/31_srav.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/32_clz.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/33_divu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/35_jalr.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/36.39_lbsb.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/36.39_lbsb2.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/37_lbu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/37_lbu2.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/38_lhu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/38_lhu2.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/40.41_lhsh.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/40.41_lhsh2.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/42.45_mfc0mtc0.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/43.46_mfhi.mthi.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/44.47_mflo.mtlo.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/48_mul.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/49_multu.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/52_bgez.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/54_div.hex.txt", reg_inst); 
//    $readmemh("D:/A-STUDY/PLOG/EXP/CPU54/cpu54_test/cp0.txt", reg_inst); 

//    end
//    reg [10:0]im_addr;
    
//    always@(*)begin
//        im_addr=(addr-32'h00400000)/4;
//    end
//    assign meminst= reg_inst[im_addr];

endmodule
