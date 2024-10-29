#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "Vnoc.h"
#include "verilated_vcd_c.h"


#define MAX_SIM_CYCLE 500
//vluint64_t 提供仿真時間之type
vluint64_t main_time = 0;

// u_int64_t data_buff[2] = {0x100003AFC,0x2000b1000};
// u_int64_t data_buff[2] = {0x100003C77,0x2000b1000}; 101 001 110 111
u_int64_t data_buff1[2] = {0x200000000000342B,0x40000000000B1000}; 
//12 -> 33
//    src_y src_x dst_y dst_x
//42B 010   000   101   011 
//     2     0     5     3
u_int64_t data_buff2[2] = {0x2000000000002125,0x40000000000B1000};     
//4 -> 29
//    src_y src_x dst_y dst_x
//125 000   100   100   101 
//     0     4     4     5
double sc_time_stamp(int len)
 {
    return (main_time%len);
    //用於生成時間戳用於仿真
 }

 int main(int argc, char **argv){
    //通过调用 Verilated::commandArgs
    //Verilator 可以处理命令行参数并将其用于配置仿真环境。
    Verilated::commandArgs(argc,argv);
    //允许 Verilator 生成 VCD（Value Change Dump）文件，用于记录仿真波形
    Verilated::traceEverOn(true);

    //这个指针将用于配置波形记录和生成 VCD 文件
    VerilatedVcdC* tfp = new VerilatedVcdC();

    //創立指向VXXX class中的對象 "top"
    Vnoc *top = new Vnoc("top");
    top->trace(tfp, 0);
    tfp->open("wave.vcd");

    top->reset = 0;
    for (int i = 0 ; i < 5 ; i ++){
        top->clk = 0;
        top->eval ();main_time += 5;tfp->dump(main_time);
        top->clk = 1;
        top->eval ();main_time += 5;tfp->dump(main_time);
    }
    top->reset = 1;    
    
    //u_int64_t data1;
    int ivalid = 1;
    //int ivch = 3;
    //data1 = 0x300000016;
    int count = 0;
    
    for( int i=0; i<MAX_SIM_CYCLE;i++) {
        top->clk=0;
        if(top -> n12_test_set == 0 && top-> n4_test_set == 0){
        if (count >= 2)
            {
                top->n12_idata_p0 = 0;
                top->n12_ivalid_p0 = 0;
                top->n12_ivch_p0 = 0b00;
                top->n4_idata_p0 = 0;
                top->n4_ivalid_p0 = 0;
                top->n4_ivch_p0 = 0b00;
            }else if (count < 2){
                top->n12_idata_p0  = data_buff1[count];
                top->n12_ivalid_p0 = ivalid;
                top->n12_ivch_p0= 0b11;
                top->n4_idata_p0  = data_buff2[count];
                top->n4_ivalid_p0 = ivalid;
                top->n4_ivch_p0= 0b10;
            }
            //printf("%d\n",count);
            count++;
            // top->iack_4 = 0b11;
            // top->ilck_4 = 0;
        }
        top->eval();
        main_time +=5;
        tfp->dump(main_time);
        top->clk=1;
        top->eval();
        main_time +=5;
        tfp->dump(main_time);
    }
    top->final();
    tfp->close();
    delete top;
    return 0;
 }


// #include <stdio.h>
// #include <stdlib.h>
// #include <assert.h>
// #include "Vnoc.h"
// #include "verilated_vcd_c.h"

// #define MAX_SIM_CYCLE 200
// #define CLK_PERIOD 20  // 定义时钟周期为20纳秒

// // vluint64_t 提供仿真时间之类型
// vluint64_t main_time = 0;

// // 用于生成时间戳用于仿真
// double sc_time_stamp(int len) {
//     return (main_time % len);
// }

// int main(int argc, char **argv) {
//     // 通过调用 Verilated::commandArgs
//     // Verilator 可以处理命令行参数并将其用于配置仿真环境。
//     Verilated::commandArgs(argc, argv);
//     // 允许 Verilator 生成 VCD（Value Change Dump）文件，用于记录仿真波形
//     Verilated::traceEverOn(true);

//     // 这个指针将用于配置波形记录和生成 VCD 文件
//     VerilatedVcdC* tfp = new VerilatedVcdC();

//     // 创立指向 VXXX class 中的对象 "top"
//     Vnoc *top = new Vnoc("top");
//     top->trace(tfp, 0);
//     tfp->open("wave.vcd");

//     top->reset = 0;
//     for (int i = 0; i < 5; i++) {
//         top->clk = 0;
//         top->eval();
//         main_time += (CLK_PERIOD / 2);  // 半个时钟周期
//         tfp->dump(main_time);
//         top->clk = 1;
//         top->eval();
//         main_time += (CLK_PERIOD / 2);  // 半个时钟周期
//         tfp->dump(main_time);
//     }
//     top->reset = 1;

//     u_int64_t data_buff[2] = {0x100003012, 0x2000b1000};  // 数据缓冲区
//     int ivalid = 1;
//     int count = 0;

//     for (int i = 0; i < MAX_SIM_CYCLE; i++) {
//         top->clk = 0;
//         if (top->n0_test_set == 0) {
//             if (count >= 2) {
//                 top->n0_idata_p0 = 0;
//                 top->n0_ivalid_p0 = 0;
//                 top->n0_ivch_p0 = 0b00;
//             } else if (count < 2) {
//                 top->n0_idata_p0 = data_buff[count];
//                 top->n0_ivalid_p0 = ivalid;
//                 top->n0_ivch_p0 = 0b11;
//             }
//             count++;
//         }
//         top->eval();
//         main_time += (CLK_PERIOD / 2);  // 半个时钟周期
//         tfp->dump(main_time);
//         top->clk = 1;
//         top->eval();
//         main_time += (CLK_PERIOD / 2);  // 半个时钟周期
//         tfp->dump(main_time);
//     }
//     top->final();
//     tfp->close();
//     delete top;
//     return 0;
// }
