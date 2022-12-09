`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/22 10:59:46
// Design Name: 
// Module Name: cpu54_tb
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


module cpu54_tb(

    );
     reg clk;
       reg reset;
       wire [31:0]pc;
       wire [31:0]inst;
              wire [31:0]res_m1;
              reg [31:0] pc_pre;
       sccomp_dataflow uut(clk,reset,inst,pc);
       integer file_output;
       integer counter = 0;
       initial begin

           file_output = $fopen("C:/Users/Zhenghao/Desktop/result2.txt");
            pc_pre=0;
           reset = 1;
           clk = 0;
           #2   reset = 0;
       end
         
         
//       always 
//        #1 clk=~clk;
     always begin
     #0.1 clk=~clk;
       
        if(clk==1'b1&&reset==0)begin
            if(pc_pre!=pc)begin
            counter = counter+1;
                           $fdisplay(file_output,"pc: %h",pc);
                           $fdisplay(file_output,"instr: %h",inst);
                           $fdisplay(file_output,"regfile0: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[0]);
                           $fdisplay(file_output,"regfile1: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[1]);
                           $fdisplay(file_output,"regfile2: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[2]);
                           $fdisplay(file_output,"regfile3: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[3]);
                           $fdisplay(file_output,"regfile4: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[4]);
                           $fdisplay(file_output,"regfile5: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[5]);
                           $fdisplay(file_output,"regfile6: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[6]);
                           $fdisplay(file_output,"regfile7: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[7]);
                           $fdisplay(file_output,"regfile8: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[8]);
                           $fdisplay(file_output,"regfile9: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[9]);
                           $fdisplay(file_output,"regfile10: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[10]);
                           $fdisplay(file_output,"regfile11: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[11]);
                           $fdisplay(file_output,"regfile12: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[12]);
                           $fdisplay(file_output,"regfile13: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[13]);
                           $fdisplay(file_output,"regfile14: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[14]);
                           $fdisplay(file_output,"regfile15: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[15]);
                           $fdisplay(file_output,"regfile16: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[16]);
                           $fdisplay(file_output,"regfile17: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[17]);
                           $fdisplay(file_output,"regfile18: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[18]);
                           $fdisplay(file_output,"regfile19: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[19]);
                           $fdisplay(file_output,"regfile20: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[20]);
                           $fdisplay(file_output,"regfile21: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[21]);
                           $fdisplay(file_output,"regfile22: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[22]);
                           $fdisplay(file_output,"regfile23: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[23]);
                           $fdisplay(file_output,"regfile24: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[24]);
                           $fdisplay(file_output,"regfile25: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[25]);
                           $fdisplay(file_output,"regfile26: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[26]);
                           $fdisplay(file_output,"regfile27: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[27]);
                           $fdisplay(file_output,"regfile28: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[28]);
                           $fdisplay(file_output,"regfile29: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[29]);
                           $fdisplay(file_output,"regfile30: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[30]);
                           $fdisplay(file_output,"regfile31: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[31]);
                           pc_pre=pc;
            end
        end
       end
       wire [2:0]state;
//       wire [1:0] mux2,mux4;
       assign state=cpu54_tb.uut.sccpu.cu.state;
//              assign mux2=cpu54_tb.uut.sccpu.cu.mux2;
//                     assign mux4=cpu54_tb.uut.sccpu.cu.mux4;
//       wire[31:0] res_z;
//       wire[31:0] res_alu;
       wire[53:0] decoded_instr;
//       wire [31:0] res_m5,res_m7,rdata,wdata,waddr;
//       wire [2:0] m5;
//       wire [1:0]m4;
//       wire rf_w,m7,zin,dm_we;
//       wire [31:0] res_clz,res_qu,res_m9;
//       wire [31:0] rf2;
//       wire [31:0] tmpaddr;
       wire [31:0]exc_addr;
       wire exception;
       wire eret;
           wire [4:0]cp0_cause;
//       assign tmpaddr=32'h10010002;
//       assign rf2=cpu54_tb.uut.dmemory.data[2];
//       assign m5=cpu54_tb.uut.sccpu.m5;
       assign exeption=cpu54_tb.uut.sccpu.my_cp0.exception;
       assign eret=cpu54_tb.uut.sccpu.my_cp0.eret;
       assign exc_addr=cpu54_tb.uut.sccpu.exc_addr;

//       assign dm_we=cpu54_tb.uut.sccpu.dm_we;
//       assign rdata=cpu54_tb.uut.sccpu.rdata;
//       assign wdata=cpu54_tb.uut.sccpu.wdata;
       assign cp0_cause=cpu54_tb.uut.sccpu.cp0_cause;
//       assign waddr=cpu54_tb.uut.sccpu.waddr;
//       assign res_qu=cpu54_tb.uut.sccpu.res_qu;
//       assign res_m9=cpu54_tb.uut.sccpu.res_m9;
//       assign res_clz=cpu54_tb.uut.sccpu.res_clz;
//       assign m4=cpu54_tb.uut.sccpu.m4;
//       assign zin=cpu54_tb.uut.sccpu.zin;
//       assign m7=cpu54_tb.uut.sccpu.m7;
//       assign res_m7=cpu54_tb.uut.sccpu.res_m7;
//       assign res_m4=cpu54_tb.uut.sccpu.res_m4;
//       assign res_m2=cpu54_tb.uut.sccpu.res_m2;
//       assign rf_w=cpu54_tb.uut.sccpu.rf_w;
//       assign res_m5=cpu54_tb.uut.sccpu.res_m5;
//       wire [31:0] im_1;
//       wire[4:0] aluc;
       assign decoded_instr=cpu54_tb.uut.sccpu.decoded_instr;
       wire [31:0]cp0_reg;//CP0¼Ä´æÆ÷
       assign cp0_reg=cpu54_tb.uut.sccpu.my_cp0.cp0_reg[12];
//       wire [31:0]IR;
//       wire ir_in;
//       wire [31:0]inst_cpu_ir,pc_tmp;
//       wire [10:0] im_addr;
//       wire [31:0] res_m2,res_m4;
       wire [31:0] real_pc;
//       wire pc_ena,pc_ena2;
//       wire [1:0] m2;
       assign real_pc=cpu54_tb.uut.sccpu.res_pc;
//       assign m2=cpu54_tb.uut.sccpu.m2;
//       assign pc_ena=cpu54_tb.uut.sccpu.pc_ena;
//       assign pc_ena2=cpu54_tb.uut.sccpu.pc_ena2;
//       assign res_m2=cpu54_tb.uut.sccpu.res_m2;
//       assign res_m4=cpu54_tb.uut.sccpu.res_m4;
//       assign im_addr=cpu54_tb.uut.imemory.im_addr;
//       assign im_1=cpu54_tb.uut.imemory.reg_inst[im_addr];
//       assign inst_cpu_ir=cpu54_tb.uut.inst_tmp;
//       assign pc_tmp=cpu54_tb.uut.pc_tmp;
//       assign IR=cpu54_tb.uut.sccpu.IR;
//       assign ir_in=cpu54_tb.uut.sccpu.ir_in;
//       assign aluc=cpu54_tb.uut.sccpu.cu.aluc;
//       assign res_m1=cpu54_tb.uut.sccpu.res_m1;
//       assign res_z=cpu54_tb.uut.sccpu.res_z;
//       assign res_alu=cpu54_tb.uut.sccpu.res_alu;
//       wire [31:0] ref_1,ref_now;
//       wire rf_we;
//       wire [31:0] rs;
//       wire [4:0] res_m6;
//       wire [1:0] m6;
//       wire decoded
//       assign rf_we=cpu54_tb.uut.sccpu.rf_w;
//       assign m6=cpu54_tb.uut.sccpu.m6;
//       assign res_m6=cpu54_tb.uut.sccpu.res_m6;
//       assign ref_now=cpu54_tb.uut.sccpu.cpu_ref.array_reg[res_m6];
//       assign rs=cpu54_tb.uut.sccpu.rs;
//       assign ref_1=cpu54_tb.uut.sccpu.cpu_ref.array_reg[1];
       
//       always @(pc) begin
           
//           if(reset==0)
//           begin
//             $fdisplay(file_output,"pc: %h",pc);
//             $fdisplay(file_output,"instr: %h",inst);
//             $fdisplay(file_output,"regfile0: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[0]);
//             $fdisplay(file_output,"regfile1: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[1]);
//             $fdisplay(file_output,"regfile2: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[2]);
//             $fdisplay(file_output,"regfile3: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[3]);
//             $fdisplay(file_output,"regfile4: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[4]);
//             $fdisplay(file_output,"regfile5: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[5]);
//             $fdisplay(file_output,"regfile6: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[6]);
//             $fdisplay(file_output,"regfile7: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[7]);
//             $fdisplay(file_output,"regfile8: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[8]);
//             $fdisplay(file_output,"regfile9: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[9]);
//             $fdisplay(file_output,"regfile10: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[10]);
//             $fdisplay(file_output,"regfile11: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[11]);
//             $fdisplay(file_output,"regfile12: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[12]);
//             $fdisplay(file_output,"regfile13: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[13]);
//             $fdisplay(file_output,"regfile14: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[14]);
//             $fdisplay(file_output,"regfile15: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[15]);
//             $fdisplay(file_output,"regfile16: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[16]);
//             $fdisplay(file_output,"regfile17: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[17]);
//             $fdisplay(file_output,"regfile18: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[18]);
//             $fdisplay(file_output,"regfile19: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[19]);
//             $fdisplay(file_output,"regfile20: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[20]);
//             $fdisplay(file_output,"regfile21: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[21]);
//             $fdisplay(file_output,"regfile22: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[22]);
//             $fdisplay(file_output,"regfile23: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[23]);
//             $fdisplay(file_output,"regfile24: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[24]);
//             $fdisplay(file_output,"regfile25: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[25]);
//             $fdisplay(file_output,"regfile26: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[26]);
//             $fdisplay(file_output,"regfile27: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[27]);
//             $fdisplay(file_output,"regfile28: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[28]);
//             $fdisplay(file_output,"regfile29: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[29]);
//             $fdisplay(file_output,"regfile30: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[30]);
//             $fdisplay(file_output,"regfile31: %h",cpu54_tb.uut.sccpu.cpu_ref.array_reg[31]);
//           end
//       end
endmodule
