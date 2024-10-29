`include "defines.v"
module noc (
    input wire clk,
    input wire reset,

    //n0
    input wire [`DATA_WIDTH - 1 : 0]    n0_idata_p0,
    input wire                          n0_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n0_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n0_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n0_odata_p0,
    output reg                          n0_ovalid_p0,
    output reg n0_test_set,

    //n1
    input wire [`DATA_WIDTH - 1 : 0]    n1_idata_p0,
    input wire                          n1_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n1_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n1_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n1_odata_p0,
    output reg                          n1_ovalid_p0,
    output reg n1_test_set,

    //n2
    input wire [`DATA_WIDTH - 1 : 0]    n2_idata_p0,
    input wire                          n2_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n2_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n2_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n2_odata_p0,
    output reg                          n2_ovalid_p0,
    output reg n2_test_set,

    //n3
    input wire [`DATA_WIDTH - 1 : 0]    n3_idata_p0,
    input wire                          n3_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n3_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n3_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n3_odata_p0,
    output reg                          n3_ovalid_p0,
    output reg n3_test_set,

    //n4
    input wire [`DATA_WIDTH - 1 : 0]    n4_idata_p0,
    input wire                          n4_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n4_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n4_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n4_odata_p0,
    output reg                          n4_ovalid_p0,
    output reg n4_test_set,

    //n5
    input wire [`DATA_WIDTH - 1 : 0]    n5_idata_p0,
    input wire                          n5_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n5_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n5_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n5_odata_p0,
    output reg                          n5_ovalid_p0,
    output reg n5_test_set,

    //n6
    input wire [`DATA_WIDTH - 1 : 0]    n6_idata_p0,
    input wire                          n6_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n6_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n6_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n6_odata_p0,
    output reg                          n6_ovalid_p0,
    output reg n6_test_set,

    //n7
    input wire [`DATA_WIDTH - 1 : 0]    n7_idata_p0,
    input wire                          n7_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n7_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n7_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n7_odata_p0,
    output reg                          n7_ovalid_p0,
    output reg n7_test_set,

    //n8
    input wire [`DATA_WIDTH - 1 : 0]    n8_idata_p0,
    input wire                          n8_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n8_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n8_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n8_odata_p0,
    output reg                          n8_ovalid_p0,
    output reg n8_test_set,

    //n9
    input wire [`DATA_WIDTH - 1 : 0]    n9_idata_p0,
    input wire                          n9_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n9_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n9_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n9_odata_p0,
    output reg                          n9_ovalid_p0,
    output reg n9_test_set,

    //n10
    input wire [`DATA_WIDTH - 1 : 0]    n10_idata_p0,
    input wire                          n10_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n10_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n10_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n10_odata_p0,
    output reg                          n10_ovalid_p0,
    output reg n10_test_set,

    //n11
    input wire [`DATA_WIDTH - 1 : 0]    n11_idata_p0,
    input wire                          n11_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n11_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n11_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n11_odata_p0,
    output reg                          n11_ovalid_p0,
    output reg n11_test_set,

    //n12
    input wire [`DATA_WIDTH - 1 : 0]    n12_idata_p0,
    input wire                          n12_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n12_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n12_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n12_odata_p0,
    output reg                          n12_ovalid_p0,
    output reg n12_test_set,

    //n13
    input wire [`DATA_WIDTH - 1 : 0]    n13_idata_p0,
    input wire                          n13_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n13_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n13_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n13_odata_p0,
    output reg                          n13_ovalid_p0,
    output reg n13_test_set,

    //n14
    input wire [`DATA_WIDTH - 1 : 0]    n14_idata_p0,
    input wire                          n14_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n14_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n14_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n14_odata_p0,
    output reg                          n14_ovalid_p0,
    output reg n14_test_set,

    //n15
    input wire [`DATA_WIDTH - 1 : 0]    n15_idata_p0,
    input wire                          n15_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n15_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n15_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n15_odata_p0,
    output reg                          n15_ovalid_p0,
    output reg n15_test_set,

    //n16
    input wire [`DATA_WIDTH - 1 : 0]    n16_idata_p0,
    input wire                          n16_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n16_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n16_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n16_odata_p0,
    output reg                          n16_ovalid_p0,
    output reg n16_test_set,

    //n17
    input wire [`DATA_WIDTH - 1 : 0]    n17_idata_p0,
    input wire                          n17_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n17_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n17_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n17_odata_p0,
    output reg                          n17_ovalid_p0,
    output reg n17_test_set,

    //n18
    input wire [`DATA_WIDTH - 1 : 0]    n18_idata_p0,
    input wire                          n18_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n18_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n18_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n18_odata_p0,
    output reg                          n18_ovalid_p0,
    output reg n18_test_set,
    
    //n19
    input wire [`DATA_WIDTH - 1 : 0]    n19_idata_p0,
    input wire                          n19_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n19_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n19_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n19_odata_p0,
    output reg                          n19_ovalid_p0,
    output reg n19_test_set,

    //n20
    input wire [`DATA_WIDTH - 1 : 0]    n20_idata_p0,
    input wire                          n20_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n20_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n20_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n20_odata_p0,
    output reg                          n20_ovalid_p0,
    output reg n20_test_set,

    //n21
    input wire [`DATA_WIDTH - 1 : 0]    n21_idata_p0,
    input wire                          n21_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n21_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n21_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n21_odata_p0,
    output reg                          n21_ovalid_p0,
    output reg n21_test_set,

    //n22
    input wire [`DATA_WIDTH - 1 : 0]    n22_idata_p0,
    input wire                          n22_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n22_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n22_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n22_odata_p0,
    output reg                          n22_ovalid_p0,
    output reg n22_test_set,

    //n23
    input wire [`DATA_WIDTH - 1 : 0]    n23_idata_p0,
    input wire                          n23_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n23_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n23_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n23_odata_p0,
    output reg                          n23_ovalid_p0,
    output reg n23_test_set,

    //n24
    input wire [`DATA_WIDTH - 1 : 0]    n24_idata_p0,
    input wire                          n24_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n24_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n24_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n24_odata_p0,
    output reg                          n24_ovalid_p0,
    output reg n24_test_set,

    //n25
    input wire [`DATA_WIDTH - 1 : 0]    n25_idata_p0,
    input wire                          n25_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n25_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n25_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n25_odata_p0,
    output reg                          n25_ovalid_p0,
    output reg n25_test_set,

    //n26
    input wire [`DATA_WIDTH - 1 : 0]    n26_idata_p0,
    input wire                          n26_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n26_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n26_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n26_odata_p0,
    output reg                          n26_ovalid_p0,
    output reg n26_test_set,


    //n27
    input wire [`DATA_WIDTH - 1 : 0]    n27_idata_p0,
    input wire                          n27_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n27_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n27_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n27_odata_p0,
    output reg                          n27_ovalid_p0,
    output reg n27_test_set,

    //n28
    input wire [`DATA_WIDTH - 1 : 0]    n28_idata_p0,
    input wire                          n28_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n28_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n28_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n28_odata_p0,
    output reg                          n28_ovalid_p0,
    output reg n28_test_set,

    //n29
    input wire [`DATA_WIDTH - 1 : 0]    n29_idata_p0,
    input wire                          n29_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n29_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n29_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n29_odata_p0,
    output reg                          n29_ovalid_p0,
    output reg n29_test_set,

    //n30
    input wire [`DATA_WIDTH - 1 : 0]    n30_idata_p0,
    input wire                          n30_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n30_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n30_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n30_odata_p0,
    output reg                          n30_ovalid_p0,
    output reg n30_test_set,

    //n31
    input wire [`DATA_WIDTH - 1 : 0]    n31_idata_p0,
    input wire                          n31_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n31_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n31_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n31_odata_p0,
    output reg                          n31_ovalid_p0,
    output reg n31_test_set,


    //n32
    input wire [`DATA_WIDTH - 1 : 0]    n32_idata_p0,
    input wire                          n32_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n32_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n32_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n32_odata_p0,
    output reg                          n32_ovalid_p0,
    output reg n32_test_set,

    //n33
    input wire [`DATA_WIDTH - 1 : 0]    n33_idata_p0,
    input wire                          n33_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n33_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n33_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n33_odata_p0,
    output reg                          n33_ovalid_p0,
    output reg n33_test_set,

    //n34
    input wire [`DATA_WIDTH - 1 : 0]    n34_idata_p0,
    input wire                          n34_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n34_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n34_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n34_odata_p0,
    output reg                          n34_ovalid_p0,
    output reg n34_test_set,

    //n35
    input wire [`DATA_WIDTH - 1 : 0]    n35_idata_p0,
    input wire                          n35_ivalid_p0,
    input wire [`VCH_WIDTH_NUM - 1 : 0] n35_ivch_p0,
    output reg [`VCH_WIDTH - 1 : 0]     n35_ordy_p0,
    output reg [`DATA_WIDTH - 1 : 0]    n35_odata_p0,
    output reg                          n35_ovalid_p0,
    output reg n35_test_set
);

parameter  WIDTHX = 6;
parameter  WIDTHY = 6;
//n0 --> n1
wire [`DATA_WIDTH-1:0]      n0_odata_1;
wire                        n0_ovalid_1;
wire [`VCH_WIDTH_NUM-1:0]   n0_ovch_1;
wire [`VCH_WIDTH-1:0]       n0_olck_1;
wire [`VCH_WIDTH-1:0]       n0_oack_1;
wire                        n0_test_ack_e_1;          
//n0 --> n6
wire [`DATA_WIDTH-1:0]      n0_odata_6;
wire                        n0_ovalid_6;
wire [`VCH_WIDTH_NUM-1:0]   n0_ovch_6;
wire [`VCH_WIDTH-1:0]       n0_olck_6;
wire [`VCH_WIDTH-1:0]       n0_oack_6; 
wire                        n0_test_ack_s_6;
//n0 -> n1 / n6
wire [`F_NODE-1:0]          n0_faulty_out;

router #(0,WIDTHX,WIDTHY) n0(
    .clk(clk),
    .reset(reset),

    .my_xpos(0),
    .my_ypos(0),

    .idata_0(`DATA_WIDTH'b0),
    .ivalid_0(1'b0),
    .ivch_0(`VCH_WIDTH_NUM'b0),
    .oack_0(),//X
    .ordy_0(),//X
    .olck_0(),//X
    .iack_0(`VCH_WIDTH'b0),
    .ilck_0(`VCH_WIDTH'b0),
    .odata_0(),//X
    .ovalid_0(),//X
    .ovch_0(),//X

    .idata_1(n1_odata_0),
    .ivalid_1(n1_ovalid_0),
    .ivch_1(n1_ovch_0),
    .oack_1(n0_oack_1),
    .ordy_1(),//X
    .olck_1(n0_olck_1),
    .iack_1(n1_olck_0),
    .ilck_1(n1_olck_0),
    .odata_1(n0_odata_1),//
    .ovalid_1(n0_ovalid_1),
    .ovch_1(n0_ovch_1),

    .idata_2(n6_odata_0),
    .ivalid_2(n6_ovalid_0),
    .ivch_2(n6_ovch_0),
    .oack_2(n0_oack_6),
    .ordy_2(),//X
    .olck_2(n0_olck_6),
    .iack_2(n6_oack_0),
    .ilck_2(n6_olck_0),
    .odata_2(n0_odata_6),
    .ovalid_2(n0_ovalid_6),
    .ovch_2(n0_ovch_6),

    .idata_3(`DATA_WIDTH'b0),
    .ivalid_3(1'b0),
    .ivch_3(`VCH_WIDTH_NUM'b0),
    .oack_3(),//X
    .ordy_3(),//X
    .olck_3(),//X
    .iack_3(`VCH_WIDTH'b0),
    .ilck_3(`VCH_WIDTH'b0),
    .odata_3(),//X
    .ovalid_3(),//X
    .ovch_3(),//X

    .idata_4(n0_idata_p0),
    .ivalid_4(n0_ivalid_p0),
    .ivch_4(n0_ivch_p0),
    .oack_4(),//X
    .ordy_4(n0_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n0_odata_p0),
    .ovalid_4(n0_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(),//X
    .test_ack_e_in(n1_test_ack_w_0),
    .test_ack_s_in(n6_test_ack_n_0),
    .test_ack_w_in(),//X
    .n_faulty(),//X
    .e_faulty(n1_faulty_out),
    .s_faulty(n6_faulty_out),
    .w_faulty(),//X
    .faulty_to_out(n0_faulty_out),//給四面八方
    .test_ack_n(),//X
    .test_ack_e(n0_test_ack_e_1),
    .test_ack_s(n0_test_ack_s_6),
    .test_ack_w(),
    .test_set_to_input(n0_test_set)
);

//n1 --> n2 port 1
wire [`DATA_WIDTH-1:0]      n1_odata_2;
wire                        n1_ovalid_2;
wire [`VCH_WIDTH_NUM-1:0]   n1_ovch_2;
wire [`VCH_WIDTH-1:0]       n1_olck_2;
wire [`VCH_WIDTH-1:0]       n1_oack_2;
wire                        n1_test_ack_e_2; 
//n1 --> n7 port 2
wire [`DATA_WIDTH-1:0]      n1_odata_7;
wire                        n1_ovalid_7;
wire [`VCH_WIDTH_NUM-1:0]   n1_ovch_7;
wire [`VCH_WIDTH-1:0]       n1_olck_7;
wire [`VCH_WIDTH-1:0]       n1_oack_7;
wire                        n1_test_ack_s_7;
//n1 --> n0 port 3
wire [`DATA_WIDTH-1:0]      n1_odata_0;
wire                        n1_ovalid_0;
wire [`VCH_WIDTH_NUM-1:0]   n1_ovch_0;
wire [`VCH_WIDTH-1:0]       n1_olck_0;
wire [`VCH_WIDTH-1:0]       n1_oack_0;
wire                        n1_test_ack_w_0;
//n1 -> n2/n7/n0
wire [`F_NODE-1:0]          n1_faulty_out;

router #(1,WIDTHX,WIDTHY) n1(
    .clk(clk),
    .reset(reset),

    .my_xpos(1),
    .my_ypos(0),

    .idata_0(`DATA_WIDTH'b0),
    .ivalid_0(1'b0),
    .ivch_0(`VCH_WIDTH_NUM'b0),
    .oack_0(),//X
    .ordy_0(),//X
    .olck_0(),//X
    .iack_0(`VCH_WIDTH'b0),
    .ilck_0(`VCH_WIDTH'b0),
    .odata_0(),//X
    .ovalid_0(),//X
    .ovch_0(),//X

    .idata_1(n2_odata_1),
    .ivalid_1(n2_ovalid_1),
    .ivch_1(n2_ovch_1),
    .oack_1(n1_oack_2),
    .ordy_1(),//X
    .olck_1(n1_olck_2),
    .iack_1(n2_oack_1),
    .ilck_1(n2_olck_1),
    .odata_1(n1_odata_2),
    .ovalid_1(n1_ovalid_2),
    .ovch_1(n1_ovch_2),

    .idata_2(n7_odata_1),
    .ivalid_2(n7_ovalid_1),
    .ivch_2(n7_ovch_1),
    .oack_2(n1_oack_7),
    .ordy_2(),//X
    .olck_2(n1_olck_7),
    .iack_2(n7_oack_1),
    .ilck_2(n7_olck_1),
    .odata_2(n1_odata_7),
    .ovalid_2(n1_ovalid_7),
    .ovch_2(n1_ovch_7),

    .idata_3(n0_odata_1),
    .ivalid_3(n0_ovalid_1),
    .ivch_3(n0_ovch_1),
    .oack_3(n1_oack_0),
    .ordy_3(),//X
    .olck_3(n1_olck_0),
    .iack_3(n0_oack_1),
    .ilck_3(n0_olck_1),
    .odata_3(n1_odata_0),
    .ovalid_3(n1_ovalid_0),
    .ovch_3(n1_ovch_0),

    .idata_4(n1_idata_p0),
    .ivalid_4(n1_ivalid_p0),
    .ivch_4(n1_ivch_p0),
    .oack_4(),//X
    .ordy_4(n1_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n1_odata_p0),
    .ovalid_4(n1_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(),//X
    .test_ack_e_in(n2_test_ack_w_1),
    .test_ack_s_in(n7_test_ack_n_1),
    .test_ack_w_in(n0_test_ack_e_1),
    .n_faulty(),//X
    .e_faulty(n2_faulty_out),
    .s_faulty(n7_faulty_out),
    .w_faulty(n0_faulty_out),
    .test_ack_n(),//X
    .faulty_to_out(n1_faulty_out),//給四面八方
    .test_ack_e(n1_test_ack_e_2),
    .test_ack_s(n1_test_ack_s_7),
    .test_ack_w(n1_test_ack_w_0),
    .test_set_to_input(n1_test_set)
);
//n2 --> n3 port 1
wire [`DATA_WIDTH-1:0]      n2_odata_3;
wire                        n2_ovalid_3;
wire [`VCH_WIDTH_NUM-1:0]   n2_ovch_3;
wire [`VCH_WIDTH-1:0]       n2_olck_3;
wire [`VCH_WIDTH-1:0]       n2_oack_3;
wire                        n2_test_ack_e_3;

//n2 --> n8 port 2
wire [`DATA_WIDTH-1:0]      n2_odata_8;
wire                        n2_ovalid_8;
wire [`VCH_WIDTH_NUM-1:0]   n2_ovch_8;
wire [`VCH_WIDTH-1:0]       n2_olck_8;
wire [`VCH_WIDTH-1:0]       n2_oack_8;
wire                        n2_test_ack_s_8;
//n2 --> n1 port 3
wire [`DATA_WIDTH-1:0]      n2_odata_1;
wire                        n2_ovalid_1;
wire [`VCH_WIDTH_NUM-1:0]   n2_ovch_1;
wire [`VCH_WIDTH-1:0]       n2_olck_1;
wire [`VCH_WIDTH-1:0]       n2_oack_1;
wire                        n2_test_ack_w_1;
//n2 -> n3 n8 n1
wire [`F_NODE-1:0]          n2_faulty_out;
router #(2,WIDTHX,WIDTHY) n2(
    .clk(clk),
    .reset(reset),

    .my_xpos(2),
    .my_ypos(0),

    .idata_0(`DATA_WIDTH'b0),
    .ivalid_0(1'b0),
    .ivch_0(`VCH_WIDTH_NUM'b0),
    .oack_0(),//X
    .ordy_0(),//X
    .olck_0(),//X
    .iack_0(`VCH_WIDTH'b0),
    .ilck_0(`VCH_WIDTH'b0),
    .odata_0(),//X
    .ovalid_0(),//X
    .ovch_0(),//X


    .idata_1(n3_odata_2),
    .ivalid_1(n3_ovalid_2),
    .ivch_1(n3_ovch_2),
    .oack_1(n2_oack_3),
    .ordy_1(),//X
    .olck_1(n2_olck_3),
    .iack_1(n3_oack_2),
    .ilck_1(n3_olck_2),
    .odata_1(n2_odata_3),
    .ovalid_1(n2_ovalid_3),
    .ovch_1(n2_ovch_3),

    .idata_2(n8_odata_2),
    .ivalid_2(n8_ovalid_2),
    .ivch_2(n8_ovch_2),
    .oack_2(n2_oack_8),
    .ordy_2(),//X
    .olck_2(n2_olck_8),
    .iack_2(n8_oack_2),
    .ilck_2(n8_olck_2),
    .odata_2(n2_odata_8),
    .ovalid_2(n2_ovalid_8),
    .ovch_2(n2_ovch_8),

    .idata_3(n1_odata_2),
    .ivalid_3(n1_ovalid_2),
    .ivch_3(n1_ovch_2),
    .oack_3(n2_oack_1),
    .ordy_3(),//X
    .olck_3(n2_olck_1),
    .iack_3(n1_oack_2),
    .ilck_3(n1_olck_2),
    .odata_3(n2_odata_1),
    .ovalid_3(n2_ovalid_1),
    .ovch_3(n2_ovch_1),

    .idata_4(n2_idata_p0),
    .ivalid_4(n2_ivalid_p0),
    .ivch_4(n2_ivch_p0),
    .oack_4(),//X
    .ordy_4(n2_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n2_odata_p0),
    .ovalid_4(n2_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(),//X
    .test_ack_e_in(n3_test_ack_w_2),
    .test_ack_s_in(n8_test_ack_n_2),
    .test_ack_w_in(n1_test_ack_e_2),
    .n_faulty(),//X
    .e_faulty(n3_faulty_out),
    .s_faulty(n8_faulty_out),
    .w_faulty(n1_faulty_out),//X
    .test_ack_n(),//X
    .faulty_to_out(n2_faulty_out),//給四面八方
    .test_ack_e(n2_test_ack_e_3),
    .test_ack_s(n2_test_ack_s_8),
    .test_ack_w(n2_test_ack_w_1),
    .test_set_to_input(n2_test_set)
);

//n3 --> n4 port 1
wire [`DATA_WIDTH-1:0]      n3_odata_4;
wire                        n3_ovalid_4;
wire [`VCH_WIDTH_NUM-1:0]   n3_ovch_4;
wire [`VCH_WIDTH-1:0]       n3_olck_4;
wire [`VCH_WIDTH-1:0]       n3_oack_4;
wire                        n3_test_ack_e_4;
//n3 --> n9 port 2
wire [`DATA_WIDTH-1:0]      n3_odata_9;
wire                        n3_ovalid_9;
wire [`VCH_WIDTH_NUM-1:0]   n3_ovch_9;
wire [`VCH_WIDTH-1:0]       n3_olck_9;
wire [`VCH_WIDTH-1:0]       n3_oack_9;
wire                        n3_test_ack_s_9;
//n3 --> n2 port 3
wire [`DATA_WIDTH-1:0]      n3_odata_2;
wire                        n3_ovalid_2;
wire [`VCH_WIDTH_NUM-1:0]   n3_ovch_2;
wire [`VCH_WIDTH-1:0]       n3_olck_2;
wire [`VCH_WIDTH-1:0]       n3_oack_2;
wire                        n3_test_ack_w_2;
//n3 -> n4 n9 n2
wire [`F_NODE-1:0]          n3_faulty_out;
router #(3,WIDTHX,WIDTHY) n3(
    .clk(clk),
    .reset(reset),

    .my_xpos(3),
    .my_ypos(0),

    .idata_0(`DATA_WIDTH'b0),
    .ivalid_0(1'b0),
    .ivch_0(`VCH_WIDTH_NUM'b0),
    .oack_0(),//X
    .ordy_0(),//X
    .olck_0(),//X
    .iack_0(`VCH_WIDTH'b0),
    .ilck_0(`VCH_WIDTH'b0),
    .odata_0(),//X
    .ovalid_0(),//X
    .ovch_0(),//X

    .idata_1(n4_odata_3),
    //.idata_1(),
    .ivalid_1(n4_ovalid_3),
    .ivch_1(n4_ovch_3),
    .oack_1(n3_oack_4),
    .ordy_1(),//X
    .olck_1(n3_olck_4),
    .iack_1(n4_oack_3),
    .ilck_1(n4_olck_3),
    .odata_1(n3_odata_4),
    .ovalid_1(n3_ovalid_4),
    .ovch_1(n3_ovch_4),

    .idata_2(n9_odata_3),
    .ivalid_2(n9_ovalid_3),
    .ivch_2(n9_ovch_3),
    .oack_2(n3_oack_9),
    .ordy_2(),//X
    .olck_2(n3_olck_9),
    .iack_2(n9_oack_3),
    .ilck_2(n9_olck_3),
    .odata_2(n3_odata_9),
    .ovalid_2(n3_ovalid_9),
    .ovch_2(n3_ovch_9),

    .idata_3(n2_odata_3),
    .ivalid_3(n2_ovalid_3),
    .ivch_3(n2_ovch_3),
    .oack_3(n3_oack_2),
    .ordy_3(),
    .olck_3(n3_olck_2),
    .iack_3(n2_oack_3),
    .ilck_3(n2_olck_3),
    .odata_3(n3_odata_2),
    .ovalid_3(n3_ovalid_2),
    .ovch_3(n3_ovch_2),

    .idata_4(n3_idata_p0),
    .ivalid_4(n3_ivalid_p0),
    .ivch_4(n3_ivch_p0),
    .oack_4(),//X
    .ordy_4(n3_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n3_odata_p0),
    .ovalid_4(n3_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(),
    .test_ack_e_in(n4_test_ack_w_3),
    .test_ack_s_in(n9_test_ack_n_3),
    .test_ack_w_in(n2_test_ack_e_3),
    .n_faulty(),//X
    .e_faulty(n4_faulty_out),
    .s_faulty(n9_faulty_out),
    .w_faulty(n2_faulty_out),//X
    .test_ack_n(),
    .faulty_to_out(n3_faulty_out),//給四面八方
    .test_ack_e(n3_test_ack_e_4),
    .test_ack_s(n3_test_ack_s_9),
    .test_ack_w(n3_test_ack_w_2),//X
    .test_set_to_input(n3_test_set)
);

//n4 --> n5 port 1
wire [`DATA_WIDTH-1:0]      n4_odata_5;
wire                        n4_ovalid_5;
wire [`VCH_WIDTH_NUM-1:0]   n4_ovch_5;
wire [`VCH_WIDTH-1:0]       n4_olck_5;
wire [`VCH_WIDTH-1:0]       n4_oack_5;
wire                        n4_test_ack_e_5;
//n4 --> n10 port 2
wire [`DATA_WIDTH-1:0]      n4_odata_10;
wire                        n4_ovalid_10;
wire [`VCH_WIDTH_NUM-1:0]   n4_ovch_10;
wire [`VCH_WIDTH-1:0]       n4_olck_10;
wire [`VCH_WIDTH-1:0]       n4_oack_10;
wire                        n4_test_ack_s_10;
//n4 --> n3 port 3
wire [`DATA_WIDTH-1:0]      n4_odata_3;
wire                        n4_ovalid_3;
wire [`VCH_WIDTH_NUM-1:0]   n4_ovch_3;
wire [`VCH_WIDTH-1:0]       n4_olck_3;
wire [`VCH_WIDTH-1:0]       n4_oack_3;
wire                        n4_test_ack_w_3;
//n4 -> n5 n10 n3
wire [`F_NODE-1:0]          n4_faulty_out;
router #(4,WIDTHX,WIDTHY) n4(
    .clk(clk),
    .reset(reset),

    .my_xpos(4),
    .my_ypos(0),

    .idata_0(`DATA_WIDTH'b0),
    .ivalid_0(1'b0),
    .ivch_0(`VCH_WIDTH_NUM'b0),
    .oack_0(),//X
    .ordy_0(),//X
    .olck_0(),//X
    .iack_0(`VCH_WIDTH'b0),
    .ilck_0(`VCH_WIDTH'b0),
    .odata_0(),//X
    .ovalid_0(),//X
    .ovch_0(),//X

    .idata_1(n5_odata_4),
    .ivalid_1(n5_ovalid_4),
    .ivch_1(n5_ovch_4),
    .oack_1(n4_oack_5),
    .ordy_1(),//X
    .olck_1(n4_olck_5),
    .iack_1(n5_oack_4),
    .ilck_1(n5_olck_4),
    .odata_1(n4_odata_5),
    .ovalid_1(n4_ovalid_5),
    .ovch_1(n4_ovch_5),

    .idata_2(n10_odata_4),
    .ivalid_2(n10_ovalid_4),
    .ivch_2(n10_ovch_4),
    .oack_2(n4_oack_10),
    .ordy_2(),//X
    .olck_2(n4_olck_10),
    .iack_2(n10_oack_4),
    .ilck_2(n10_olck_4),
    .odata_2(n4_odata_10),
    .ovalid_2(n4_ovalid_10),
    .ovch_2(n4_ovch_10),

    .idata_3(n3_odata_4),
    .ivalid_3(n3_ovalid_4),
    .ivch_3(n3_ovch_4),
    .oack_3(n4_oack_3),
    .ordy_3(),//X
    .olck_3(n4_olck_3),
    .iack_3(n3_oack_4),
    .ilck_3(n3_olck_4),
    .odata_3(n4_odata_3),
    //.odata_3(),
    .ovalid_3(n4_ovalid_3),
    .ovch_3(n4_ovch_3),

    .idata_4(n4_idata_p0),
    .ivalid_4(n4_ivalid_p0),
    .ivch_4(n4_ivch_p0),
    .oack_4(),//X
    .ordy_4(n4_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n4_odata_p0),
    .ovalid_4(n4_ovalid_p0),
    .ovch_4(),//X
    
    .test_ack_n_in(),
    .test_ack_e_in(n5_test_ack_w_4),
    .test_ack_s_in(n10_test_ack_n_4),
    .test_ack_w_in(n3_test_ack_e_4),
    .n_faulty(),
    .e_faulty(n5_faulty_out),
    .s_faulty(n10_faulty_out),
    .w_faulty(n3_faulty_out),//X
    .test_ack_n(),
    .faulty_to_out(n4_faulty_out),//給四面八方
    .test_ack_e(n4_test_ack_e_5),
    .test_ack_s(n4_test_ack_s_10),
    .test_ack_w(n4_test_ack_w_3),
    .test_set_to_input(n4_test_set)
);

//n5 --> n11 port 2
wire [`DATA_WIDTH-1:0]      n5_odata_11;
wire                        n5_ovalid_11;
wire [`VCH_WIDTH_NUM-1:0]   n5_ovch_11;
wire [`VCH_WIDTH-1:0]       n5_olck_11;
wire [`VCH_WIDTH-1:0]       n5_oack_11;
wire                        n5_test_ack_s_11;
//n5 --> n4 port 3
wire [`DATA_WIDTH-1:0]      n5_odata_4;
wire                        n5_ovalid_4;
wire [`VCH_WIDTH_NUM-1:0]   n5_ovch_4;
wire [`VCH_WIDTH-1:0]       n5_olck_4;
wire [`VCH_WIDTH-1:0]       n5_oack_4;
wire                        n5_test_ack_w_4;
//n5 -> n11 n4
wire [`F_NODE-1:0]          n5_faulty_out;
router #(5,WIDTHX,WIDTHY) n5(
    .clk(clk),
    .reset(reset),

    .my_xpos(5),
    .my_ypos(0),

    .idata_0(`DATA_WIDTH'b0),
    .ivalid_0(1'b0),
    .ivch_0(`VCH_WIDTH_NUM'b0),
    .oack_0(),//X
    .ordy_0(),//X
    .olck_0(),//X
    .iack_0(`VCH_WIDTH'b0),
    .ilck_0(`VCH_WIDTH'b0),
    .odata_0(),//X
    .ovalid_0(),//X
    .ovch_0(),//X

    .idata_1(`DATA_WIDTH'b0),
    .ivalid_1(1'b0),
    .ivch_1(`VCH_WIDTH_NUM'b0),
    .oack_1(),//X
    .ordy_1(),//X
    .olck_1(),//X
    .iack_1(`VCH_WIDTH'b0),
    .ilck_1(`VCH_WIDTH'b0),
    .odata_1(),//X
    .ovalid_1(),//X
    .ovch_1(),//X

    .idata_2(n11_odata_5),
    .ivalid_2(n11_ovalid_5),
    .ivch_2(n11_ovch_5),
    .oack_2(n5_oack_11),
    .ordy_2(),//X
    .olck_2(n5_olck_11),
    .iack_2(n11_oack_5),
    .ilck_2(n11_olck_5),
    .odata_2(n5_odata_11),
    .ovalid_2(n5_ovalid_11),
    .ovch_2(n5_ovch_11),

    .idata_3(n4_odata_5),
    .ivalid_3(n4_ovalid_5),
    .ivch_3(n4_ovch_5),
    .oack_3(n5_oack_4),
    .ordy_3(),//X
    .olck_3(n5_olck_4),
    .iack_3(n4_oack_5),
    .ilck_3(n4_olck_5),
    .odata_3(n5_odata_4),
    .ovalid_3(n5_ovalid_4),
    .ovch_3(n5_ovch_4),

    .idata_4(n5_idata_p0),
    .ivalid_4(n5_ivalid_p0),
    .ivch_4(n5_ivch_p0),
    .oack_4(),//X
    .ordy_4(n5_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n5_odata_p0),
    .ovalid_4(n5_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(),//X
    .test_ack_e_in(),//X
    .test_ack_s_in(n11_test_ack_n_5),
    .test_ack_w_in(n4_test_ack_e_5),
    .n_faulty(),
    .e_faulty(),
    .s_faulty(n11_faulty_out),
    .w_faulty(n4_faulty_out),
    .faulty_to_out(n5_faulty_out),//給四面八方
    .test_ack_n(),//X
    .test_ack_e(),//X
    .test_ack_s(n5_test_ack_s_11),
    .test_ack_w(n5_test_ack_w_4),
    .test_set_to_input(n5_test_set)
    
);

//n6 --> n0 port 0
wire [`DATA_WIDTH-1:0]      n6_odata_0;
wire                        n6_ovalid_0;
wire [`VCH_WIDTH_NUM-1:0]   n6_ovch_0;
wire [`VCH_WIDTH-1:0]       n6_olck_0;
wire [`VCH_WIDTH-1:0]       n6_oack_0;
wire                        n6_test_ack_n_0;
//n6 --> n7 port 1
wire [`DATA_WIDTH-1:0]      n6_odata_7;
wire                        n6_ovalid_7;
wire [`VCH_WIDTH_NUM-1:0]   n6_ovch_7;
wire [`VCH_WIDTH-1:0]       n6_olck_7;
wire [`VCH_WIDTH-1:0]       n6_oack_7;
wire                        n6_test_ack_e_7;
//n6 --> n12 port 2
wire [`DATA_WIDTH-1:0]      n6_odata_12;
wire                        n6_ovalid_12;
wire [`VCH_WIDTH_NUM-1:0]   n6_ovch_12;
wire [`VCH_WIDTH-1:0]       n6_olck_12;
wire [`VCH_WIDTH-1:0]       n6_oack_12;
wire                        n6_test_ack_s_12;
//n6 -> 0 7 12
wire [`F_NODE-1:0]          n6_faulty_out;

router #(6,WIDTHX,WIDTHY) n6(
    .clk(clk),
    .reset(reset),

    .my_xpos(0),
    .my_ypos(1),

    .idata_0(n0_odata_6),
    .ivalid_0(n0_ovalid_6),
    .ivch_0(n0_ovch_6),
    .oack_0(n6_oack_0),
    .ordy_0(),//X
    .olck_0(n6_olck_0),
    .iack_0(n0_oack_6),
    .ilck_0(n0_olck_6),
    .odata_0(n6_odata_0),
    .ovalid_0(n6_ovalid_0),
    .ovch_0(n6_ovch_0),

    .idata_1(n7_odata_6),
    .ivalid_1(n7_ovalid_6),
    .ivch_1(n7_ovch_6),
    .oack_1(n6_oack_7),
    .ordy_1(),//X
    .olck_1(n6_olck_7),
    .iack_1(n7_oack_6),
    .ilck_1(n7_olck_6),
    .odata_1(n6_odata_7),
    .ovalid_1(n6_ovalid_7),
    .ovch_1(n6_ovch_7),

    .idata_2(n12_odata_6),
    .ivalid_2(n12_ovalid_6),
    .ivch_2(n12_ovch_6),
    .oack_2(n6_oack_12),
    .ordy_2(),//X
    .olck_2(n6_olck_12),
    .iack_2(n12_oack_6),
    .ilck_2(n12_oack_6),
    .odata_2(n6_odata_12),
    .ovalid_2(n6_ovalid_12),
    .ovch_2(n6_ovch_12),

    .idata_3(`DATA_WIDTH'b0),
    .ivalid_3(1'b0),
    .ivch_3(`VCH_WIDTH_NUM'b0),
    .oack_3(),//X
    .ordy_3(),//X
    .olck_3(),//X
    .iack_3(`VCH_WIDTH'b0),
    .ilck_3(`VCH_WIDTH'b0),
    .odata_3(),//X
    .ovalid_3(),//X
    .ovch_3(),//X

    .idata_4(n6_idata_p0),
    .ivalid_4(n6_ivalid_p0),
    .ivch_4(n6_ivch_p0),
    .oack_4(),//X
    .ordy_4(n6_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n6_odata_p0),
    .ovalid_4(n6_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n0_test_ack_s_6),
    .test_ack_e_in(n7_test_ack_w_6),
    .test_ack_s_in(n12_test_ack_n_6),
    .test_ack_w_in(),//X
    .n_faulty(n0_faulty_out),
    .e_faulty(n7_faulty_out),
    .s_faulty(n12_faulty_out),
    .w_faulty(),//X
    .faulty_to_out(n6_faulty_out),//給四面八方
    .test_ack_n(n6_test_ack_n_0),
    .test_ack_e(n6_test_ack_e_7),
    .test_ack_s(n6_test_ack_s_12),
    .test_ack_w(),//X
    .test_set_to_input(n6_test_set)
);

//n7 --> n1 port 0
wire [`DATA_WIDTH-1:0]      n7_odata_1;
wire                        n7_ovalid_1;
wire [`VCH_WIDTH_NUM-1:0]   n7_ovch_1;
wire [`VCH_WIDTH-1:0]       n7_olck_1;
wire [`VCH_WIDTH-1:0]       n7_oack_1;
wire                        n7_test_ack_n_1;
//n7 --> n8 port 1
wire [`DATA_WIDTH-1:0]      n7_odata_8;
wire                        n7_ovalid_8;
wire [`VCH_WIDTH_NUM-1:0]   n7_ovch_8;
wire [`VCH_WIDTH-1:0]       n7_olck_8;
wire [`VCH_WIDTH-1:0]       n7_oack_8;
wire                        n7_test_ack_e_8;
//n7 --> n13 port 2
wire [`DATA_WIDTH-1:0]      n7_odata_13;
wire                        n7_ovalid_13;
wire [`VCH_WIDTH_NUM-1:0]   n7_ovch_13;
wire [`VCH_WIDTH-1:0]       n7_olck_13;
wire [`VCH_WIDTH-1:0]       n7_oack_13;
wire                        n7_test_ack_s_13;
//n7 --> n6 port 3
wire [`DATA_WIDTH-1:0]      n7_odata_6;
wire                        n7_ovalid_6;
wire [`VCH_WIDTH_NUM-1:0]   n7_ovch_6;
wire [`VCH_WIDTH-1:0]       n7_olck_6;
wire [`VCH_WIDTH-1:0]       n7_oack_6;
wire                        n7_test_ack_w_6;
//n7 -> 1 8 13 6
wire [`F_NODE-1:0]          n7_faulty_out;
router #(7,WIDTHX,WIDTHY) n7(
    .clk(clk),
    .reset(reset),

    .my_xpos(1),
    .my_ypos(1),

    .idata_0(n1_odata_7),
    .ivalid_0(n1_ovalid_7),
    .ivch_0(n1_ovch_7),
    .oack_0(n7_oack_1),
    .ordy_0(),//X
    .olck_0(n7_olck_1),
    .iack_0(n1_oack_7),
    .ilck_0(n1_olck_7),
    .odata_0(n7_odata_1),
    .ovalid_0(n7_ovalid_1),
    .ovch_0(n7_ovch_1),

    .idata_1(n8_odata_7),
    .ivalid_1(n8_ovalid_7),
    .ivch_1(n8_ovch_7),
    .oack_1(n7_oack_8),
    .ordy_1(),//X
    .olck_1(n7_olck_8),
    .iack_1(n8_oack_7),
    .ilck_1(n8_olck_7),
    .odata_1(n7_odata_8),
    .ovalid_1(n7_ovalid_8),
    .ovch_1(n7_ovch_8),

    .idata_2(n13_odata_7),
    .ivalid_2(n13_ovalid_7),
    .ivch_2(n13_ovch_7),
    .oack_2(n7_oack_13),
    .ordy_2(),//X
    .olck_2(n7_olck_13),
    .iack_2(n13_oack_7),
    .ilck_2(n13_olck_7),
    .odata_2(n7_odata_13),
    .ovalid_2(n7_ovalid_13),
    .ovch_2(n7_ovch_13),

    .idata_3(n6_odata_7),
    .ivalid_3(n6_ovalid_7),
    .ivch_3(n6_ovch_7),
    .oack_3(n7_oack_6),
    .ordy_3(),//X
    .olck_3(n7_olck_6),
    .iack_3(n6_oack_7),
    .ilck_3(n6_olck_7),
    .odata_3(n7_odata_6),
    .ovalid_3(n7_ovalid_6),
    .ovch_3(n7_ovch_6),

    .idata_4(n7_idata_p0),
    .ivalid_4(n7_ivalid_p0),
    .ivch_4(n7_ivch_p0),
    .oack_4(),//X
    .ordy_4(n7_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n7_odata_p0),
    .ovalid_4(n7_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n1_test_ack_s_7),
    .test_ack_e_in(n8_test_ack_w_7),
    .test_ack_s_in(n13_test_ack_n_7),
    .test_ack_w_in(n6_test_ack_e_7),
    .n_faulty(n1_faulty_out),
    .e_faulty(n8_faulty_out),
    .s_faulty(n13_faulty_out),
    .w_faulty(n6_faulty_out),//X
    .faulty_to_out(n7_faulty_out),//給四面八方
    .test_ack_n(n7_test_ack_n_1),
    .test_ack_e(n7_test_ack_e_8),
    .test_ack_s(n7_test_ack_s_13),
    .test_ack_w(n7_test_ack_w_6),
    .test_set_to_input(n7_test_set)
);

//n8 --> n2 port 0
wire [`DATA_WIDTH-1:0]      n8_odata_2;
wire                        n8_ovalid_2;
wire [`VCH_WIDTH_NUM-1:0]   n8_ovch_2;
wire [`VCH_WIDTH-1:0]       n8_olck_2;
wire [`VCH_WIDTH-1:0]       n8_oack_2;
wire                        n8_test_ack_n_2;
//n8 --> n9 port 1
wire [`DATA_WIDTH-1:0]      n8_odata_9;
wire                        n8_ovalid_9;
wire [`VCH_WIDTH_NUM-1:0]   n8_ovch_9;
wire [`VCH_WIDTH-1:0]       n8_olck_9;
wire [`VCH_WIDTH-1:0]       n8_oack_9;
wire                        n8_test_ack_e_9;
//n8 --> n14 port 2
wire [`DATA_WIDTH-1:0]      n8_odata_14;
wire                        n8_ovalid_14;
wire [`VCH_WIDTH_NUM-1:0]   n8_ovch_14;
wire [`VCH_WIDTH-1:0]       n8_olck_14;
wire [`VCH_WIDTH-1:0]       n8_oack_14;
wire                        n8_test_ack_s_14;
//n8 --> n7 port 3
wire [`DATA_WIDTH-1:0]      n8_odata_7;
wire                        n8_ovalid_7;
wire [`VCH_WIDTH_NUM-1:0]   n8_ovch_7;
wire [`VCH_WIDTH-1:0]       n8_olck_7;
wire [`VCH_WIDTH-1:0]       n8_oack_7;
wire                        n8_test_ack_w_7;
//n8 -> 2 9 14 7
wire [`F_NODE-1:0]          n8_faulty_out;
router #(8,WIDTHX,WIDTHY) n8(
    .clk(clk),
    .reset(reset),

    .my_xpos(2),
    .my_ypos(1),

    .idata_0(n2_odata_8),
    .ivalid_0(n2_ovalid_8),
    .ivch_0(n2_ovch_8),
    .oack_0(n8_oack_2),
    .ordy_0(),//X
    .olck_0(n8_olck_2),
    .iack_0(n2_oack_8),
    .ilck_0(n2_olck_8),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n9_odata_8),
    .ivalid_1(n9_ovalid_8),
    .ivch_1(n9_ovch_8),
    .oack_1(n8_oack_9),
    .ordy_1(),//X
    .olck_1(n8_olck_9),
    .iack_1(n9_oack_8),
    .ilck_1(n9_olck_8),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n14_odata_8),
    .ivalid_2(n14_ovalid_8),
    .ivch_2(n14_ovch_8),
    .oack_2(n8_oack_14),
    .ordy_2(),//X
    .olck_2(n8_olck_14),
    .iack_2(n14_oack_8),
    .ilck_2(n14_olck_8),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n7_odata_8),
    .ivalid_3(n7_ovalid_8),
    .ivch_3(n7_ovch_8),
    .oack_3(n8_oack_7),
    .ordy_3(),//X
    .olck_3(n8_olck_7),
    .iack_3(n7_oack_8),
    .ilck_3(n7_olck_8),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n8_idata_p0),
    .ivalid_4(n8_ivalid_p0),
    .ivch_4(n8_ivch_p0),
    .oack_4(),//X
    .ordy_4(n8_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n8_odata_p0),
    .ovalid_4(n8_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n2_test_ack_s_8),
    .test_ack_e_in(n9_test_ack_w_8),
    .test_ack_s_in(n14_test_ack_n_8),
    .test_ack_w_in(n7_test_ack_e_8),
    .n_faulty(n2_faulty_out),
    .e_faulty(n9_faulty_out),
    .s_faulty(n14_faulty_out),
    .w_faulty(n7_faulty_out),
    .faulty_to_out(n8_faulty_out),//給四面八方
    .test_ack_n(n8_test_ack_n_2),
    .test_ack_e(n8_test_ack_e_9),
    .test_ack_s(n8_test_ack_s_14),
    .test_ack_w(n8_test_ack_w_7),
    .test_set_to_input(n8_test_set)
);
// router #(8) n8(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(2),
//     .my_ypos(1),

//     .idata_0(n2_odata_8),
//     .ivalid_0(n2_ovalid_8),
//     .ivch_0(n2_ovch_8),
//     .oack_0(n8_oack_2),
//     .ordy_0(),//X
//     .olck_0(n8_olck_2),
//     .iack_0(n2_oack_8),
//     .ilck_0(n2_olck_8),
//     .odata_0(n8_odata_2),
//     .ovalid_0(n8_ovalid_2),
//     .ovch_0(n8_ovch_2),

//     .idata_1(n9_odata_8),
//     .ivalid_1(n9_ovalid_8),
//     .ivch_1(n9_ovch_8),
//     .oack_1(n8_oack_9),
//     .ordy_1(),//X
//     .olck_1(n8_olck_9),
//     .iack_1(n9_oack_8),
//     .ilck_1(n9_olck_8),
//     .odata_1(n8_odata_9),
//     .ovalid_1(n8_ovalid_9),
//     .ovch_1(n8_ovch_9),

//     .idata_2(n14_odata_8),
//     .ivalid_2(n14_ovalid_8),
//     .ivch_2(n14_ovch_8),
//     .oack_2(n8_oack_14),
//     .ordy_2(),//X
//     .olck_2(n8_olck_14),
//     .iack_2(n14_oack_8),
//     .ilck_2(n14_olck_8),
//     .odata_2(n8_odata_14),
//     .ovalid_2(n8_ovalid_14),
//     .ovch_2(n8_ovch_14),

//     .idata_3(n7_odata_8),
//     .ivalid_3(n7_ovalid_8),
//     .ivch_3(n7_ovch_8),
//     .oack_3(n8_oack_7),
//     .ordy_3(),//X
//     .olck_3(n8_olck_7),
//     .iack_3(n7_oack_8),
//     .ilck_3(n7_olck_8),
//     .odata_3(n8_odata_7),
//     .ovalid_3(n8_ovalid_7),
//     .ovch_3(n8_ovch_7),

//     .idata_4(n8_idata_p0),
//     .ivalid_4(n8_ivalid_p0),
//     .ivch_4(n8_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n8_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n8_odata_p0),
//     .ovalid_4(n8_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n2_test_ack_s_8),
//     .test_ack_e_in(n9_test_ack_w_8),
//     .test_ack_s_in(n14_test_ack_n_8),
//     .test_ack_w_in(n7_test_ack_e_8),
//     .n_faulty(n2_faulty_out),
//     .e_faulty(n9_faulty_out),
//     .s_faulty(n14_faulty_out),
//     .w_faulty(n7_faulty_out),
//     .faulty_to_out(n8_faulty_out),//給四面八方
//     .test_ack_n(n8_test_ack_n_2),
//     .test_ack_e(n8_test_ack_e_9),
//     .test_ack_s(n8_test_ack_s_14),
//     .test_ack_w(n8_test_ack_w_7),
//     .test_set_to_input(n8_test_set)
// );

//n9 --> n3 port 0
wire [`DATA_WIDTH-1:0]      n9_odata_3;
wire                        n9_ovalid_3;
wire [`VCH_WIDTH_NUM-1:0]   n9_ovch_3;
wire [`VCH_WIDTH-1:0]       n9_olck_3;
wire [`VCH_WIDTH-1:0]       n9_oack_3;
wire                        n9_test_ack_n_3;
//n9 --> n10 port 1
wire [`DATA_WIDTH-1:0]      n9_odata_10;
wire                        n9_ovalid_10;
wire [`VCH_WIDTH_NUM-1:0]   n9_ovch_10;
wire [`VCH_WIDTH-1:0]       n9_olck_10;
wire [`VCH_WIDTH-1:0]       n9_oack_10;
wire                        n9_test_ack_e_10;
//n9 --> n15 port 2
wire [`DATA_WIDTH-1:0]      n9_odata_15;
wire                        n9_ovalid_15;
wire [`VCH_WIDTH_NUM-1:0]   n9_ovch_15;
wire [`VCH_WIDTH-1:0]       n9_olck_15;
wire [`VCH_WIDTH-1:0]       n9_oack_15;
wire                        n9_test_ack_s_15;
//n9 --> n8 port 3
wire [`DATA_WIDTH-1:0]      n9_odata_8;
wire                        n9_ovalid_8;
wire [`VCH_WIDTH_NUM-1:0]   n9_ovch_8;
wire [`VCH_WIDTH-1:0]       n9_olck_8;
wire [`VCH_WIDTH-1:0]       n9_oack_8;
wire                        n9_test_ack_w_8;
//n9 -> 3 10 15 8
wire [`F_NODE-1:0]          n9_faulty_out;
router #(9,WIDTHX,WIDTHY) n9(
    .clk(clk),
    .reset(reset),

    .my_xpos(3),
    .my_ypos(1),

    .idata_0(n3_odata_9),
    .ivalid_0(n3_ovalid_9),
    .ivch_0(n3_ovch_9),
    .oack_0(n9_oack_3),
    .ordy_0(),//X
    .olck_0(n9_olck_3),
    .iack_0(n3_oack_9),
    .ilck_0(n3_olck_9),
    .odata_0(n9_odata_3),
    .ovalid_0(n9_ovalid_3),
    .ovch_0(n9_ovch_3),

    .idata_1(n10_odata_9),
    .ivalid_1(n10_ovalid_9),
    .ivch_1(n10_ovch_9),
    .oack_1(n9_oack_10),
    .ordy_1(),//X
    .olck_1(n9_olck_10),
    .iack_1(n10_oack_9),
    .ilck_1(n10_olck_9),
    .odata_1(n9_odata_10),
    .ovalid_1(n9_ovalid_10),
    .ovch_1(n9_ovch_10),

    .idata_2(n15_odata_9),
    .ivalid_2(n15_ovalid_9),
    .ivch_2(n15_ovch_9),
    .oack_2(n9_oack_15),
    .ordy_2(),//X
    .olck_2(n9_olck_15),
    .iack_2(n15_oack_9),
    .ilck_2(n15_olck_9),
    .odata_2(n9_odata_15),
    .ovalid_2(n9_ovalid_15),
    .ovch_2(n9_ovch_15),

    .idata_3(n8_odata_9),
    .ivalid_3(n8_ovalid_9),
    .ivch_3(n8_ovch_9),
    .oack_3(n9_oack_8),
    .ordy_3(),//X
    .olck_3(n9_olck_8),
    .iack_3(n8_oack_9),
    .ilck_3(n8_olck_9),
    .odata_3(n9_odata_8),
    .ovalid_3(n9_ovalid_8),
    .ovch_3(n9_ovch_8),

    .idata_4(n9_idata_p0),
    .ivalid_4(n9_ivalid_p0),
    .ivch_4(n9_ivch_p0),
    .oack_4(),//X
    .ordy_4(n9_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n9_odata_p0),
    .ovalid_4(n9_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n3_test_ack_s_9),
    .test_ack_e_in(n10_test_ack_w_9),
    .test_ack_s_in(n15_test_ack_n_9),
    .test_ack_w_in(n8_test_ack_e_9),
    .n_faulty(n3_faulty_out),
    .e_faulty(n10_faulty_out),
    .s_faulty(n15_faulty_out),
    .w_faulty(n8_faulty_out),
    .faulty_to_out(n9_faulty_out),//給四面八方
    .test_ack_n(n9_test_ack_n_3),
    .test_ack_e(n9_test_ack_e_10),
    .test_ack_s(n9_test_ack_s_15),
    .test_ack_w(n9_test_ack_w_8),
    .test_set_to_input(n9_test_set)
);

//n10 --> n4 port 0
wire [`DATA_WIDTH-1:0]      n10_odata_4;
wire                        n10_ovalid_4;
wire [`VCH_WIDTH_NUM-1:0]   n10_ovch_4;
wire [`VCH_WIDTH-1:0]       n10_olck_4;
wire [`VCH_WIDTH-1:0]       n10_oack_4;
wire                        n10_test_ack_n_4;
//n10 --> n11 port 1
wire [`DATA_WIDTH-1:0]      n10_odata_11;
wire                        n10_ovalid_11;
wire [`VCH_WIDTH_NUM-1:0]   n10_ovch_11;
wire [`VCH_WIDTH-1:0]       n10_olck_11;
wire [`VCH_WIDTH-1:0]       n10_oack_11;
wire                        n10_test_ack_e_11;
//n10 --> n16 port 2
wire [`DATA_WIDTH-1:0]      n10_odata_16;
wire                        n10_ovalid_16;
wire [`VCH_WIDTH_NUM-1:0]   n10_ovch_16;
wire [`VCH_WIDTH-1:0]       n10_olck_16;
wire [`VCH_WIDTH-1:0]       n10_oack_16;
wire                        n10_test_ack_s_16;
//n10 --> n9 port 3
wire [`DATA_WIDTH-1:0]      n10_odata_9;
wire                        n10_ovalid_9;
wire [`VCH_WIDTH_NUM-1:0]   n10_ovch_9;
wire [`VCH_WIDTH-1:0]       n10_olck_9;
wire [`VCH_WIDTH-1:0]       n10_oack_9;
wire                        n10_test_ack_w_9;
//n10 -> 4 11 16 9
wire [`F_NODE-1:0]          n10_faulty_out;
router #(10,WIDTHX,WIDTHY) n10(
    .clk(clk),
    .reset(reset),

    .my_xpos(4),
    .my_ypos(1),

    .idata_0(n4_odata_10),
    .ivalid_0(n4_ovalid_10),
    .ivch_0(n4_ovch_10),
    .oack_0(n10_oack_4),
    .ordy_0(),//X
    .olck_0(n10_olck_4),
    .iack_0(n4_oack_10),
    .ilck_0(n4_olck_10),
    .odata_0(n10_odata_4),
    .ovalid_0(n10_ovalid_4),
    .ovch_0(n10_ovch_4),

    .idata_1(n11_odata_10),
    .ivalid_1(n11_ovalid_10),
    .ivch_1(n11_ovch_10),
    .oack_1(n10_oack_11),
    .ordy_1(),//X
    .olck_1(n10_olck_11),
    .iack_1(n11_oack_10),
    .ilck_1(n11_olck_10),
    .odata_1(n10_odata_11),
    .ovalid_1(n10_ovalid_11),
    .ovch_1(n10_ovch_11),

    .idata_2(n16_odata_10),
    .ivalid_2(n16_ovalid_10),
    .ivch_2(n16_ovch_10),
    .oack_2(n10_oack_16),
    .ordy_2(),//X
    .olck_2(n10_olck_16),
    .iack_2(n16_oack_10),
    .ilck_2(n16_olck_10),
    .odata_2(n10_odata_16),
    .ovalid_2(n10_ovalid_16),
    .ovch_2(n10_ovch_16),

    .idata_3(n9_odata_10),
    .ivalid_3(n9_ovalid_10),
    .ivch_3(n9_ovch_10),
    .oack_3(n10_oack_9),
    .ordy_3(),//X
    .olck_3(n10_olck_9),
    .iack_3(n9_oack_10),
    .ilck_3(n9_olck_10),
    .odata_3(n10_odata_9),
    .ovalid_3(n10_ovalid_9),
    .ovch_3(n10_ovch_9),

    .idata_4(n10_idata_p0),
    .ivalid_4(n10_ivalid_p0),
    .ivch_4(n10_ivch_p0),
    .oack_4(),//X
    .ordy_4(n10_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n10_odata_p0),
    .ovalid_4(n10_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n4_test_ack_s_10),
    .test_ack_e_in(n11_test_ack_w_10),
    .test_ack_s_in(n16_test_ack_n_10),
    .test_ack_w_in(n9_test_ack_e_10),
    .n_faulty(n4_faulty_out),
    .e_faulty(n11_faulty_out),
    .s_faulty(n16_faulty_out),
    .w_faulty(n9_faulty_out),
    .faulty_to_out(n10_faulty_out),//給四面八方
    .test_ack_n(n10_test_ack_n_4),
    .test_ack_e(n10_test_ack_e_11),
    .test_ack_s(n10_test_ack_s_16),
    .test_ack_w(n10_test_ack_w_9),
    .test_set_to_input(n10_test_set)
);

//n11 --> n5 port 0
wire [`DATA_WIDTH-1:0]      n11_odata_5;
wire                        n11_ovalid_5;
wire [`VCH_WIDTH_NUM-1:0]   n11_ovch_5;
wire [`VCH_WIDTH-1:0]       n11_olck_5;
wire [`VCH_WIDTH-1:0]       n11_oack_5;
wire                        n11_test_ack_n_5;
//n11 --> n17 port 2
wire [`DATA_WIDTH-1:0]      n11_odata_17;
wire                        n11_ovalid_17;
wire [`VCH_WIDTH_NUM-1:0]   n11_ovch_17;
wire [`VCH_WIDTH-1:0]       n11_olck_17;
wire [`VCH_WIDTH-1:0]       n11_oack_17;
wire                        n11_test_ack_s_17;
//n11 --> n10 port 3
wire [`DATA_WIDTH-1:0]      n11_odata_10;
wire                        n11_ovalid_10;
wire [`VCH_WIDTH_NUM-1:0]   n11_ovch_10;
wire [`VCH_WIDTH-1:0]       n11_olck_10;
wire [`VCH_WIDTH-1:0]       n11_oack_10;
wire                        n11_test_ack_w_10;
//n11 - 5 17 10
wire [`F_NODE-1:0]          n11_faulty_out;
router #(11,WIDTHX,WIDTHY) n11(
    .clk(clk),
    .reset(reset),

    .my_xpos(5),
    .my_ypos(1),

    .idata_0(n5_odata_11),
    .ivalid_0(n5_ovalid_11),
    .ivch_0(n5_ovch_11),
    .oack_0(n11_oack_5),
    .ordy_0(),//X
    .olck_0(n11_olck_5),
    .iack_0(n5_oack_11),
    .ilck_0(n5_olck_11),
    .odata_0(n11_odata_5),
    .ovalid_0(n11_ovalid_5),
    .ovch_0(n11_ovch_5),

    .idata_1(`DATA_WIDTH'b0),
    .ivalid_1(1'b0),
    .ivch_1(`VCH_WIDTH_NUM'b0),
    .oack_1(),//X
    .ordy_1(),//X
    .olck_1(),//X
    .iack_1(`VCH_WIDTH'b0),
    .ilck_1(`VCH_WIDTH'b0),
    .odata_1(),//X
    .ovalid_1(),//X
    .ovch_1(),//X

    .idata_2(n17_odata_11),
    .ivalid_2(n17_ovalid_11),
    .ivch_2(n17_ovch_11),
    .oack_2(n11_oack_17),
    .ordy_2(),//X
    .olck_2(n11_olck_17),
    .iack_2(n17_oack_11),
    .ilck_2(n17_olck_11),
    .odata_2(n11_odata_17),
    .ovalid_2(n11_ovalid_17),
    .ovch_2(n11_ovch_17),

    .idata_3(n10_odata_11),
    .ivalid_3(n10_ovalid_11),
    .ivch_3(n10_ovch_11),
    .oack_3(n11_oack_10),
    .ordy_3(),//X
    .olck_3(n11_olck_10),
    .iack_3(n10_oack_11),
    .ilck_3(n10_olck_11),
    .odata_3(n11_odata_10),
    .ovalid_3(n11_ovalid_10),
    .ovch_3(n11_ovch_10),

    .idata_4(n11_idata_p0),
    .ivalid_4(n11_ivalid_p0),
    .ivch_4(n11_ivch_p0),
    .oack_4(),//X
    .ordy_4(n11_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n11_odata_p0),
    .ovalid_4(n11_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n5_test_ack_s_11),
    .test_ack_e_in(),
    .test_ack_s_in(n17_test_ack_n_11),
    .test_ack_w_in(n10_test_ack_e_11),
    .n_faulty(n5_faulty_out),
    .e_faulty(),
    .s_faulty(n17_faulty_out),
    .w_faulty(n10_faulty_out),
    .faulty_to_out(n11_faulty_out),//給四面八方
    .test_ack_n(n11_test_ack_n_5),
    .test_ack_e(),
    .test_ack_s(n11_test_ack_s_17),
    .test_ack_w(n11_test_ack_w_10),
    .test_set_to_input(n11_test_set)
);

//n12 --> n6 port 0
wire [`DATA_WIDTH-1:0]      n12_odata_6;
wire                        n12_ovalid_6;
wire [`VCH_WIDTH_NUM-1:0]   n12_ovch_6;
wire [`VCH_WIDTH-1:0]       n12_olck_6;
wire [`VCH_WIDTH-1:0]       n12_oack_6;
wire                        n12_test_ack_n_6;
//n12 --> n13 port 1
wire [`DATA_WIDTH-1:0]      n12_odata_13;
wire                        n12_ovalid_13;
wire [`VCH_WIDTH_NUM-1:0]   n12_ovch_13;
wire [`VCH_WIDTH-1:0]       n12_olck_13;
wire [`VCH_WIDTH-1:0]       n12_oack_13;
wire                        n12_test_ack_e_13;
//n12 --> n18 port 2
wire [`DATA_WIDTH-1:0]      n12_odata_18;
wire                        n12_ovalid_18;
wire [`VCH_WIDTH_NUM-1:0]   n12_ovch_18;
wire [`VCH_WIDTH-1:0]       n12_olck_18;
wire [`VCH_WIDTH-1:0]       n12_oack_18;
wire                        n12_test_ack_s_18;
//n12 - 6 13 18
wire [`F_NODE-1:0]          n12_faulty_out;
router #(12,WIDTHX,WIDTHY) n12(
    .clk(clk),
    .reset(reset),

    .my_xpos(0),
    .my_ypos(2),

    .idata_0(n6_odata_12),
    .ivalid_0(n6_ovalid_12),
    .ivch_0(n6_ovch_12),
    .oack_0(n12_oack_6),
    .ordy_0(),//X
    .olck_0(n12_olck_6),
    .iack_0(n6_oack_12),
    .ilck_0(n6_olck_12),
    .odata_0(n12_odata_6),
    .ovalid_0(n12_ovalid_6),
    .ovch_0(n12_ovch_6),

    .idata_1(n13_odata_12),
    .ivalid_1(n13_ovalid_12),
    .ivch_1(n13_ovch_12),
    .oack_1(n12_oack_13),
    .ordy_1(),//X
    .olck_1(n12_olck_13),
    .iack_1(n13_oack_12),
    .ilck_1(n13_olck_12),
    .odata_1(n12_odata_13),
    .ovalid_1(n12_ovalid_13),
    .ovch_1(n12_ovch_13),

    .idata_2(n18_odata_12),
    .ivalid_2(n18_ovalid_12),
    .ivch_2(n18_ovch_12),
    .oack_2(n12_oack_18),
    .ordy_2(),//X
    .olck_2(n12_olck_18),
    .iack_2(n18_oack_12),
    .ilck_2(n18_olck_12),
    .odata_2(n12_odata_18),
    .ovalid_2(n12_ovalid_18),
    .ovch_2(n12_ovch_18),

    .idata_3(`DATA_WIDTH'b0),
    .ivalid_3(1'b0),
    .ivch_3(`VCH_WIDTH_NUM'b0),
    .oack_3(),
    .ordy_3(),//X
    .olck_3(),
    .iack_3(`VCH_WIDTH'b0),
    .ilck_3(`VCH_WIDTH'b0),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n12_idata_p0),
    .ivalid_4(n12_ivalid_p0),
    .ivch_4(n12_ivch_p0),
    .oack_4(),//X
    .ordy_4(n12_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n12_odata_p0),
    .ovalid_4(n12_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n6_test_ack_s_12),
    .test_ack_e_in(n13_test_ack_w_12),
    .test_ack_s_in(n18_test_ack_n_12),
    .test_ack_w_in(),
    .n_faulty(n6_faulty_out),
    .e_faulty(n13_faulty_out),
    .s_faulty(n18_faulty_out),
    .w_faulty(),
    .faulty_to_out(n12_faulty_out),//給四面八方
    .test_ack_n(n12_test_ack_n_6),
    .test_ack_e(n12_test_ack_e_13),
    .test_ack_s(n12_test_ack_s_18),
    .test_ack_w(),
    .test_set_to_input(n12_test_set)
);

//n13 --> n7 port 0
wire [`DATA_WIDTH-1:0]      n13_odata_7;
wire                        n13_ovalid_7;
wire [`VCH_WIDTH_NUM-1:0]   n13_ovch_7;
wire [`VCH_WIDTH-1:0]       n13_olck_7;
wire [`VCH_WIDTH-1:0]       n13_oack_7;
wire                        n13_test_ack_n_7;
//n13 --> n14 port 1
wire [`DATA_WIDTH-1:0]      n13_odata_14;
wire                        n13_ovalid_14;
wire [`VCH_WIDTH_NUM-1:0]   n13_ovch_14;
wire [`VCH_WIDTH-1:0]       n13_olck_14;
wire [`VCH_WIDTH-1:0]       n13_oack_14;
wire                        n13_test_ack_e_14;
//n13 --> n19 port 2
wire [`DATA_WIDTH-1:0]      n13_odata_19;
wire                        n13_ovalid_19;
wire [`VCH_WIDTH_NUM-1:0]   n13_ovch_19;
wire [`VCH_WIDTH-1:0]       n13_olck_19;
wire [`VCH_WIDTH-1:0]       n13_oack_19;
wire                        n13_test_ack_s_19;
//n13 --> n12 port 3
wire [`DATA_WIDTH-1:0]      n13_odata_12;
wire                        n13_ovalid_12;
wire [`VCH_WIDTH_NUM-1:0]   n13_ovch_12;
wire [`VCH_WIDTH-1:0]       n13_olck_12;
wire [`VCH_WIDTH-1:0]       n13_oack_12;
wire                        n13_test_ack_w_12;
//13 - 7 14 19 12
wire [`F_NODE-1:0]          n13_faulty_out;
router #(13,WIDTHX,WIDTHY) n13(
    .clk(clk),
    .reset(reset),

    .my_xpos(1),
    .my_ypos(2),

    .idata_0(n7_odata_13),
    .ivalid_0(n7_ovalid_13),
    .ivch_0(n7_ovch_13),
    .oack_0(n13_oack_7),
    .ordy_0(),//X
    .olck_0(n13_olck_7),
    .iack_0(n7_oack_13),
    .ilck_0(n7_olck_13),
    // .odata_0(n13_odata_7),
    // .ovalid_0(n13_ovalid_7),
    // .ovch_0(n13_ovch_7),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n14_odata_13),
    .ivalid_1(n14_ovalid_13),
    .ivch_1(n14_ovch_13),
    .oack_1(n13_oack_14),
    .ordy_1(),//X
    .olck_1(n13_olck_14),
    .iack_1(n14_oack_13),
    .ilck_1(n14_olck_13),
    // .odata_1(n13_odata_14),
    // .ovalid_1(n13_ovalid_14),
    // .ovch_1(n13_ovch_14),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n19_odata_13),
    .ivalid_2(n19_ovalid_13),
    .ivch_2(n19_ovch_13),
    .oack_2(n13_oack_19),
    .ordy_2(),//X
    .olck_2(n13_olck_19),
    .iack_2(n19_oack_13),
    .ilck_2(n19_olck_13),
    // .odata_2(n13_odata_19),
    // .ovalid_2(n13_ovalid_19),
    // .ovch_2(n13_ovch_19),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n12_odata_13),
    .ivalid_3(n12_ovalid_13),
    .ivch_3(n12_ovch_13),
    .oack_3(n13_oack_12),
    .ordy_3(),//X
    .olck_3(n13_olck_12),
    .iack_3(n12_oack_13),
    .ilck_3(n12_olck_13),
    // .odata_3(n13_odata_12),
    // .ovalid_3(n13_ovalid_12),
    // .ovch_3(n13_ovch_12),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n13_idata_p0),
    .ivalid_4(n13_ivalid_p0),
    .ivch_4(n13_ivch_p0),
    .oack_4(),//X
    .ordy_4(n13_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n13_odata_p0),
    .ovalid_4(n13_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n7_test_ack_s_13),
    .test_ack_e_in(n14_test_ack_w_13),
    .test_ack_s_in(n19_test_ack_n_13),
    .test_ack_w_in(n12_test_ack_e_13),
    .n_faulty(n7_faulty_out),
    .e_faulty(n14_faulty_out),
    .s_faulty(n19_faulty_out),
    .w_faulty(n12_faulty_out),
    .faulty_to_out(n13_faulty_out),//給四面八方
    .test_ack_n(n13_test_ack_n_7),
    .test_ack_e(n13_test_ack_e_14),
    .test_ack_s(n13_test_ack_s_19),
    .test_ack_w(n13_test_ack_w_12),
    .test_set_to_input(n13_test_set)
);

// router #(13) n13(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(1),
//     .my_ypos(2),

//     .idata_0(n7_odata_13),
//     .ivalid_0(n7_ovalid_13),
//     .ivch_0(n7_ovch_13),
//     .oack_0(n13_oack_7),
//     .ordy_0(),//X
//     .olck_0(n13_olck_7),
//     .iack_0(n7_oack_13),
//     .ilck_0(n7_olck_13),
//     .odata_0(n13_odata_7),
//     .ovalid_0(n13_ovalid_7),
//     .ovch_0(n13_ovch_7),

//     .idata_1(n14_odata_13),
//     .ivalid_1(n14_ovalid_13),
//     .ivch_1(n14_ovch_13),
//     .oack_1(n13_oack_14),
//     .ordy_1(),//X
//     .olck_1(n13_olck_14),
//     .iack_1(n14_oack_13),
//     .ilck_1(n14_olck_13),
//     .odata_1(n13_odata_14),
//     .ovalid_1(n13_ovalid_14),
//     .ovch_1(n13_ovch_14),

//     .idata_2(n19_odata_13),
//     .ivalid_2(n19_ovalid_13),
//     .ivch_2(n19_ovch_13),
//     .oack_2(n13_oack_19),
//     .ordy_2(),//X
//     .olck_2(n13_olck_19),
//     .iack_2(n19_oack_13),
//     .ilck_2(n19_olck_13),
//     .odata_2(n13_odata_19),
//     .ovalid_2(n13_ovalid_19),
//     .ovch_2(n13_ovch_19),

//     .idata_3(n12_odata_13),
//     .ivalid_3(n12_ovalid_13),
//     .ivch_3(n12_ovch_13),
//     .oack_3(n13_oack_12),
//     .ordy_3(),//X
//     .olck_3(n13_olck_12),
//     .iack_3(n12_oack_13),
//     .ilck_3(n12_olck_13),
//     .odata_3(n13_odata_12),
//     .ovalid_3(n13_ovalid_12),
//     .ovch_3(n13_ovch_12),

//     .idata_4(n13_idata_p0),
//     .ivalid_4(n13_ivalid_p0),
//     .ivch_4(n13_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n13_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n13_odata_p0),
//     .ovalid_4(n13_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n7_test_ack_s_13),
//     .test_ack_e_in(n14_test_ack_w_13),
//     .test_ack_s_in(n19_test_ack_n_13),
//     .test_ack_w_in(n12_test_ack_e_13),
//     .n_faulty(n7_faulty_out),
//     .e_faulty(n14_faulty_out),
//     .s_faulty(n19_faulty_out),
//     .w_faulty(n12_faulty_out),
//     .faulty_to_out(n13_faulty_out),//給四面八方
//     .test_ack_n(n13_test_ack_n_7),
//     .test_ack_e(n13_test_ack_e_14),
//     .test_ack_s(n13_test_ack_s_19),
//     .test_ack_w(n13_test_ack_w_12),
//     .test_set_to_input(n13_test_set)
// );

//n14 --> n8 port 0
wire [`DATA_WIDTH-1:0]      n14_odata_8;
wire                        n14_ovalid_8;
wire [`VCH_WIDTH_NUM-1:0]   n14_ovch_8;
wire [`VCH_WIDTH-1:0]       n14_olck_8;
wire [`VCH_WIDTH-1:0]       n14_oack_8;
wire                        n14_test_ack_n_8;
//n14 --> n15 port 1
wire [`DATA_WIDTH-1:0]      n14_odata_15;
wire                        n14_ovalid_15;
wire [`VCH_WIDTH_NUM-1:0]   n14_ovch_15;
wire [`VCH_WIDTH-1:0]       n14_olck_15;
wire [`VCH_WIDTH-1:0]       n14_oack_15;
wire                        n14_test_ack_e_15;
//n14 --> n20 port 2
wire [`DATA_WIDTH-1:0]      n14_odata_20;
wire                        n14_ovalid_20;
wire [`VCH_WIDTH_NUM-1:0]   n14_ovch_20;
wire [`VCH_WIDTH-1:0]       n14_olck_20;
wire [`VCH_WIDTH-1:0]       n14_oack_20;
wire                        n14_test_ack_s_20;
//n14 --> n13 port 3
wire [`DATA_WIDTH-1:0]      n14_odata_13;
wire                        n14_ovalid_13;
wire [`VCH_WIDTH_NUM-1:0]   n14_ovch_13;
wire [`VCH_WIDTH-1:0]       n14_olck_13;
wire [`VCH_WIDTH-1:0]       n14_oack_13;
wire                        n14_test_ack_w_13;
//14 - 8 15 20 13
wire [`F_NODE-1:0]          n14_faulty_out;
router #(14,WIDTHX,WIDTHY) n14(
    .clk(clk),
    .reset(reset),

    .my_xpos(2),
    .my_ypos(2),

    .idata_0(n8_odata_14),
    .ivalid_0(n8_ovalid_14),
    .ivch_0(n8_ovch_14),
    .oack_0(n14_oack_8),
    .ordy_0(),//X
    .olck_0(n14_olck_8),
    .iack_0(n8_oack_14),
    .ilck_0(n8_olck_14),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n15_odata_14),
    .ivalid_1(n15_ovalid_14),
    .ivch_1(n15_ovch_14),
    .oack_1(n14_oack_15),
    .ordy_1(),//X
    .olck_1(n14_olck_15),
    .iack_1(n15_oack_14),
    .ilck_1(n15_olck_14),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n20_odata_14),
    .ivalid_2(n20_ovalid_14),
    .ivch_2(n20_ovch_14),
    .oack_2(n14_oack_20),
    .ordy_2(),//X
    .olck_2(n14_olck_20),
    .iack_2(n20_oack_14),
    .ilck_2(n20_olck_14),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n13_odata_14),
    .ivalid_3(n13_ovalid_14),
    .ivch_3(n13_ovch_14),
    .oack_3(n14_oack_13),
    .ordy_3(),//X
    .olck_3(n14_olck_13),
    .iack_3(n13_oack_14),
    .ilck_3(n13_olck_14),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n14_idata_p0),
    .ivalid_4(n14_ivalid_p0),
    .ivch_4(n14_ivch_p0),
    .oack_4(),//X
    .ordy_4(n14_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n14_odata_p0),
    .ovalid_4(n14_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n8_test_ack_s_14),
    .test_ack_e_in(n15_test_ack_w_14),
    .test_ack_s_in(n20_test_ack_n_14),
    .test_ack_w_in(n13_test_ack_e_14),
    .n_faulty(n8_faulty_out),
    .e_faulty(n15_faulty_out),
    .s_faulty(n20_faulty_out),
    .w_faulty(n13_faulty_out),
    .faulty_to_out(n14_faulty_out),//給四面八方
    .test_ack_n(n14_test_ack_n_8),
    .test_ack_e(n14_test_ack_e_15),
    .test_ack_s(n14_test_ack_s_20),
    .test_ack_w(n14_test_ack_w_13),
    .test_set_to_input(n14_test_set)
);
// router #(14) n14(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(2),
//     .my_ypos(2),

//     .idata_0(n8_odata_14),
//     .ivalid_0(n8_ovalid_14),
//     .ivch_0(n8_ovch_14),
//     .oack_0(n14_oack_8),
//     .ordy_0(),//X
//     .olck_0(n14_olck_8),
//     .iack_0(n8_oack_14),
//     .ilck_0(n8_olck_14),
//     .odata_0(n14_odata_8),
//     .ovalid_0(n14_ovalid_8),
//     .ovch_0(n14_ovch_8),

//     .idata_1(n15_odata_14),
//     .ivalid_1(n15_ovalid_14),
//     .ivch_1(n15_ovch_14),
//     .oack_1(n14_oack_15),
//     .ordy_1(),//X
//     .olck_1(n14_olck_15),
//     .iack_1(n15_oack_14),
//     .ilck_1(n15_olck_14),
//     .odata_1(n14_odata_15),
//     .ovalid_1(n14_ovalid_15),
//     .ovch_1(n14_ovch_15),

//     .idata_2(n20_odata_14),
//     .ivalid_2(n20_ovalid_14),
//     .ivch_2(n20_ovch_14),
//     .oack_2(n14_oack_20),
//     .ordy_2(),//X
//     .olck_2(n14_olck_20),
//     .iack_2(n20_oack_14),
//     .ilck_2(n20_olck_14),
//     .odata_2(n14_odata_20),
//     .ovalid_2(n14_ovalid_20),
//     .ovch_2(n14_ovch_20),

//     .idata_3(n13_odata_14),
//     .ivalid_3(n13_ovalid_14),
//     .ivch_3(n13_ovch_14),
//     .oack_3(n14_oack_13),
//     .ordy_3(),//X
//     .olck_3(n14_olck_13),
//     .iack_3(n13_oack_14),
//     .ilck_3(n13_olck_14),
//     .odata_3(n14_odata_13),
//     .ovalid_3(n14_ovalid_13),
//     .ovch_3(n14_ovch_13),

//     .idata_4(n14_idata_p0),
//     .ivalid_4(n14_ivalid_p0),
//     .ivch_4(n14_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n14_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n14_odata_p0),
//     .ovalid_4(n14_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n8_test_ack_s_14),
//     .test_ack_e_in(n15_test_ack_w_14),
//     .test_ack_s_in(n20_test_ack_n_14),
//     .test_ack_w_in(n13_test_ack_e_14),
//     .n_faulty(n8_faulty_out),
//     .e_faulty(n15_faulty_out),
//     .s_faulty(n20_faulty_out),
//     .w_faulty(n13_faulty_out),
//     .faulty_to_out(n14_faulty_out),//給四面八方
//     .test_ack_n(n14_test_ack_n_8),
//     .test_ack_e(n14_test_ack_e_15),
//     .test_ack_s(n14_test_ack_s_20),
//     .test_ack_w(n14_test_ack_w_13),
//     .test_set_to_input(n14_test_set)
// );

//n15 --> n9 port 0
wire [`DATA_WIDTH-1:0]      n15_odata_9;
wire                        n15_ovalid_9;
wire [`VCH_WIDTH_NUM-1:0]   n15_ovch_9;
wire [`VCH_WIDTH-1:0]       n15_olck_9;
wire [`VCH_WIDTH-1:0]       n15_oack_9;
wire                        n15_test_ack_n_9;
//n15 --> n16 port 1
wire [`DATA_WIDTH-1:0]      n15_odata_16;
wire                        n15_ovalid_16;
wire [`VCH_WIDTH_NUM-1:0]   n15_ovch_16;
wire [`VCH_WIDTH-1:0]       n15_olck_16;
wire [`VCH_WIDTH-1:0]       n15_oack_16;
wire                        n15_test_ack_e_16;
//n15 --> n21 port 2
wire [`DATA_WIDTH-1:0]      n15_odata_21;
wire                        n15_ovalid_21;
wire [`VCH_WIDTH_NUM-1:0]   n15_ovch_21;
wire [`VCH_WIDTH-1:0]       n15_olck_21;
wire [`VCH_WIDTH-1:0]       n15_oack_21;
wire                        n15_test_ack_s_21;
//n15 --> n14 port 3
wire [`DATA_WIDTH-1:0]      n15_odata_14;
wire                        n15_ovalid_14;
wire [`VCH_WIDTH_NUM-1:0]   n15_ovch_14;
wire [`VCH_WIDTH-1:0]       n15_olck_14;
wire [`VCH_WIDTH-1:0]       n15_oack_14;
wire                        n15_test_ack_w_14;
//15 - 9 16 21 14
wire [`F_NODE-1:0]          n15_faulty_out;
router #(15,WIDTHX,WIDTHY) n15(
    .clk(clk),
    .reset(reset),

    .my_xpos(3),
    .my_ypos(2),

    .idata_0(n9_odata_15),
    .ivalid_0(n9_ovalid_15),
    .ivch_0(n9_ovch_15),
    .oack_0(n15_oack_9),
    .ordy_0(),//X
    .olck_0(n15_olck_9),
    .iack_0(n9_oack_15),
    .ilck_0(n9_olck_15),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n16_odata_15),
    .ivalid_1(n16_ovalid_15),
    .ivch_1(n16_ovch_15),
    .oack_1(n15_oack_16),
    .ordy_1(),//X
    .olck_1(n15_olck_16),
    .iack_1(n16_oack_15),
    .ilck_1(n16_olck_15),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n21_odata_15),
    .ivalid_2(n21_ovalid_15),
    .ivch_2(n21_ovch_15),
    .oack_2(n15_oack_21),
    .ordy_2(),//X
    .olck_2(n15_olck_21),
    .iack_2(n21_oack_15),
    .ilck_2(n21_olck_15),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n14_odata_15),
    .ivalid_3(n14_ovalid_15),
    .ivch_3(n14_ovch_15),
    .oack_3(n15_oack_14),
    .ordy_3(),//X
    .olck_3(n15_olck_14),
    .iack_3(n14_oack_15),
    .ilck_3(n14_olck_15),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n15_idata_p0),
    .ivalid_4(n15_ivalid_p0),
    .ivch_4(n15_ivch_p0),
    .oack_4(),//X
    .ordy_4(n15_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n15_odata_p0),
    .ovalid_4(n15_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n9_test_ack_s_15),
    .test_ack_e_in(n16_test_ack_w_15),
    .test_ack_s_in(n21_test_ack_n_15),
    .test_ack_w_in(n14_test_ack_e_15),
    .n_faulty(n9_faulty_out),
    .e_faulty(n16_faulty_out),
    .s_faulty(n12_faulty_out),
    .w_faulty(n14_faulty_out),
    .faulty_to_out(n15_faulty_out),//給四面八方
    .test_ack_n(n15_test_ack_n_9),
    .test_ack_e(n15_test_ack_e_16),
    .test_ack_s(n15_test_ack_s_21),
    .test_ack_w(n15_test_ack_w_14),
    .test_set_to_input(n15_test_set)
);

// router #(15) n15(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(3),
//     .my_ypos(2),

//     .idata_0(n9_odata_15),
//     .ivalid_0(n9_ovalid_15),
//     .ivch_0(n9_ovch_15),
//     .oack_0(n15_oack_9),
//     .ordy_0(),//X
//     .olck_0(n15_olck_9),
//     .iack_0(n9_oack_15),
//     .ilck_0(n9_olck_15),
//     .odata_0(n15_odata_9),
//     .ovalid_0(n15_ovalid_9),
//     .ovch_0(n15_ovch_9),

//     .idata_1(n16_odata_15),
//     .ivalid_1(n16_ovalid_15),
//     .ivch_1(n16_ovch_15),
//     .oack_1(n15_oack_16),
//     .ordy_1(),//X
//     .olck_1(n15_olck_16),
//     .iack_1(n16_oack_15),
//     .ilck_1(n16_olck_15),
//     .odata_1(n15_odata_16),
//     .ovalid_1(n15_ovalid_16),
//     .ovch_1(n15_ovch_16),

//     .idata_2(n21_odata_15),
//     .ivalid_2(n21_ovalid_15),
//     .ivch_2(n21_ovch_15),
//     .oack_2(n15_oack_21),
//     .ordy_2(),//X
//     .olck_2(n15_olck_21),
//     .iack_2(n21_oack_15),
//     .ilck_2(n21_olck_15),
//     .odata_2(n15_odata_21),
//     .ovalid_2(n15_ovalid_21),
//     .ovch_2(n15_ovch_21),

//     .idata_3(n14_odata_15),
//     .ivalid_3(n14_ovalid_15),
//     .ivch_3(n14_ovch_15),
//     .oack_3(n15_oack_14),
//     .ordy_3(),//X
//     .olck_3(n15_olck_14),
//     .iack_3(n14_oack_15),
//     .ilck_3(n14_olck_15),
//     .odata_3(n15_odata_14),
//     .ovalid_3(n15_ovalid_14),
//     .ovch_3(n15_ovch_14),

//     .idata_4(n15_idata_p0),
//     .ivalid_4(n15_ivalid_p0),
//     .ivch_4(n15_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n15_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n15_odata_p0),
//     .ovalid_4(n15_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n9_test_ack_s_15),
//     .test_ack_e_in(n16_test_ack_w_15),
//     .test_ack_s_in(n21_test_ack_n_15),
//     .test_ack_w_in(n14_test_ack_e_15),
//     .n_faulty(n9_faulty_out),
//     .e_faulty(n16_faulty_out),
//     .s_faulty(n12_faulty_out),
//     .w_faulty(n14_faulty_out),
//     .faulty_to_out(n15_faulty_out),//給四面八方
//     .test_ack_n(n15_test_ack_n_9),
//     .test_ack_e(n15_test_ack_e_16),
//     .test_ack_s(n15_test_ack_s_21),
//     .test_ack_w(n15_test_ack_w_14),
//     .test_set_to_input(n15_test_set)
// );

//n16 --> n10 port 0
wire [`DATA_WIDTH-1:0]      n16_odata_10;
wire                        n16_ovalid_10;
wire [`VCH_WIDTH_NUM-1:0]   n16_ovch_10;
wire [`VCH_WIDTH-1:0]       n16_olck_10;
wire [`VCH_WIDTH-1:0]       n16_oack_10;
wire                        n16_test_ack_n_10;
//n16 --> n17 port 1
wire [`DATA_WIDTH-1:0]      n16_odata_17;
wire                        n16_ovalid_17;
wire [`VCH_WIDTH_NUM-1:0]   n16_ovch_17;
wire [`VCH_WIDTH-1:0]       n16_olck_17;
wire [`VCH_WIDTH-1:0]       n16_oack_17;
wire                        n16_test_ack_e_17;
//n16 --> n22 port 2
wire [`DATA_WIDTH-1:0]      n16_odata_22;
wire                        n16_ovalid_22;
wire [`VCH_WIDTH_NUM-1:0]   n16_ovch_22;
wire [`VCH_WIDTH-1:0]       n16_olck_22;
wire [`VCH_WIDTH-1:0]       n16_oack_22;
wire                        n16_test_ack_s_22;
//n16 --> n15 port 3
wire [`DATA_WIDTH-1:0]      n16_odata_15;
wire                        n16_ovalid_15;
wire [`VCH_WIDTH_NUM-1:0]   n16_ovch_15;
wire [`VCH_WIDTH-1:0]       n16_olck_15;
wire [`VCH_WIDTH-1:0]       n16_oack_15;
wire                        n16_test_ack_w_15;
//16 - 10 17 22 15
wire [`F_NODE-1:0]          n16_faulty_out;
router #(16,WIDTHX,WIDTHY) n16(
    .clk(clk),
    .reset(reset),

    .my_xpos(4),
    .my_ypos(2),

    .idata_0(n10_odata_16),
    .ivalid_0(n10_ovalid_16),
    .ivch_0(n10_ovch_16),
    .oack_0(n16_oack_10),
    .ordy_0(),//X
    .olck_0(n16_olck_10),
    .iack_0(n10_oack_16),
    .ilck_0(n10_olck_16),
    .odata_0(n16_odata_10),
    .ovalid_0(n16_ovalid_10),
    .ovch_0(n16_ovch_10),

    .idata_1(n17_odata_16),
    .ivalid_1(n17_ovalid_16),
    .ivch_1(n17_ovch_16),
    .oack_1(n16_oack_17),
    .ordy_1(),//X
    .olck_1(n16_olck_17),
    .iack_1(n17_oack_16),
    .ilck_1(n17_olck_16),
    .odata_1(n16_odata_17),
    .ovalid_1(n16_ovalid_17),
    .ovch_1(n16_ovch_17),

    .idata_2(n22_odata_16),
    .ivalid_2(n22_ovalid_16),
    .ivch_2(n22_ovch_16),
    .oack_2(n16_oack_22),
    .ordy_2(),//X
    .olck_2(n16_olck_22),
    .iack_2(n22_oack_16),
    .ilck_2(n22_olck_16),
    .odata_2(n16_odata_22),
    .ovalid_2(n16_ovalid_22),
    .ovch_2(n16_ovch_22),

    .idata_3(n15_odata_16),
    .ivalid_3(n15_ovalid_16),
    .ivch_3(n15_ovch_16),
    .oack_3(n16_oack_15),
    .ordy_3(),//X
    .olck_3(n16_olck_15),
    .iack_3(n15_oack_16),
    .ilck_3(n15_olck_16),
    .odata_3(n16_odata_15),
    .ovalid_3(n16_ovalid_15),
    .ovch_3(n16_ovch_15),

    .idata_4(n16_idata_p0),
    .ivalid_4(n16_ivalid_p0),
    .ivch_4(n16_ivch_p0),
    .oack_4(),//X
    .ordy_4(n16_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n16_odata_p0),
    .ovalid_4(n16_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n10_test_ack_s_16),
    .test_ack_e_in(n17_test_ack_w_16),
    .test_ack_s_in(n22_test_ack_n_16),
    .test_ack_w_in(n15_test_ack_e_16),
    .n_faulty(n10_faulty_out),
    .e_faulty(n17_faulty_out),
    .s_faulty(n22_faulty_out),
    .w_faulty(n15_faulty_out),
    .faulty_to_out(n16_faulty_out),//給四面八方
    .test_ack_n(n16_test_ack_n_10),
    .test_ack_e(n16_test_ack_e_17),
    .test_ack_s(n16_test_ack_s_22),
    .test_ack_w(n16_test_ack_w_15),
    .test_set_to_input(n16_test_set)
);

//n17 --> n11 port 0
wire [`DATA_WIDTH-1:0]      n17_odata_11;
wire                        n17_ovalid_11;
wire [`VCH_WIDTH_NUM-1:0]   n17_ovch_11;
wire [`VCH_WIDTH-1:0]       n17_olck_11;
wire [`VCH_WIDTH-1:0]       n17_oack_11;
wire                        n17_test_ack_n_11;
//n17 --> n23 port 2
wire [`DATA_WIDTH-1:0]      n17_odata_23;
wire                        n17_ovalid_23;
wire [`VCH_WIDTH_NUM-1:0]   n17_ovch_23;
wire [`VCH_WIDTH-1:0]       n17_olck_23;
wire [`VCH_WIDTH-1:0]       n17_oack_23;
wire                        n17_test_ack_s_23;
//n17 --> n16 port 3
wire [`DATA_WIDTH-1:0]      n17_odata_16;
wire                        n17_ovalid_16;
wire [`VCH_WIDTH_NUM-1:0]   n17_ovch_16;
wire [`VCH_WIDTH-1:0]       n17_olck_16;
wire [`VCH_WIDTH-1:0]       n17_oack_16;
wire                        n17_test_ack_w_16;
//n17 - 11 23 16
wire [`F_NODE-1:0]          n17_faulty_out;

router #(17,WIDTHX,WIDTHY) n17(
    .clk(clk),
    .reset(reset),

    .my_xpos(5),
    .my_ypos(2),

    .idata_0(n11_odata_17),
    .ivalid_0(n11_ovalid_17),
    .ivch_0(n11_ovch_17),
    .oack_0(n17_oack_11),
    .ordy_0(),//X
    .olck_0(n17_olck_11),
    .iack_0(n11_oack_17),
    .ilck_0(n11_olck_17),
    .odata_0(n17_odata_11),
    .ovalid_0(n17_ovalid_11),
    .ovch_0(n17_ovch_11),

    .idata_1(`DATA_WIDTH'b0),
    .ivalid_1(1'b0),
    .ivch_1(`VCH_WIDTH_NUM'b0),
    .oack_1(),
    .ordy_1(),//X
    .olck_1(),
    .iack_1(`VCH_WIDTH'b0),
    .ilck_1(`VCH_WIDTH'b0),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n23_odata_17),
    .ivalid_2(n23_ovalid_17),
    .ivch_2(n23_ovch_17),
    .oack_2(n17_oack_23),
    .ordy_2(),//X
    .olck_2(n17_olck_23),
    .iack_2(n23_oack_17),
    .ilck_2(n23_olck_17),
    .odata_2(n17_odata_23),
    .ovalid_2(n17_ovalid_23),
    .ovch_2(n17_ovch_23),

    .idata_3(n16_odata_17),
    .ivalid_3(n16_ovalid_17),
    .ivch_3(n16_ovch_17),
    .oack_3(n17_oack_16),
    .ordy_3(),//X
    .olck_3(n17_olck_16),
    .iack_3(n16_oack_17),
    .ilck_3(n16_olck_17),
    .odata_3(n17_odata_16),
    .ovalid_3(n17_ovalid_16),
    .ovch_3(n17_ovch_16),

    .idata_4(n17_idata_p0),
    .ivalid_4(n17_ivalid_p0),
    .ivch_4(n17_ivch_p0),
    .oack_4(),//X
    .ordy_4(n17_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n17_odata_p0),
    .ovalid_4(n17_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n11_test_ack_s_17),
    .test_ack_e_in(),
    .test_ack_s_in(n23_test_ack_n_17),
    .test_ack_w_in(n16_test_ack_e_17),
    .n_faulty(n11_faulty_out),
    .e_faulty(),
    .s_faulty(n23_faulty_out),
    .w_faulty(n16_faulty_out),
    .faulty_to_out(n17_faulty_out),//給四面八方
    .test_ack_n(n17_test_ack_n_11),
    .test_ack_e(),
    .test_ack_s(n17_test_ack_s_23),
    .test_ack_w(n17_test_ack_w_16),
    .test_set_to_input(n17_test_set)
);

//n18 --> n12 port 0
wire [`DATA_WIDTH-1:0]      n18_odata_12;
wire                        n18_ovalid_12;
wire [`VCH_WIDTH_NUM-1:0]   n18_ovch_12;
wire [`VCH_WIDTH-1:0]       n18_olck_12;
wire [`VCH_WIDTH-1:0]       n18_oack_12;
wire                        n18_test_ack_n_12;
//n18 --> n19 port 1
wire [`DATA_WIDTH-1:0]      n18_odata_19;
wire                        n18_ovalid_19;
wire [`VCH_WIDTH_NUM-1:0]   n18_ovch_19;
wire [`VCH_WIDTH-1:0]       n18_olck_19;
wire [`VCH_WIDTH-1:0]       n18_oack_19;
wire                        n18_test_ack_e_19;
//n18 --> n24 port 2
wire [`DATA_WIDTH-1:0]      n18_odata_24;
wire                        n18_ovalid_24;
wire [`VCH_WIDTH_NUM-1:0]   n18_ovch_24;
wire [`VCH_WIDTH-1:0]       n18_olck_24;
wire [`VCH_WIDTH-1:0]       n18_oack_24;
wire                        n18_test_ack_s_24;
//18 - 12 19 24
wire [`F_NODE-1:0]          n18_faulty_out;
router #(18,WIDTHX,WIDTHY) n18(
    .clk(clk),
    .reset(reset),

    .my_xpos(0),
    .my_ypos(3),

    .idata_0(n12_odata_18),
    .ivalid_0(n12_ovalid_18),
    .ivch_0(n12_ovch_18),
    .oack_0(n18_oack_12),
    .ordy_0(),//X
    .olck_0(n18_olck_12),
    .iack_0(n12_oack_18),
    .ilck_0(n12_olck_18),
    .odata_0(n18_odata_12),
    .ovalid_0(n18_ovalid_12),
    .ovch_0(n18_ovch_12),

    .idata_1(n19_odata_18),
    .ivalid_1(n19_ovalid_18),
    .ivch_1(n19_ovch_18),
    .oack_1(n18_oack_19),
    .ordy_1(),//X
    .olck_1(n18_olck_19),
    .iack_1(n19_oack_18),
    .ilck_1(n19_olck_18),
    .odata_1(n18_odata_19),
    .ovalid_1(n18_ovalid_19),
    .ovch_1(n18_ovch_19),

    .idata_2(n24_odata_18),
    .ivalid_2(n24_ovalid_18),
    .ivch_2(n24_ovch_18),
    .oack_2(n18_oack_24),
    .ordy_2(),//X
    .olck_2(n18_olck_24),
    .iack_2(n24_oack_18),
    .ilck_2(n24_olck_18),
    .odata_2(n18_odata_24),
    .ovalid_2(n18_ovalid_24),
    .ovch_2(n18_ovch_24),

    .idata_3(`DATA_WIDTH'b0),
    .ivalid_3(1'b0),
    .ivch_3(`VCH_WIDTH_NUM'b0),
    .oack_3(),
    .ordy_3(),//X
    .olck_3(),
    .iack_3(`VCH_WIDTH'b0),
    .ilck_3(`VCH_WIDTH'b0),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n18_idata_p0),
    .ivalid_4(n18_ivalid_p0),
    .ivch_4(n18_ivch_p0),
    .oack_4(),//X
    .ordy_4(n18_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n18_odata_p0),
    .ovalid_4(n18_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n12_test_ack_s_18),
    .test_ack_e_in(n19_test_ack_w_18),
    .test_ack_s_in(n24_test_ack_n_18),
    .test_ack_w_in(),
    .n_faulty(n12_faulty_out),
    .e_faulty(n19_faulty_out),
    .s_faulty(n24_faulty_out),
    .w_faulty(),
    .faulty_to_out(n18_faulty_out),//給四面八方
    .test_ack_n(n18_test_ack_n_12),
    .test_ack_e(n18_test_ack_e_19),
    .test_ack_s(n18_test_ack_s_24),
    .test_ack_w(),
    .test_set_to_input(n18_test_set)
);

//n19 --> n13 port 0
wire [`DATA_WIDTH-1:0]      n19_odata_13;
wire                        n19_ovalid_13;
wire [`VCH_WIDTH_NUM-1:0]   n19_ovch_13;
wire [`VCH_WIDTH-1:0]       n19_olck_13;
wire [`VCH_WIDTH-1:0]       n19_oack_13;
wire                        n19_test_ack_n_13;
//n19 --> n20 port 1
wire [`DATA_WIDTH-1:0]      n19_odata_20;
wire                        n19_ovalid_20;
wire [`VCH_WIDTH_NUM-1:0]   n19_ovch_20;
wire [`VCH_WIDTH-1:0]       n19_olck_20;
wire [`VCH_WIDTH-1:0]       n19_oack_20;
wire                        n19_test_ack_e_20;
//n19 --> n25 port 2
wire [`DATA_WIDTH-1:0]      n19_odata_25;
wire                        n19_ovalid_25;
wire [`VCH_WIDTH_NUM-1:0]   n19_ovch_25;
wire [`VCH_WIDTH-1:0]       n19_olck_25;
wire [`VCH_WIDTH-1:0]       n19_oack_25;
wire                        n19_test_ack_s_25;
//n19 --> n18 port 3
wire [`DATA_WIDTH-1:0]      n19_odata_18;
wire                        n19_ovalid_18;
wire [`VCH_WIDTH_NUM-1:0]   n19_ovch_18;
wire [`VCH_WIDTH-1:0]       n19_olck_18;
wire [`VCH_WIDTH-1:0]       n19_oack_18;
wire                        n19_test_ack_w_18;
//19 - 13 20 25 18
wire [`F_NODE-1:0]          n19_faulty_out;
// router #(19) n19(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(1),
//     .my_ypos(3),

//     .idata_0(n13_odata_19),
//     .ivalid_0(n13_ovalid_19),
//     .ivch_0(n13_ovch_19),
//     .oack_0(n19_oack_13),
//     .ordy_0(),//X
//     .olck_0(n19_olck_13),
//     .iack_0(n13_oack_19),
//     .ilck_0(n13_olck_19),
//     // .odata_0(n19_odata_13),
//     // .ovalid_0(n19_ovalid_13),
//     // .ovch_0(n19_ovch_13),
//     .odata_0(),
//     .ovalid_0(),
//     .ovch_0(),

//     .idata_1(n20_odata_19),
//     .ivalid_1(n20_ovalid_19),
//     .ivch_1(n20_ovch_19),
//     .oack_1(n19_oack_20),
//     .ordy_1(),//X
//     .olck_1(n19_olck_20),
//     .iack_1(n20_oack_19),
//     .ilck_1(n20_olck_19),
//     // .odata_1(n19_odata_20),
//     // .ovalid_1(n19_ovalid_20),
//     // .ovch_1(n19_ovch_20),
//     .odata_1(),
//     .ovalid_1(),
//     .ovch_1(),

//     .idata_2(n25_odata_19),
//     .ivalid_2(n25_ovalid_19),
//     .ivch_2(n25_ovch_19),
//     .oack_2(n19_oack_25),
//     .ordy_2(),//X
//     .olck_2(n19_olck_25),
//     .iack_2(n25_oack_19),
//     .ilck_2(n25_olck_19),
//     // .odata_2(n19_odata_25),
//     // .ovalid_2(n19_ovalid_25),
//     // .ovch_2(n19_ovch_25),
//     .odata_2(),
//     .ovalid_2(),
//     .ovch_2(),

//     .idata_3(n18_odata_19),
//     .ivalid_3(n18_ovalid_19),
//     .ivch_3(n18_ovch_19),
//     .oack_3(n19_oack_18),
//     .ordy_3(),//X
//     .olck_3(n19_olck_18),
//     .iack_3(n18_oack_19),
//     .ilck_3(n18_olck_19),
//     // .odata_3(n19_odata_18),
//     // .ovalid_3(n19_ovalid_18),
//     // .ovch_3(n19_ovch_18),
//     .odata_3(),
//     .ovalid_3(),
//     .ovch_3(),

//     .idata_4(n19_idata_p0),
//     .ivalid_4(n19_ivalid_p0),
//     .ivch_4(n19_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n19_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n19_odata_p0),
//     .ovalid_4(n19_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n13_test_ack_s_19),
//     .test_ack_e_in(n20_test_ack_w_19),
//     .test_ack_s_in(n25_test_ack_n_19),
//     .test_ack_w_in(n18_test_ack_e_19),
//     .n_faulty(n13_faulty_out),
//     .e_faulty(n20_faulty_out),
//     .s_faulty(n25_faulty_out),
//     .w_faulty(n18_faulty_out),
//     .faulty_to_out(n19_faulty_out),//給四面八方
//     .test_ack_n(n19_test_ack_n_13),
//     .test_ack_e(n19_test_ack_e_20),
//     .test_ack_s(n19_test_ack_s_25),
//     .test_ack_w(n19_test_ack_w_18),
//     .test_set_to_input(n19_test_set)
// );

router #(19,WIDTHX,WIDTHY) n19(
    .clk(clk),
    .reset(reset),

    .my_xpos(1),
    .my_ypos(3),

    .idata_0(n13_odata_19),
    .ivalid_0(n13_ovalid_19),
    .ivch_0(n13_ovch_19),
    .oack_0(n19_oack_13),
    .ordy_0(),//X
    .olck_0(n19_olck_13),
    .iack_0(n13_oack_19),
    .ilck_0(n13_olck_19),
    .odata_0(n19_odata_13),
    .ovalid_0(n19_ovalid_13),
    .ovch_0(n19_ovch_13),

    .idata_1(n20_odata_19),
    .ivalid_1(n20_ovalid_19),
    .ivch_1(n20_ovch_19),
    .oack_1(n19_oack_20),
    .ordy_1(),//X
    .olck_1(n19_olck_20),
    .iack_1(n20_oack_19),
    .ilck_1(n20_olck_19),
    .odata_1(n19_odata_20),
    .ovalid_1(n19_ovalid_20),
    .ovch_1(n19_ovch_20),

    .idata_2(n25_odata_19),
    .ivalid_2(n25_ovalid_19),
    .ivch_2(n25_ovch_19),
    .oack_2(n19_oack_25),
    .ordy_2(),//X
    .olck_2(n19_olck_25),
    .iack_2(n25_oack_19),
    .ilck_2(n25_olck_19),
    .odata_2(n19_odata_25),
    .ovalid_2(n19_ovalid_25),
    .ovch_2(n19_ovch_25),

    .idata_3(n18_odata_19),
    .ivalid_3(n18_ovalid_19),
    .ivch_3(n18_ovch_19),
    .oack_3(n19_oack_18),
    .ordy_3(),//X
    .olck_3(n19_olck_18),
    .iack_3(n18_oack_19),
    .ilck_3(n18_olck_19),
    .odata_3(n19_odata_18),
    .ovalid_3(n19_ovalid_18),
    .ovch_3(n19_ovch_18),

    .idata_4(n19_idata_p0),
    .ivalid_4(n19_ivalid_p0),
    .ivch_4(n19_ivch_p0),
    .oack_4(),//X
    .ordy_4(n19_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n19_odata_p0),
    .ovalid_4(n19_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n13_test_ack_s_19),
    .test_ack_e_in(n20_test_ack_w_19),
    .test_ack_s_in(n25_test_ack_n_19),
    .test_ack_w_in(n18_test_ack_e_19),
    .n_faulty(n13_faulty_out),
    .e_faulty(n20_faulty_out),
    .s_faulty(n25_faulty_out),
    .w_faulty(n18_faulty_out),
    .faulty_to_out(n19_faulty_out),//給四面八方
    .test_ack_n(n19_test_ack_n_13),
    .test_ack_e(n19_test_ack_e_20),
    .test_ack_s(n19_test_ack_s_25),
    .test_ack_w(n19_test_ack_w_18),
    .test_set_to_input(n19_test_set)
);

//n20 --> n14 port 0
wire [`DATA_WIDTH-1:0]      n20_odata_14;
wire                        n20_ovalid_14;
wire [`VCH_WIDTH_NUM-1:0]   n20_ovch_14;
wire [`VCH_WIDTH-1:0]       n20_olck_14;
wire [`VCH_WIDTH-1:0]       n20_oack_14;
wire                        n20_test_ack_n_14;
//n20 --> n21 port 1
wire [`DATA_WIDTH-1:0]      n20_odata_21;
wire                        n20_ovalid_21;
wire [`VCH_WIDTH_NUM-1:0]   n20_ovch_21;
wire [`VCH_WIDTH-1:0]       n20_olck_21;
wire [`VCH_WIDTH-1:0]       n20_oack_21;
wire                        n20_test_ack_e_21;
//n20 --> n26 port 2
wire [`DATA_WIDTH-1:0]      n20_odata_26;
wire                        n20_ovalid_26;
wire [`VCH_WIDTH_NUM-1:0]   n20_ovch_26;
wire [`VCH_WIDTH-1:0]       n20_olck_26;
wire [`VCH_WIDTH-1:0]       n20_oack_26;
wire                        n20_test_ack_s_26;
//n20 --> n19 port 3
wire [`DATA_WIDTH-1:0]      n20_odata_19;
wire                        n20_ovalid_19;
wire [`VCH_WIDTH_NUM-1:0]   n20_ovch_19;
wire [`VCH_WIDTH-1:0]       n20_olck_19;
wire [`VCH_WIDTH-1:0]       n20_oack_19;
wire                        n20_test_ack_w_19;
//n20 - 14 21 26 19
wire [`F_NODE-1:0]          n20_faulty_out;
router #(20,WIDTHX,WIDTHY) n20(
    .clk(clk),
    .reset(reset),

    .my_xpos(2),
    .my_ypos(3),

    .idata_0(n14_odata_20),
    .ivalid_0(n14_ovalid_20),
    .ivch_0(n14_ovch_20),
    .oack_0(n20_oack_14),
    .ordy_0(),//X
    .olck_0(n20_olck_14),
    .iack_0(n14_oack_20),
    .ilck_0(n14_olck_20),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n21_odata_20),
    .ivalid_1(n21_ovalid_20),
    .ivch_1(n21_ovch_20),
    .oack_1(n20_oack_21),
    .ordy_1(),//X
    .olck_1(n20_olck_21),
    .iack_1(n21_oack_20),
    .ilck_1(n21_olck_20),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n26_odata_20),
    .ivalid_2(n26_ovalid_20),
    .ivch_2(n26_ovch_20),
    .oack_2(n20_oack_26),
    .ordy_2(),//X
    .olck_2(n20_olck_26),
    .iack_2(n26_oack_20),
    .ilck_2(n26_olck_20),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n19_odata_20),
    .ivalid_3(n19_ovalid_20),
    .ivch_3(n19_ovch_20),
    .oack_3(n20_oack_19),
    .ordy_3(),//X
    .olck_3(n20_olck_19),
    .iack_3(n19_oack_20),
    .ilck_3(n19_olck_20),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n20_idata_p0),
    .ivalid_4(n20_ivalid_p0),
    .ivch_4(n20_ivch_p0),
    .oack_4(),//X
    .ordy_4(n20_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n20_odata_p0),
    .ovalid_4(n20_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n14_test_ack_s_20),
    .test_ack_e_in(n21_test_ack_w_20),
    .test_ack_s_in(n26_test_ack_n_20),
    .test_ack_w_in(n19_test_ack_e_20),
    .n_faulty(n14_faulty_out),
    .e_faulty(n21_faulty_out),
    .s_faulty(n26_faulty_out),
    .w_faulty(n19_faulty_out),
    .faulty_to_out(n20_faulty_out),//給四面八方
    .test_ack_n(n20_test_ack_n_14),
    .test_ack_e(n20_test_ack_e_21),
    .test_ack_s(n20_test_ack_s_26),
    .test_ack_w(n20_test_ack_w_19),
    .test_set_to_input(n20_test_set)
);
// router #(20) n20(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(2),
//     .my_ypos(3),

//     .idata_0(n14_odata_20),
//     .ivalid_0(n14_ovalid_20),
//     .ivch_0(n14_ovch_20),
//     .oack_0(n20_oack_14),
//     .ordy_0(),//X
//     .olck_0(n20_olck_14),
//     .iack_0(n14_oack_20),
//     .ilck_0(n14_olck_20),
//     .odata_0(n20_odata_14),
//     .ovalid_0(n20_ovalid_14),
//     .ovch_0(n20_ovch_14),

//     .idata_1(n21_odata_20),
//     .ivalid_1(n21_ovalid_20),
//     .ivch_1(n21_ovch_20),
//     .oack_1(n20_oack_21),
//     .ordy_1(),//X
//     .olck_1(n20_olck_21),
//     .iack_1(n21_oack_20),
//     .ilck_1(n21_olck_20),
//     .odata_1(n20_odata_21),
//     .ovalid_1(n20_ovalid_21),
//     .ovch_1(n20_ovch_21),

//     .idata_2(n26_odata_20),
//     .ivalid_2(n26_ovalid_20),
//     .ivch_2(n26_ovch_20),
//     .oack_2(n20_oack_26),
//     .ordy_2(),//X
//     .olck_2(n20_olck_26),
//     .iack_2(n26_oack_20),
//     .ilck_2(n26_olck_20),
//     .odata_2(n20_odata_26),
//     .ovalid_2(n20_ovalid_26),
//     .ovch_2(n20_ovch_26),

//     .idata_3(n19_odata_20),
//     .ivalid_3(n19_ovalid_20),
//     .ivch_3(n19_ovch_20),
//     .oack_3(n20_oack_19),
//     .ordy_3(),//X
//     .olck_3(n20_olck_19),
//     .iack_3(n19_oack_20),
//     .ilck_3(n19_olck_20),
//     .odata_3(n20_odata_19),
//     .ovalid_3(n20_ovalid_19),
//     .ovch_3(n20_ovch_19),

//     .idata_4(n20_idata_p0),
//     .ivalid_4(n20_ivalid_p0),
//     .ivch_4(n20_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n20_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n20_odata_p0),
//     .ovalid_4(n20_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n14_test_ack_s_20),
//     .test_ack_e_in(n21_test_ack_w_20),
//     .test_ack_s_in(n26_test_ack_n_20),
//     .test_ack_w_in(n19_test_ack_e_20),
//     .n_faulty(n14_faulty_out),
//     .e_faulty(n21_faulty_out),
//     .s_faulty(n26_faulty_out),
//     .w_faulty(n19_faulty_out),
//     .faulty_to_out(n20_faulty_out),//給四面八方
//     .test_ack_n(n20_test_ack_n_14),
//     .test_ack_e(n20_test_ack_e_21),
//     .test_ack_s(n20_test_ack_s_26),
//     .test_ack_w(n20_test_ack_w_19),
//     .test_set_to_input(n20_test_set)
// );

//n21 --> n15 port 0
wire [`DATA_WIDTH-1:0]      n21_odata_15;
wire                        n21_ovalid_15;
wire [`VCH_WIDTH_NUM-1:0]   n21_ovch_15;
wire [`VCH_WIDTH-1:0]       n21_olck_15;
wire [`VCH_WIDTH-1:0]       n21_oack_15;
wire                        n21_test_ack_n_15;
//n21 --> n22 port 1
wire [`DATA_WIDTH-1:0]      n21_odata_22;
wire                        n21_ovalid_22;
wire [`VCH_WIDTH_NUM-1:0]   n21_ovch_22;
wire [`VCH_WIDTH-1:0]       n21_olck_22;
wire [`VCH_WIDTH-1:0]       n21_oack_22;
wire                        n21_test_ack_e_22;
//n21 --> n27 port 2
wire [`DATA_WIDTH-1:0]      n21_odata_27;
wire                        n21_ovalid_27;
wire [`VCH_WIDTH_NUM-1:0]   n21_ovch_27;
wire [`VCH_WIDTH-1:0]       n21_olck_27;
wire [`VCH_WIDTH-1:0]       n21_oack_27;
wire                        n21_test_ack_s_27;
//n21 --> n20 port 3
wire [`DATA_WIDTH-1:0]      n21_odata_20;
wire                        n21_ovalid_20;
wire [`VCH_WIDTH_NUM-1:0]   n21_ovch_20;
wire [`VCH_WIDTH-1:0]       n21_olck_20;
wire [`VCH_WIDTH-1:0]       n21_oack_20;
wire                        n21_test_ack_w_20;
//21 - 15 22 27 20
wire [`F_NODE-1:0]          n21_faulty_out;
router #(21,WIDTHX,WIDTHY) n21(
    .clk(clk),
    .reset(reset),

    .my_xpos(3),
    .my_ypos(3),

    .idata_0(n15_odata_21),
    .ivalid_0(n15_ovalid_21),
    .ivch_0(n15_ovch_21),
    .oack_0(n21_oack_15),
    .ordy_0(),//X
    .olck_0(n21_olck_15),
    .iack_0(n15_oack_21),
    .ilck_0(n15_olck_21),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n22_odata_21),
    .ivalid_1(n22_ovalid_21),
    .ivch_1(n22_ovch_21),
    .oack_1(n21_oack_22),
    .ordy_1(),//X
    .olck_1(n21_olck_22),
    .iack_1(n22_oack_21),
    .ilck_1(n22_olck_21),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n27_odata_21),
    .ivalid_2(n27_ovalid_21),
    .ivch_2(n27_ovch_21),
    .oack_2(n21_oack_27),
    .ordy_2(),//X
    .olck_2(n21_olck_27),
    .iack_2(n27_oack_21),
    .ilck_2(n27_olck_21),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n20_odata_21),
    .ivalid_3(n20_ovalid_21),
    .ivch_3(n20_ovch_21),
    .oack_3(n21_oack_20),
    .ordy_3(),//X
    .olck_3(n21_olck_20),
    .iack_3(n20_oack_21),
    .ilck_3(n20_olck_21),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n21_idata_p0),
    .ivalid_4(n21_ivalid_p0),
    .ivch_4(n21_ivch_p0),
    .oack_4(),//X
    .ordy_4(n21_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n21_odata_p0),
    .ovalid_4(n21_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n15_test_ack_s_21),
    .test_ack_e_in(n22_test_ack_w_21),
    .test_ack_s_in(n27_test_ack_n_21),
    .test_ack_w_in(n20_test_ack_e_21),
    .n_faulty(n15_faulty_out),
    .e_faulty(n22_faulty_out),
    .s_faulty(n27_faulty_out),
    .w_faulty(n20_faulty_out),
    .faulty_to_out(n21_faulty_out),//給四面八方
    .test_ack_n(n21_test_ack_n_15),
    .test_ack_e(n21_test_ack_e_22),
    .test_ack_s(n21_test_ack_s_27),
    .test_ack_w(n21_test_ack_w_20),
    .test_set_to_input(n21_test_set)
);

// router #(21) n21(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(3),
//     .my_ypos(3),

//     .idata_0(n15_odata_21),
//     .ivalid_0(n15_ovalid_21),
//     .ivch_0(n15_ovch_21),
//     .oack_0(n21_oack_15),
//     .ordy_0(),//X
//     .olck_0(n21_olck_15),
//     .iack_0(n15_oack_21),
//     .ilck_0(n15_olck_21),
//     .odata_0(n21_odata_15),
//     .ovalid_0(n21_ovalid_15),
//     .ovch_0(n21_ovch_15),

//     .idata_1(n22_odata_21),
//     .ivalid_1(n22_ovalid_21),
//     .ivch_1(n22_ovch_21),
//     .oack_1(n21_oack_22),
//     .ordy_1(),//X
//     .olck_1(n21_olck_22),
//     .iack_1(n22_oack_21),
//     .ilck_1(n22_olck_21),
//     .odata_1(n21_odata_22),
//     .ovalid_1(n21_ovalid_22),
//     .ovch_1(n21_ovch_22),

//     .idata_2(n27_odata_21),
//     .ivalid_2(n27_ovalid_21),
//     .ivch_2(n27_ovch_21),
//     .oack_2(n21_oack_27),
//     .ordy_2(),//X
//     .olck_2(n21_olck_27),
//     .iack_2(n27_oack_21),
//     .ilck_2(n27_olck_21),
//     .odata_2(n21_odata_27),
//     .ovalid_2(n21_ovalid_27),
//     .ovch_2(n21_ovch_27),

//     .idata_3(n20_odata_21),
//     .ivalid_3(n20_ovalid_21),
//     .ivch_3(n20_ovch_21),
//     .oack_3(n21_oack_20),
//     .ordy_3(),//X
//     .olck_3(n21_olck_20),
//     .iack_3(n20_oack_21),
//     .ilck_3(n20_olck_21),
//     .odata_3(n21_odata_20),
//     .ovalid_3(n21_ovalid_20),
//     .ovch_3(n21_ovch_20),

//     .idata_4(n21_idata_p0),
//     .ivalid_4(n21_ivalid_p0),
//     .ivch_4(n21_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n21_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n21_odata_p0),
//     .ovalid_4(n21_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n15_test_ack_s_21),
//     .test_ack_e_in(n22_test_ack_w_21),
//     .test_ack_s_in(n27_test_ack_n_21),
//     .test_ack_w_in(n20_test_ack_e_21),
//     .n_faulty(n15_faulty_out),
//     .e_faulty(n22_faulty_out),
//     .s_faulty(n27_faulty_out),
//     .w_faulty(n20_faulty_out),
//     .faulty_to_out(n21_faulty_out),//給四面八方
//     .test_ack_n(n21_test_ack_n_15),
//     .test_ack_e(n21_test_ack_e_22),
//     .test_ack_s(n21_test_ack_s_27),
//     .test_ack_w(n21_test_ack_w_20),
//     .test_set_to_input(n21_test_set)
// );

//n22 --> n16 port 0
wire [`DATA_WIDTH-1:0]      n22_odata_16;
wire                        n22_ovalid_16;
wire [`VCH_WIDTH_NUM-1:0]   n22_ovch_16;
wire [`VCH_WIDTH-1:0]       n22_olck_16;
wire [`VCH_WIDTH-1:0]       n22_oack_16;
wire                        n22_test_ack_n_16;
//n22 --> n23 port 1
wire [`DATA_WIDTH-1:0]      n22_odata_23;
wire                        n22_ovalid_23;
wire [`VCH_WIDTH_NUM-1:0]   n22_ovch_23;
wire [`VCH_WIDTH-1:0]       n22_olck_23;
wire [`VCH_WIDTH-1:0]       n22_oack_23;
wire                        n22_test_ack_e_23;
//n22 --> n28 port 2
wire [`DATA_WIDTH-1:0]      n22_odata_28;
wire                        n22_ovalid_28;
wire [`VCH_WIDTH_NUM-1:0]   n22_ovch_28;
wire [`VCH_WIDTH-1:0]       n22_olck_28;
wire [`VCH_WIDTH-1:0]       n22_oack_28;
wire                        n22_test_ack_s_28;
//n22 --> 21 port 3
wire [`DATA_WIDTH-1:0]      n22_odata_21;
wire                        n22_ovalid_21;
wire [`VCH_WIDTH_NUM-1:0]   n22_ovch_21;
wire [`VCH_WIDTH-1:0]       n22_olck_21;
wire [`VCH_WIDTH-1:0]       n22_oack_21;
wire                        n22_test_ack_w_21;
//22 - 16 23 28 21
wire [`F_NODE-1:0]          n22_faulty_out;
router #(22,WIDTHX,WIDTHY) n22(
    .clk(clk),
    .reset(reset),

    .my_xpos(4),
    .my_ypos(3),

    .idata_0(n16_odata_22),
    .ivalid_0(n16_ovalid_22),
    .ivch_0(n16_ovch_22),
    .oack_0(n22_oack_16),
    .ordy_0(),//X
    .olck_0(n22_olck_16),
    .iack_0(n16_oack_22),
    .ilck_0(n16_olck_22),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n23_odata_22),
    .ivalid_1(n23_ovalid_22),
    .ivch_1(n23_ovch_22),
    .oack_1(n22_oack_23),
    .ordy_1(),//X
    .olck_1(n22_olck_23),
    .iack_1(n23_oack_22),
    .ilck_1(n23_olck_22),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n28_odata_22),
    .ivalid_2(n28_ovalid_22),
    .ivch_2(n28_ovch_22),
    .oack_2(n22_oack_28),
    .ordy_2(),//X
    .olck_2(n22_olck_28),
    .iack_2(n28_oack_22),
    .ilck_2(n28_olck_22),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n21_odata_22),
    .ivalid_3(n21_ovalid_22),
    .ivch_3(n21_ovch_22),
    .oack_3(n22_oack_21),
    .ordy_3(),//X
    .olck_3(n22_olck_21),
    .iack_3(n21_oack_22),
    .ilck_3(n21_olck_22),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n22_idata_p0),
    .ivalid_4(n22_ivalid_p0),
    .ivch_4(n22_ivch_p0),
    .oack_4(),//X
    .ordy_4(n22_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n22_odata_p0),
    .ovalid_4(n22_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n16_test_ack_s_22),
    .test_ack_e_in(n23_test_ack_w_22),
    .test_ack_s_in(n28_test_ack_n_22),
    .test_ack_w_in(n21_test_ack_e_22),
    .n_faulty(n16_faulty_out),
    .e_faulty(n23_faulty_out),
    .s_faulty(n28_faulty_out),
    .w_faulty(n21_faulty_out),
    .faulty_to_out(n22_faulty_out),//給四面八方
    .test_ack_n(n22_test_ack_n_16),
    .test_ack_e(n22_test_ack_e_23),
    .test_ack_s(n22_test_ack_s_28),
    .test_ack_w(n22_test_ack_w_21),
    .test_set_to_input(n22_test_set)
);

// router #(22) n22(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(4),
//     .my_ypos(3),

//     .idata_0(n16_odata_22),
//     .ivalid_0(n16_ovalid_22),
//     .ivch_0(n16_ovch_22),
//     .oack_0(n22_oack_16),
//     .ordy_0(),//X
//     .olck_0(n22_olck_16),
//     .iack_0(n16_oack_22),
//     .ilck_0(n16_olck_22),
//     .odata_0(n22_odata_16),
//     .ovalid_0(n22_ovalid_16),
//     .ovch_0(n22_ovch_16),

//     .idata_1(n23_odata_22),
//     .ivalid_1(n23_ovalid_22),
//     .ivch_1(n23_ovch_22),
//     .oack_1(n22_oack_23),
//     .ordy_1(),//X
//     .olck_1(n22_olck_23),
//     .iack_1(n23_oack_22),
//     .ilck_1(n23_olck_22),
//     .odata_1(n22_odata_23),
//     .ovalid_1(n22_ovalid_23),
//     .ovch_1(n22_ovch_23),

//     .idata_2(n28_odata_22),
//     .ivalid_2(n28_ovalid_22),
//     .ivch_2(n28_ovch_22),
//     .oack_2(n22_oack_28),
//     .ordy_2(),//X
//     .olck_2(n22_olck_28),
//     .iack_2(n28_oack_22),
//     .ilck_2(n28_olck_22),
//     .odata_2(n22_odata_28),
//     .ovalid_2(n22_ovalid_28),
//     .ovch_2(n22_ovch_28),

//     .idata_3(n21_odata_22),
//     .ivalid_3(n21_ovalid_22),
//     .ivch_3(n21_ovch_22),
//     .oack_3(n22_oack_21),
//     .ordy_3(),//X
//     .olck_3(n22_olck_21),
//     .iack_3(n21_oack_22),
//     .ilck_3(n21_olck_22),
//     .odata_3(n22_odata_21),
//     .ovalid_3(n22_ovalid_21),
//     .ovch_3(n22_ovch_21),

//     .idata_4(n22_idata_p0),
//     .ivalid_4(n22_ivalid_p0),
//     .ivch_4(n22_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n22_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n22_odata_p0),
//     .ovalid_4(n22_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n16_test_ack_s_22),
//     .test_ack_e_in(n23_test_ack_w_22),
//     .test_ack_s_in(n28_test_ack_n_22),
//     .test_ack_w_in(n21_test_ack_e_22),
//     .n_faulty(n16_faulty_out),
//     .e_faulty(n23_faulty_out),
//     .s_faulty(n28_faulty_out),
//     .w_faulty(n21_faulty_out),
//     .faulty_to_out(n22_faulty_out),//給四面八方
//     .test_ack_n(n22_test_ack_n_16),
//     .test_ack_e(n22_test_ack_e_23),
//     .test_ack_s(n22_test_ack_s_28),
//     .test_ack_w(n22_test_ack_w_21),
//     .test_set_to_input(n22_test_set)
// );

//n23 --> n17 port 0
wire [`DATA_WIDTH-1:0]      n23_odata_17;
wire                        n23_ovalid_17;
wire [`VCH_WIDTH_NUM-1:0]   n23_ovch_17;
wire [`VCH_WIDTH-1:0]       n23_olck_17;
wire [`VCH_WIDTH-1:0]       n23_oack_17;
wire                        n23_test_ack_n_17;
//n23 --> n29 port 2
wire [`DATA_WIDTH-1:0]      n23_odata_29;
wire                        n23_ovalid_29;
wire [`VCH_WIDTH_NUM-1:0]   n23_ovch_29;
wire [`VCH_WIDTH-1:0]       n23_olck_29;
wire [`VCH_WIDTH-1:0]       n23_oack_29;
wire                        n23_test_ack_s_29;
//n23 --> n22 port 3
wire [`DATA_WIDTH-1:0]      n23_odata_22;
wire                        n23_ovalid_22;
wire [`VCH_WIDTH_NUM-1:0]   n23_ovch_22;
wire [`VCH_WIDTH-1:0]       n23_olck_22;
wire [`VCH_WIDTH-1:0]       n23_oack_22;
wire                        n23_test_ack_w_22;
//23 - 17 29 22
wire [`F_NODE-1:0]          n23_faulty_out;
router #(23,WIDTHX,WIDTHY) n23(
    .clk(clk),
    .reset(reset),

    .my_xpos(5),
    .my_ypos(3),

    .idata_0(n17_odata_23),
    .ivalid_0(n17_ovalid_23),
    .ivch_0(n17_ovch_23),
    .oack_0(n23_oack_17),
    .ordy_0(),//X
    .olck_0(n23_olck_17),
    .iack_0(n17_oack_23),
    .ilck_0(n17_olck_23),
    .odata_0(n23_odata_17),
    .ovalid_0(n23_ovalid_17),
    .ovch_0(n23_ovch_17),

    .idata_1(`DATA_WIDTH'b0),
    .ivalid_1(1'b0),
    .ivch_1(`VCH_WIDTH_NUM'b0),
    .oack_1(),
    .ordy_1(),//X
    .olck_1(),
    .iack_1(`VCH_WIDTH'b0),
    .ilck_1(`VCH_WIDTH'b0),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n29_odata_23),
    .ivalid_2(n29_ovalid_23),
    .ivch_2(n29_ovch_23),
    .oack_2(n23_oack_29),
    .ordy_2(),//X
    .olck_2(n23_olck_29),
    .iack_2(n29_oack_23),
    .ilck_2(n29_olck_23),
    .odata_2(n23_odata_29),
    .ovalid_2(n23_ovalid_29),
    .ovch_2(n23_ovch_29),

    .idata_3(n22_odata_23),
    .ivalid_3(n22_ovalid_23),
    .ivch_3(n22_ovch_23),
    .oack_3(n23_oack_22),
    .ordy_3(),//X
    .olck_3(n23_olck_22),
    .iack_3(n22_oack_23),
    .ilck_3(n22_olck_23),
    .odata_3(n23_odata_22),
    .ovalid_3(n23_ovalid_22),
    .ovch_3(n23_ovch_22),

    .idata_4(n23_idata_p0),
    .ivalid_4(n23_ivalid_p0),
    .ivch_4(n23_ivch_p0),
    .oack_4(),//X
    .ordy_4(n23_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n23_odata_p0),
    .ovalid_4(n23_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n17_test_ack_s_23),
    .test_ack_e_in(),
    .test_ack_s_in(n29_test_ack_n_23),
    .test_ack_w_in(n22_test_ack_e_23),
    .n_faulty(n17_faulty_out),
    .e_faulty(),
    .s_faulty(n29_faulty_out),
    .w_faulty(n22_faulty_out),
    .faulty_to_out(n23_faulty_out),//給四面八方
    .test_ack_n(n23_test_ack_n_17),
    .test_ack_e(),
    .test_ack_s(n23_test_ack_s_29),
    .test_ack_w(n23_test_ack_w_22),
    .test_set_to_input(n23_test_set)
);

//n24 --> n18 port 0
wire [`DATA_WIDTH-1:0]      n24_odata_18;
wire                        n24_ovalid_18;
wire [`VCH_WIDTH_NUM-1:0]   n24_ovch_18;
wire [`VCH_WIDTH-1:0]       n24_olck_18;
wire [`VCH_WIDTH-1:0]       n24_oack_18;
wire                        n24_test_ack_n_18;
//n24 --> n25 port 1
wire [`DATA_WIDTH-1:0]      n24_odata_25;
wire                        n24_ovalid_25;
wire [`VCH_WIDTH_NUM-1:0]   n24_ovch_25;
wire [`VCH_WIDTH-1:0]       n24_olck_25;
wire [`VCH_WIDTH-1:0]       n24_oack_25;
wire                        n24_test_ack_e_25;
//n24 --> n30 port 2
wire [`DATA_WIDTH-1:0]      n24_odata_30;
wire                        n24_ovalid_30;
wire [`VCH_WIDTH_NUM-1:0]   n24_ovch_30;
wire [`VCH_WIDTH-1:0]       n24_olck_30;
wire [`VCH_WIDTH-1:0]       n24_oack_30;
wire                        n24_test_ack_s_30;
//24 - 18 25 30
wire [`F_NODE-1:0]          n24_faulty_out;
router #(24,WIDTHX,WIDTHY) n24(
    .clk(clk),
    .reset(reset),

    .my_xpos(0),
    .my_ypos(4),

    .idata_0(n18_odata_24),
    .ivalid_0(n18_ovalid_24),
    .ivch_0(n18_ovch_24),
    .oack_0(n24_oack_18),
    .ordy_0(),//X
    .olck_0(n24_olck_18),
    .iack_0(n18_oack_24),
    .ilck_0(n18_olck_24),
    .odata_0(n24_odata_18),
    .ovalid_0(n24_ovalid_18),
    .ovch_0(n24_ovch_18),

    .idata_1(n25_odata_24),
    .ivalid_1(n25_ovalid_24),
    .ivch_1(n25_ovch_24),
    .oack_1(n24_oack_25),
    .ordy_1(),//X
    .olck_1(n24_olck_25),
    .iack_1(n25_oack_24),
    .ilck_1(n25_olck_24),
    .odata_1(n24_odata_25),
    .ovalid_1(n24_ovalid_25),
    .ovch_1(n24_ovch_25),

    .idata_2(n30_odata_24),
    .ivalid_2(n30_ovalid_24),
    .ivch_2(n30_ovch_24),
    .oack_2(n24_oack_30),
    .ordy_2(),//X
    .olck_2(n24_olck_30),
    .iack_2(n30_oack_24),
    .ilck_2(n30_olck_24),
    .odata_2(n24_odata_30),
    .ovalid_2(n24_ovalid_30),
    .ovch_2(n24_ovch_30),

    .idata_3(`DATA_WIDTH'b0),
    .ivalid_3(1'b0),
    .ivch_3(`VCH_WIDTH_NUM'b0),
    .oack_3(),
    .ordy_3(),//X
    .olck_3(),
    .iack_3(`VCH_WIDTH'b0),
    .ilck_3(`VCH_WIDTH'b0),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n24_idata_p0),
    .ivalid_4(n24_ivalid_p0),
    .ivch_4(n24_ivch_p0),
    .oack_4(),//X
    .ordy_4(n24_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n24_odata_p0),
    .ovalid_4(n24_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n18_test_ack_s_24),
    .test_ack_e_in(n25_test_ack_w_24),
    .test_ack_s_in(n30_test_ack_n_24),
    .test_ack_w_in(),
    .n_faulty(n18_faulty_out),
    .e_faulty(n25_faulty_out),
    .s_faulty(n30_faulty_out),
    .w_faulty(),
    .faulty_to_out(n24_faulty_out),//給四面八方
    .test_ack_n(n24_test_ack_n_18),
    .test_ack_e(n24_test_ack_e_25),
    .test_ack_s(n24_test_ack_s_30),
    .test_ack_w(),
    .test_set_to_input(n24_test_set)
);


//n25 --> n19 port 0
wire [`DATA_WIDTH-1:0]      n25_odata_19;
wire                        n25_ovalid_19;
wire [`VCH_WIDTH_NUM-1:0]   n25_ovch_19;
wire [`VCH_WIDTH-1:0]       n25_olck_19;
wire [`VCH_WIDTH-1:0]       n25_oack_19;
wire                        n25_test_ack_n_19;
//n25 --> n26 port 1
wire [`DATA_WIDTH-1:0]      n25_odata_26;
wire                        n25_ovalid_26;
wire [`VCH_WIDTH_NUM-1:0]   n25_ovch_26;
wire [`VCH_WIDTH-1:0]       n25_olck_26;
wire [`VCH_WIDTH-1:0]       n25_oack_26;
wire                        n25_test_ack_e_26;
//n25 --> n31 port 2
wire [`DATA_WIDTH-1:0]      n25_odata_31;
wire                        n25_ovalid_31;
wire [`VCH_WIDTH_NUM-1:0]   n25_ovch_31;
wire [`VCH_WIDTH-1:0]       n25_olck_31;
wire [`VCH_WIDTH-1:0]       n25_oack_31;
wire                        n25_test_ack_s_31;
//n25 --> n24 port 3
wire [`DATA_WIDTH-1:0]      n25_odata_24;
wire                        n25_ovalid_24;
wire [`VCH_WIDTH_NUM-1:0]   n25_ovch_24;
wire [`VCH_WIDTH-1:0]       n25_olck_24;
wire [`VCH_WIDTH-1:0]       n25_oack_24;
wire                        n25_test_ack_w_24;
//25 - 19 26 31 24
wire [`F_NODE-1:0]          n25_faulty_out;
router #(25,WIDTHX,WIDTHY) n25(
    .clk(clk),
    .reset(reset),

    .my_xpos(1),
    .my_ypos(4),

    .idata_0(n19_odata_25),
    .ivalid_0(n19_ovalid_25),
    .ivch_0(n19_ovch_25),
    .oack_0(n25_oack_19),
    .ordy_0(),//X
    .olck_0(n25_olck_19),
    .iack_0(n19_oack_25),
    .ilck_0(n19_olck_25),
    .odata_0(n25_odata_19),
    .ovalid_0(n25_ovalid_19),
    .ovch_0(n25_ovch_19),

    .idata_1(n26_odata_25),
    .ivalid_1(n26_ovalid_25),
    .ivch_1(n26_ovch_25),
    .oack_1(n25_oack_26),
    .ordy_1(),//X
    .olck_1(n25_olck_26),
    .iack_1(n26_oack_25),
    .ilck_1(n26_olck_25),
    .odata_1(n25_odata_26),
    .ovalid_1(n25_ovalid_26),
    .ovch_1(n25_ovch_26),

    .idata_2(n31_odata_25),
    .ivalid_2(n31_ovalid_25),
    .ivch_2(n31_ovch_25),
    .oack_2(n25_oack_31),
    .ordy_2(),//X
    .olck_2(n25_olck_31),
    .iack_2(n31_oack_25),
    .ilck_2(n31_olck_25),
    .odata_2(n25_odata_31),
    .ovalid_2(n25_ovalid_31),
    .ovch_2(n25_ovch_31),

    .idata_3(n24_odata_25),
    .ivalid_3(n24_ovalid_25),
    .ivch_3(n24_ovch_25),
    .oack_3(n25_oack_24),
    .ordy_3(),//X
    .olck_3(n25_olck_24),
    .iack_3(n24_oack_25),
    .ilck_3(n24_olck_25),
    .odata_3(n25_odata_24),
    .ovalid_3(n25_ovalid_24),
    .ovch_3(n25_ovch_24),

    .idata_4(n25_idata_p0),
    .ivalid_4(n25_ivalid_p0),
    .ivch_4(n25_ivch_p0),
    .oack_4(),//X
    .ordy_4(n25_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n25_odata_p0),
    .ovalid_4(n25_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n19_test_ack_s_25),
    .test_ack_e_in(n26_test_ack_w_25),
    .test_ack_s_in(n31_test_ack_n_25),
    .test_ack_w_in(n24_test_ack_e_25),
    .n_faulty(n19_faulty_out),
    .e_faulty(n26_faulty_out),
    .s_faulty(n13_faulty_out),
    .w_faulty(n24_faulty_out),
    .faulty_to_out(n25_faulty_out),//給四面八方
    .test_ack_n(n25_test_ack_n_19),
    .test_ack_e(n25_test_ack_e_26),
    .test_ack_s(n25_test_ack_s_31),
    .test_ack_w(n25_test_ack_w_24),
    .test_set_to_input(n25_test_set)
);

//n26 --> n20 port 0
wire [`DATA_WIDTH-1:0]      n26_odata_20;
wire                        n26_ovalid_20;
wire [`VCH_WIDTH_NUM-1:0]   n26_ovch_20;
wire [`VCH_WIDTH-1:0]       n26_olck_20;
wire [`VCH_WIDTH-1:0]       n26_oack_20;
wire                        n26_test_ack_n_20;
//n26 --> n27 port 1
wire [`DATA_WIDTH-1:0]      n26_odata_27;
wire                        n26_ovalid_27;
wire [`VCH_WIDTH_NUM-1:0]   n26_ovch_27;
wire [`VCH_WIDTH-1:0]       n26_olck_27;
wire [`VCH_WIDTH-1:0]       n26_oack_27;
wire                        n26_test_ack_e_27;
//n26 --> n32 port 2
wire [`DATA_WIDTH-1:0]      n26_odata_32;
wire                        n26_ovalid_32;
wire [`VCH_WIDTH_NUM-1:0]   n26_ovch_32;
wire [`VCH_WIDTH-1:0]       n26_olck_32;
wire [`VCH_WIDTH-1:0]       n26_oack_32;
wire                        n26_test_ack_s_32;
//n26 --> n25 port 3
wire [`DATA_WIDTH-1:0]      n26_odata_25;
wire                        n26_ovalid_25;
wire [`VCH_WIDTH_NUM-1:0]   n26_ovch_25;
wire [`VCH_WIDTH-1:0]       n26_olck_25;
wire [`VCH_WIDTH-1:0]       n26_oack_25;
wire                        n26_test_ack_w_25;
//26-20 27 32 25
wire [`F_NODE-1:0]          n26_faulty_out;
router #(26,WIDTHX,WIDTHY) n26(
    .clk(clk),
    .reset(reset),

    .my_xpos(2),
    .my_ypos(4),

    .idata_0(n20_odata_26),
    .ivalid_0(n20_ovalid_26),
    .ivch_0(n20_ovch_26),
    .oack_0(n26_oack_20),
    .ordy_0(),//X
    .olck_0(n26_olck_20),
    .iack_0(n20_oack_26),
    .ilck_0(n20_olck_26),
    .odata_0(n26_odata_20),
    .ovalid_0(n26_ovalid_20),
    .ovch_0(n26_ovch_20),

    .idata_1(n27_odata_26),
    .ivalid_1(n27_ovalid_26),
    .ivch_1(n27_ovch_26),
    .oack_1(n26_oack_27),
    .ordy_1(),//X
    .olck_1(n26_olck_27),
    .iack_1(n27_oack_26),
    .ilck_1(n27_olck_26),
    .odata_1(n26_odata_27),
    .ovalid_1(n26_ovalid_27),
    .ovch_1(n26_ovch_27),

    .idata_2(n32_odata_26),
    .ivalid_2(n32_ovalid_26),
    .ivch_2(n32_ovch_26),
    .oack_2(n26_oack_32),
    .ordy_2(),//X
    .olck_2(n26_olck_32),
    .iack_2(n32_oack_26),
    .ilck_2(n32_olck_26),
    .odata_2(n26_odata_32),
    .ovalid_2(n26_ovalid_32),
    .ovch_2(n26_ovch_32),

    .idata_3(n25_odata_26),
    .ivalid_3(n25_ovalid_26),
    .ivch_3(n25_ovch_26),
    .oack_3(n26_oack_25),
    .ordy_3(),//X
    .olck_3(n26_olck_25),
    .iack_3(n25_oack_26),
    .ilck_3(n25_olck_26),
    .odata_3(n26_odata_25),
    .ovalid_3(n26_ovalid_25),
    .ovch_3(n26_ovch_25),

    .idata_4(n26_idata_p0),
    .ivalid_4(n26_ivalid_p0),
    .ivch_4(n26_ivch_p0),
    .oack_4(),//X
    .ordy_4(n26_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n26_odata_p0),
    .ovalid_4(n26_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n20_test_ack_s_26),
    .test_ack_e_in(n27_test_ack_w_26),
    .test_ack_s_in(n32_test_ack_n_26),
    .test_ack_w_in(n25_test_ack_e_26),
    .n_faulty(n20_faulty_out),
    .e_faulty(n27_faulty_out),
    .s_faulty(n32_faulty_out),
    .w_faulty(n25_faulty_out),
    .faulty_to_out(n26_faulty_out),//給四面八方
    .test_ack_n(n26_test_ack_n_20),
    .test_ack_e(n26_test_ack_e_27),
    .test_ack_s(n26_test_ack_s_32),
    .test_ack_w(n26_test_ack_w_25),
    .test_set_to_input(n26_test_set)
);

//n27 --> n21 port 0
wire [`DATA_WIDTH-1:0]      n27_odata_21;
wire                        n27_ovalid_21;
wire [`VCH_WIDTH_NUM-1:0]   n27_ovch_21;
wire [`VCH_WIDTH-1:0]       n27_olck_21;
wire [`VCH_WIDTH-1:0]       n27_oack_21;
wire                        n27_test_ack_n_21;
//n27 --> n28 port 1
wire [`DATA_WIDTH-1:0]      n27_odata_28;
wire                        n27_ovalid_28;
wire [`VCH_WIDTH_NUM-1:0]   n27_ovch_28;
wire [`VCH_WIDTH-1:0]       n27_olck_28;
wire [`VCH_WIDTH-1:0]       n27_oack_28;
wire                        n27_test_ack_e_28;
//n27 --> n33 port 2
wire [`DATA_WIDTH-1:0]      n27_odata_33;
wire                        n27_ovalid_33;
wire [`VCH_WIDTH_NUM-1:0]   n27_ovch_33;
wire [`VCH_WIDTH-1:0]       n27_olck_33;
wire [`VCH_WIDTH-1:0]       n27_oack_33;
wire                        n27_test_ack_s_33;
//n27 --> n26 port 3
wire [`DATA_WIDTH-1:0]      n27_odata_26;
wire                        n27_ovalid_26;
wire [`VCH_WIDTH_NUM-1:0]   n27_ovch_26;
wire [`VCH_WIDTH-1:0]       n27_olck_26;
wire [`VCH_WIDTH-1:0]       n27_oack_26;
wire                        n27_test_ack_w_26;
//27-21 28 33 26
wire [`F_NODE-1:0]          n27_faulty_out;
router #(27,WIDTHX,WIDTHY) n27(
    .clk(clk),
    .reset(reset),

    .my_xpos(3),
    .my_ypos(4),

    .idata_0(n21_odata_27),
    .ivalid_0(n21_ovalid_27),
    .ivch_0(n21_ovch_27),
    .oack_0(n27_oack_21),
    .ordy_0(),//X
    .olck_0(n27_olck_21),
    .iack_0(n21_oack_27),
    .ilck_0(n21_olck_27),
    .odata_0(),
    .ovalid_0(),
    .ovch_0(),

    .idata_1(n28_odata_27),
    .ivalid_1(n28_ovalid_27),
    .ivch_1(n28_ovch_27),
    .oack_1(n27_oack_28),
    .ordy_1(),//X
    .olck_1(n27_olck_28),
    .iack_1(n28_oack_27),
    .ilck_1(n28_olck_27),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n33_odata_27),
    .ivalid_2(n33_ovalid_27),
    .ivch_2(n33_ovch_27),
    .oack_2(n27_oack_33),
    .ordy_2(),//X
    .olck_2(n27_olck_33),
    .iack_2(n33_oack_27),
    .ilck_2(n33_olck_27),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n26_odata_27),
    .ivalid_3(n26_ovalid_27),
    .ivch_3(n26_ovch_27),
    .oack_3(n27_oack_26),
    .ordy_3(),//X
    .olck_3(n27_olck_26),
    .iack_3(n26_oack_27),
    .ilck_3(n26_olck_27),
    .odata_3(),
    .ovalid_3(),
    .ovch_3(),

    .idata_4(n27_idata_p0),
    .ivalid_4(n27_ivalid_p0),
    .ivch_4(n27_ivch_p0),
    .oack_4(),//X
    .ordy_4(n27_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n27_odata_p0),
    .ovalid_4(n27_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n21_test_ack_s_27),
    .test_ack_e_in(n28_test_ack_w_27),
    .test_ack_s_in(n33_test_ack_n_27),
    .test_ack_w_in(n26_test_ack_e_27),
    .n_faulty(n21_faulty_out),
    .e_faulty(n28_faulty_out),
    .s_faulty(n33_faulty_out),
    .w_faulty(n26_faulty_out),
    .faulty_to_out(n27_faulty_out),//給四面八方
    .test_ack_n(n27_test_ack_n_21),
    .test_ack_e(n27_test_ack_e_28),
    .test_ack_s(n27_test_ack_s_33),
    .test_ack_w(n27_test_ack_w_26),
    .test_set_to_input(n27_test_set)
);

// router #(27) n27(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(3),
//     .my_ypos(4),

//     .idata_0(n21_odata_27),
//     .ivalid_0(n21_ovalid_27),
//     .ivch_0(n21_ovch_27),
//     .oack_0(n27_oack_21),
//     .ordy_0(),//X
//     .olck_0(n27_olck_21),
//     .iack_0(n21_oack_27),
//     .ilck_0(n21_olck_27),
//     .odata_0(n27_odata_21),
//     .ovalid_0(n27_ovalid_21),
//     .ovch_0(n27_ovch_21),

//     .idata_1(n28_odata_27),
//     .ivalid_1(n28_ovalid_27),
//     .ivch_1(n28_ovch_27),
//     .oack_1(n27_oack_28),
//     .ordy_1(),//X
//     .olck_1(n27_olck_28),
//     .iack_1(n28_oack_27),
//     .ilck_1(n28_olck_27),
//     .odata_1(n27_odata_28),
//     .ovalid_1(n27_ovalid_28),
//     .ovch_1(n27_ovch_28),

//     .idata_2(n33_odata_27),
//     .ivalid_2(n33_ovalid_27),
//     .ivch_2(n33_ovch_27),
//     .oack_2(n27_oack_33),
//     .ordy_2(),//X
//     .olck_2(n27_olck_33),
//     .iack_2(n33_oack_27),
//     .ilck_2(n33_olck_27),
//     .odata_2(n27_odata_33),
//     .ovalid_2(n27_ovalid_33),
//     .ovch_2(n27_ovch_33),

//     .idata_3(n26_odata_27),
//     .ivalid_3(n26_ovalid_27),
//     .ivch_3(n26_ovch_27),
//     .oack_3(n27_oack_26),
//     .ordy_3(),//X
//     .olck_3(n27_olck_26),
//     .iack_3(n26_oack_27),
//     .ilck_3(n26_olck_27),
//     .odata_3(n27_odata_26),
//     .ovalid_3(n27_ovalid_26),
//     .ovch_3(n27_ovch_26),

//     .idata_4(n27_idata_p0),
//     .ivalid_4(n27_ivalid_p0),
//     .ivch_4(n27_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(n27_ordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n27_odata_p0),
//     .ovalid_4(n27_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n21_test_ack_s_27),
//     .test_ack_e_in(n28_test_ack_w_27),
//     .test_ack_s_in(n33_test_ack_n_27),
//     .test_ack_w_in(n26_test_ack_e_27),
//     .n_faulty(n21_faulty_out),
//     .e_faulty(n28_faulty_out),
//     .s_faulty(n33_faulty_out),
//     .w_faulty(n26_faulty_out),
//     .faulty_to_out(n27_faulty_out),//給四面八方
//     .test_ack_n(n27_test_ack_n_21),
//     .test_ack_e(n27_test_ack_e_28),
//     .test_ack_s(n27_test_ack_s_33),
//     .test_ack_w(n27_test_ack_w_26),
//     .test_set_to_input(n27_test_set)
// );

//n28 --> n22 port 0
wire [`DATA_WIDTH-1:0]      n28_odata_22;
wire                        n28_ovalid_22;
wire [`VCH_WIDTH_NUM-1:0]   n28_ovch_22;
wire [`VCH_WIDTH-1:0]       n28_olck_22;
wire [`VCH_WIDTH-1:0]       n28_oack_22;
wire                        n28_test_ack_n_22;
//n28 --> n29 port 1
wire [`DATA_WIDTH-1:0]      n28_odata_29;
wire                        n28_ovalid_29;
wire [`VCH_WIDTH_NUM-1:0]   n28_ovch_29;
wire [`VCH_WIDTH-1:0]       n28_olck_29;
wire [`VCH_WIDTH-1:0]       n28_oack_29;
wire                        n28_test_ack_e_29;
//n28 --> n34 port 2
wire [`DATA_WIDTH-1:0]      n28_odata_34;
wire                        n28_ovalid_34;
wire [`VCH_WIDTH_NUM-1:0]   n28_ovch_34;
wire [`VCH_WIDTH-1:0]       n28_olck_34;
wire [`VCH_WIDTH-1:0]       n28_oack_34;
wire                        n28_test_ack_s_34;
//n28 --> n27 port 3
wire [`DATA_WIDTH-1:0]      n28_odata_27;
wire                        n28_ovalid_27;
wire [`VCH_WIDTH_NUM-1:0]   n28_ovch_27;
wire [`VCH_WIDTH-1:0]       n28_olck_27;
wire [`VCH_WIDTH-1:0]       n28_oack_27;
wire                        n28_test_ack_w_27;
//28 - 22 29 34 27
wire [`F_NODE-1:0]          n28_faulty_out;
router #(28,WIDTHX,WIDTHY) n28(
    .clk(clk),
    .reset(reset),

    .my_xpos(4),
    .my_ypos(4),

    .idata_0(n22_odata_28),
    .ivalid_0(n22_ovalid_28),
    .ivch_0(n22_ovch_28),
    .oack_0(n28_oack_22),
    .ordy_0(),//X
    .olck_0(n28_olck_22),
    .iack_0(n22_oack_28),
    .ilck_0(n22_olck_28),
    .odata_0(n28_odata_22),
    .ovalid_0(n28_ovalid_22),
    .ovch_0(n28_ovch_22),

    .idata_1(n29_odata_28),
    .ivalid_1(n29_ovalid_28),
    .ivch_1(n29_ovch_28),
    .oack_1(n28_oack_29),
    .ordy_1(),//X
    .olck_1(n28_olck_29),
    .iack_1(n29_oack_28),
    .ilck_1(n29_olck_28),
    .odata_1(n28_odata_29),
    .ovalid_1(n28_ovalid_29),
    .ovch_1(n28_ovch_29),

    .idata_2(n34_odata_28),
    .ivalid_2(n34_ovalid_28),
    .ivch_2(n34_ovch_28),
    .oack_2(n28_oack_34),
    .ordy_2(),//X
    .olck_2(n28_olck_34),
    .iack_2(n34_oack_28),
    .ilck_2(n34_olck_28),
    .odata_2(n28_odata_34),
    .ovalid_2(n28_ovalid_34),
    .ovch_2(n28_ovch_34),

    .idata_3(n27_odata_28),
    .ivalid_3(n27_ovalid_28),
    .ivch_3(n27_ovch_28),
    .oack_3(n28_oack_27),
    .ordy_3(),//X
    .olck_3(n28_olck_27),
    .iack_3(n27_oack_28),
    .ilck_3(n27_olck_28),
    .odata_3(n28_odata_27),
    .ovalid_3(n28_ovalid_27),
    .ovch_3(n28_ovch_27),

    .idata_4(n28_idata_p0),
    .ivalid_4(n28_ivalid_p0),
    .ivch_4(n28_ivch_p0),
    .oack_4(),//X
    .ordy_4(n28_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n28_odata_p0),
    .ovalid_4(n28_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n22_test_ack_s_28),
    .test_ack_e_in(n29_test_ack_w_28),
    .test_ack_s_in(n34_test_ack_n_28),
    .test_ack_w_in(n27_test_ack_e_28),
    .n_faulty(n22_faulty_out),
    .e_faulty(n29_faulty_out),
    .s_faulty(n34_faulty_out),
    .w_faulty(n27_faulty_out),
    .faulty_to_out(n28_faulty_out),//給四面八方
    .test_ack_n(n28_test_ack_n_22),
    .test_ack_e(n28_test_ack_e_29),
    .test_ack_s(n28_test_ack_s_34),
    .test_ack_w(n28_test_ack_w_27),
    .test_set_to_input(n28_test_set)
);

//n29 --> n23 port 0
wire [`DATA_WIDTH-1:0]      n29_odata_23;
wire                        n29_ovalid_23;
wire [`VCH_WIDTH_NUM-1:0]   n29_ovch_23;
wire [`VCH_WIDTH-1:0]       n29_olck_23;
wire [`VCH_WIDTH-1:0]       n29_oack_23;
wire                        n29_test_ack_n_23;
//n29 --> n35 port 2
wire [`DATA_WIDTH-1:0]      n29_odata_35;
wire                        n29_ovalid_35;
wire [`VCH_WIDTH_NUM-1:0]   n29_ovch_35;
wire [`VCH_WIDTH-1:0]       n29_olck_35;
wire [`VCH_WIDTH-1:0]       n29_oack_35;
wire                        n29_test_ack_s_35;
//n29 --> n28 port 3
wire [`DATA_WIDTH-1:0]      n29_odata_28;
wire                        n29_ovalid_28;
wire [`VCH_WIDTH_NUM-1:0]   n29_ovch_28;
wire [`VCH_WIDTH-1:0]       n29_olck_28;
wire [`VCH_WIDTH-1:0]       n29_oack_28;
wire                        n29_test_ack_w_28;
//29 - 23 35 28
wire [`F_NODE-1:0]          n29_faulty_out;
router #(29,WIDTHX,WIDTHY) n29(
    .clk(clk),
    .reset(reset),

    .my_xpos(5),
    .my_ypos(4),

    .idata_0(n23_odata_29),
    .ivalid_0(n23_ovalid_29),
    .ivch_0(n23_ovch_29),
    .oack_0(n29_oack_23),
    .ordy_0(),//X
    .olck_0(n29_olck_23),
    .iack_0(n23_oack_29),
    .ilck_0(n23_olck_29),
    .odata_0(n29_odata_23),
    .ovalid_0(n29_ovalid_23),
    .ovch_0(n29_ovch_23),

    .idata_1(`DATA_WIDTH'b0),
    .ivalid_1(1'b0),
    .ivch_1(`VCH_WIDTH_NUM'b0),
    .oack_1(),
    .ordy_1(),//X
    .olck_1(),
    .iack_1(`VCH_WIDTH'b0),
    .ilck_1(`VCH_WIDTH'b0),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(n35_odata_29),
    .ivalid_2(n35_ovalid_29),
    .ivch_2(n35_ovch_29),
    .oack_2(n29_oack_35),
    .ordy_2(),//X
    .olck_2(n29_olck_35),
    .iack_2(n35_oack_29),
    .ilck_2(n35_olck_29),
    .odata_2(n29_odata_35),
    .ovalid_2(n29_ovalid_35),
    .ovch_2(n29_ovch_35),

    .idata_3(n28_odata_29),
    .ivalid_3(n28_ovalid_29),
    .ivch_3(n28_ovch_29),
    .oack_3(n29_oack_28),
    .ordy_3(),//X
    .olck_3(n29_olck_28),
    .iack_3(n28_oack_29),
    .ilck_3(n28_olck_29),
    .odata_3(n29_odata_28),
    .ovalid_3(n29_ovalid_28),
    .ovch_3(n29_ovch_28),

    .idata_4(n29_idata_p0),
    .ivalid_4(n29_ivalid_p0),
    .ivch_4(n29_ivch_p0),
    .oack_4(),//X
    .ordy_4(n29_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n29_odata_p0),
    .ovalid_4(n29_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n23_test_ack_s_29),
    .test_ack_e_in(),
    .test_ack_s_in(n35_test_ack_n_29),
    .test_ack_w_in(n28_test_ack_e_29),
    .n_faulty(n23_faulty_out),
    .e_faulty(),
    .s_faulty(n35_faulty_out),
    .w_faulty(n28_faulty_out),
    .faulty_to_out(n29_faulty_out),//給四面八方
    .test_ack_n(n29_test_ack_n_23),
    .test_ack_e(),
    .test_ack_s(n29_test_ack_s_35),
    .test_ack_w(n29_test_ack_w_28),
    .test_set_to_input(n29_test_set)
);

//n30 --> n24 port 0
wire [`DATA_WIDTH-1:0]      n30_odata_24;
wire                        n30_ovalid_24;
wire [`VCH_WIDTH_NUM-1:0]   n30_ovch_24;
wire [`VCH_WIDTH-1:0]       n30_olck_24;
wire [`VCH_WIDTH-1:0]       n30_oack_24;
wire                        n30_test_ack_n_24;
//n30 --> 31 port 1
wire [`DATA_WIDTH-1:0]      n30_odata_31;
wire                        n30_ovalid_31;
wire [`VCH_WIDTH_NUM-1:0]   n30_ovch_31;
wire [`VCH_WIDTH-1:0]       n30_olck_31;
wire [`VCH_WIDTH-1:0]       n30_oack_31;
wire                        n30_test_ack_e_31;
//30 - 24 31
wire [`F_NODE-1:0]          n30_faulty_out;

router #(30,WIDTHX,WIDTHY) n30(
    .clk(clk),
    .reset(reset),

    .my_xpos(0),
    .my_ypos(5),

    .idata_0(n24_odata_30),
    .ivalid_0(n24_ovalid_30),
    .ivch_0(n24_ovch_30),
    .oack_0(n30_oack_24),
    .ordy_0(),//X
    .olck_0(n30_olck_24),
    .iack_0(n24_oack_30),
    .ilck_0(n24_olck_30),
    .odata_0(n30_odata_24),
    .ovalid_0(n30_ovalid_24),
    .ovch_0(n30_ovch_24),

    .idata_1(n31_odata_30),
    .ivalid_1(n31_ovalid_30),
    .ivch_1(n31_ovch_30),
    .oack_1(n30_oack_31),
    .ordy_1(),//X
    .olck_1(n30_olck_31),
    .iack_1(n31_oack_30),
    .ilck_1(n31_olck_30),
    .odata_1(n30_odata_31),
    .ovalid_1(n30_ovalid_31),
    .ovch_1(n30_ovch_31),

    .idata_2(`DATA_WIDTH'b0),
    .ivalid_2(1'b0),
    .ivch_2(`VCH_WIDTH_NUM'b0),
    .oack_2(),
    .ordy_2(),//X
    .olck_2(),
    .iack_2(`VCH_WIDTH'b0),
    .ilck_2(`VCH_WIDTH'b0),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(`DATA_WIDTH'b0),
    .ivalid_3(1'b0),
    .ivch_3(`VCH_WIDTH_NUM'b0),
    .oack_3(),//X
    .ordy_3(),//X
    .olck_3(),//X
    .iack_3(`VCH_WIDTH'b0),
    .ilck_3(`VCH_WIDTH'b0),
    .odata_3(),//X
    .ovalid_3(),//X
    .ovch_3(),//X

    .idata_4(n30_idata_p0),
    .ivalid_4(n30_ivalid_p0),
    .ivch_4(n30_ivch_p0),
    .oack_4(),//X
    .ordy_4(n30_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n30_odata_p0),
    .ovalid_4(n30_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n24_test_ack_s_30),
    .test_ack_e_in(n31_test_ack_w_30),
    .test_ack_s_in(),
    .test_ack_w_in(),
    .n_faulty(n24_faulty_out),
    .e_faulty(n31_faulty_out),
    .s_faulty(),
    .w_faulty(),
    .faulty_to_out(n30_faulty_out),//給四面八方
    .test_ack_n(n30_test_ack_n_24),
    .test_ack_e(n30_test_ack_e_31),
    .test_ack_s(),
    .test_ack_w(),
    .test_set_to_input(n30_test_set)
);


//n31 --> n25 port 0
wire [`DATA_WIDTH-1:0]      n31_odata_25;
wire                        n31_ovalid_25;
wire [`VCH_WIDTH_NUM-1:0]   n31_ovch_25;
wire [`VCH_WIDTH-1:0]       n31_olck_25;
wire [`VCH_WIDTH-1:0]       n31_oack_25;
wire                        n31_test_ack_n_25;
//n31 --> n32 port 1
wire [`DATA_WIDTH-1:0]      n31_odata_32;
wire                        n31_ovalid_32;
wire [`VCH_WIDTH_NUM-1:0]   n31_ovch_32;
wire [`VCH_WIDTH-1:0]       n31_olck_32;
wire [`VCH_WIDTH-1:0]       n31_oack_32;
wire                        n31_test_ack_e_32;
//n31 --> n30 port 3
wire [`DATA_WIDTH-1:0]      n31_odata_30;
wire                        n31_ovalid_30;
wire [`VCH_WIDTH_NUM-1:0]   n31_ovch_30;
wire [`VCH_WIDTH-1:0]       n31_olck_30;
wire [`VCH_WIDTH-1:0]       n31_oack_30;
wire                        n31_test_ack_w_30;
//31 - 25 32 30
wire [`F_NODE-1:0]          n31_faulty_out;

router #(31,WIDTHX,WIDTHY) n31(
    .clk(clk),
    .reset(reset),

    .my_xpos(1),
    .my_ypos(5),

    .idata_0(n25_odata_31),
    .ivalid_0(n25_ovalid_31),
    .ivch_0(n25_ovch_31),
    .oack_0(n31_oack_25),
    .ordy_0(),//X
    .olck_0(n31_olck_25),
    .iack_0(n25_oack_31),
    .ilck_0(n25_olck_31),
    .odata_0(n31_odata_25),
    .ovalid_0(n31_ovalid_25),
    .ovch_0(n31_ovch_25),

    .idata_1(n32_odata_31),
    .ivalid_1(n32_ovalid_31),
    .ivch_1(n32_ovch_31),
    .oack_1(n31_oack_32),
    .ordy_1(),//X
    .olck_1(n31_olck_32),
    .iack_1(n32_oack_31),
    .ilck_1(n32_olck_31),
    .odata_1(n31_odata_32),
    .ovalid_1(n31_ovalid_32),
    .ovch_1(n31_ovch_32),

    .idata_2(`DATA_WIDTH'b0),
    .ivalid_2(1'b0),
    .ivch_2(`VCH_WIDTH_NUM'b0),
    .oack_2(),
    .ordy_2(),//X
    .olck_2(),
    .iack_2(`VCH_WIDTH'b0),
    .ilck_2(`VCH_WIDTH'b0),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n30_odata_31),
    .ivalid_3(n30_ovalid_31),
    .ivch_3(n30_ovch_31),
    .oack_3(n31_oack_30),
    .ordy_3(),//X
    .olck_3(n31_olck_30),
    .iack_3(n30_oack_31),
    .ilck_3(n30_olck_31),
    .odata_3(n31_odata_30),
    .ovalid_3(n31_ovalid_30),
    .ovch_3(n31_ovch_30),

    .idata_4(n31_idata_p0),
    .ivalid_4(n31_ivalid_p0),
    .ivch_4(n31_ivch_p0),
    .oack_4(),//X
    .ordy_4(n31_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n31_odata_p0),
    .ovalid_4(n31_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n25_test_ack_s_31),
    .test_ack_e_in(n32_test_ack_w_31),
    .test_ack_s_in(),
    .test_ack_w_in(n30_test_ack_e_31),
    .n_faulty(n25_faulty_out),
    .e_faulty(n32_faulty_out),
    .s_faulty(),
    .w_faulty(n30_faulty_out),
    .faulty_to_out(n31_faulty_out),//給四面八方
    .test_ack_n(n31_test_ack_n_25),
    .test_ack_e(n31_test_ack_e_32),
    .test_ack_s(),
    .test_ack_w(n31_test_ack_w_30),
    .test_set_to_input(n31_test_set)
);


//n32 --> n26 port 0
wire [`DATA_WIDTH-1:0]      n32_odata_26;
wire                        n32_ovalid_26;
wire [`VCH_WIDTH_NUM-1:0]   n32_ovch_26;
wire [`VCH_WIDTH-1:0]       n32_olck_26;
wire [`VCH_WIDTH-1:0]       n32_oack_26;
wire                        n32_test_ack_n_26;
//n32 --> n33 port 1
wire [`DATA_WIDTH-1:0]      n32_odata_33;
wire                        n32_ovalid_33;
wire [`VCH_WIDTH_NUM-1:0]   n32_ovch_33;
wire [`VCH_WIDTH-1:0]       n32_olck_33;
wire [`VCH_WIDTH-1:0]       n32_oack_33;
wire                        n32_test_ack_e_33;
//n32 --> n31 port 3
wire [`DATA_WIDTH-1:0]      n32_odata_31;
wire                        n32_ovalid_31;
wire [`VCH_WIDTH_NUM-1:0]   n32_ovch_31;
wire [`VCH_WIDTH-1:0]       n32_olck_31;
wire [`VCH_WIDTH-1:0]       n32_oack_31;
wire                        n32_test_ack_w_31;
//32 - 26 33 31
wire [`F_NODE-1:0]          n32_faulty_out;
router #(32,WIDTHX,WIDTHY) n32(
    .clk(clk),
    .reset(reset),

    .my_xpos(2),
    .my_ypos(5),

    .idata_0(n26_odata_32),
    .ivalid_0(n26_ovalid_32),
    .ivch_0(n26_ovch_32),
    .oack_0(n32_oack_26),
    .ordy_0(),//X
    .olck_0(n32_olck_26),
    .iack_0(n26_oack_32),
    .ilck_0(n26_olck_32),
    .odata_0(n32_odata_26),
    .ovalid_0(n32_ovalid_26),
    .ovch_0(n32_ovch_26),

    .idata_1(n33_odata_32),
    .ivalid_1(n33_ovalid_32),
    .ivch_1(n33_ovch_32),
    .oack_1(n32_oack_33),
    .ordy_1(),//X
    .olck_1(n32_olck_33),
    .iack_1(n33_oack_32),
    .ilck_1(n33_olck_32),
    .odata_1(n32_odata_33),
    .ovalid_1(n32_ovalid_33),
    .ovch_1(n32_ovch_33),

    .idata_2(`DATA_WIDTH'b0),
    .ivalid_2(1'b0),
    .ivch_2(`VCH_WIDTH_NUM'b0),
    .oack_2(),
    .ordy_2(),//X
    .olck_2(),
    .iack_2(`VCH_WIDTH'b0),
    .ilck_2(`VCH_WIDTH'b0),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n31_odata_32),
    .ivalid_3(n31_ovalid_32),
    .ivch_3(n31_ovch_32),
    .oack_3(n32_oack_31),
    .ordy_3(),//X
    .olck_3(n32_olck_31),
    .iack_3(n31_oack_32),
    .ilck_3(n31_olck_32),
    .odata_3(n32_odata_31),
    .ovalid_3(n32_ovalid_31),
    .ovch_3(n32_ovch_31),

    .idata_4(n32_idata_p0),
    .ivalid_4(n32_ivalid_p0),
    .ivch_4(n32_ivch_p0),
    .oack_4(),//X
    .ordy_4(n32_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n32_odata_p0),
    .ovalid_4(n32_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n26_test_ack_s_32),
    .test_ack_e_in(n33_test_ack_w_32),
    .test_ack_s_in(),
    .test_ack_w_in(n31_test_ack_e_32),
    .n_faulty(n26_faulty_out),
    .e_faulty(n33_faulty_out),
    .s_faulty(),
    .w_faulty(n31_faulty_out),//X
    .faulty_to_out(n32_faulty_out),//給四面八方
    .test_ack_n(n32_test_ack_n_26),
    .test_ack_e(n32_test_ack_e_33),
    .test_ack_s(),
    .test_ack_w(n32_test_ack_w_31),
    .test_set_to_input(n32_test_set)
);


//n33 --> n27 port 0
wire [`DATA_WIDTH-1:0]      n33_odata_27;
wire                        n33_ovalid_27;
wire [`VCH_WIDTH_NUM-1:0]   n33_ovch_27;
wire [`VCH_WIDTH-1:0]       n33_olck_27;
wire [`VCH_WIDTH-1:0]       n33_oack_27;
wire                        n33_test_ack_n_27;
//n33 --> n34 port 1
wire [`DATA_WIDTH-1:0]      n33_odata_34;
wire                        n33_ovalid_34;
wire [`VCH_WIDTH_NUM-1:0]   n33_ovch_34;
wire [`VCH_WIDTH-1:0]       n33_olck_34;
wire [`VCH_WIDTH-1:0]       n33_oack_34;
wire                        n33_test_ack_e_34;
//n33 --> n32 port 3
wire [`DATA_WIDTH-1:0]      n33_odata_32;
wire                        n33_ovalid_32;
wire [`VCH_WIDTH_NUM-1:0]   n33_ovch_32;
wire [`VCH_WIDTH-1:0]       n33_olck_32;
wire [`VCH_WIDTH-1:0]       n33_oack_32;
wire                        n33_test_ack_w_32;
//33 - 27 34 32
wire [`F_NODE-1:0]          n33_faulty_out;
router #(33,WIDTHX,WIDTHY) n33(
    .clk(clk),
    .reset(reset),

    .my_xpos(3),
    .my_ypos(5),

    .idata_0(n27_odata_33),
    .ivalid_0(n27_ovalid_33),
    .ivch_0(n27_ovch_33),
    .oack_0(n33_oack_27),
    .ordy_0(),//X
    .olck_0(n33_olck_27),
    .iack_0(n27_oack_33),
    .ilck_0(n27_olck_33),
    .odata_0(n33_odata_27),
    .ovalid_0(n33_ovalid_27),
    .ovch_0(n33_ovch_27),

    .idata_1(n34_odata_33),
    .ivalid_1(n34_ovalid_33),
    .ivch_1(n34_ovch_33),
    .oack_1(n33_oack_34),
    .ordy_1(),//X
    .olck_1(n33_olck_34),
    .iack_1(n34_oack_33),
    .ilck_1(n34_olck_33),
    .odata_1(n33_odata_34),
    .ovalid_1(n33_ovalid_34),
    .ovch_1(n33_ovch_34),

    .idata_2(`DATA_WIDTH'b0),
    .ivalid_2(1'b0),
    .ivch_2(`VCH_WIDTH_NUM'b0),
    .oack_2(),
    .ordy_2(),//X
    .olck_2(),
    .iack_2(`VCH_WIDTH'b0),
    .ilck_2(`VCH_WIDTH'b0),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n32_odata_33),
    .ivalid_3(n32_ovalid_33),
    .ivch_3(n32_ovch_33),
    .oack_3(n33_oack_32),
    .ordy_3(),//X
    .olck_3(n33_olck_32),
    .iack_3(n32_oack_33),
    .ilck_3(n32_olck_33),
    .odata_3(n33_odata_32),
    .ovalid_3(n33_ovalid_32),
    .ovch_3(n33_ovch_32),

    .idata_4(n33_idata_p0),
    .ivalid_4(n33_ivalid_p0),
    .ivch_4(n33_ivch_p0),
    .oack_4(),//X
    .ordy_4(n33_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n33_odata_p0),
    .ovalid_4(n33_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n27_test_ack_s_33),
    .test_ack_e_in(n34_test_ack_w_33),
    .test_ack_s_in(),
    .test_ack_w_in(n32_test_ack_e_33),
    .n_faulty(n27_faulty_out),
    .e_faulty(n34_faulty_out),
    .s_faulty(),
    .w_faulty(n32_faulty_out),
    .faulty_to_out(n33_faulty_out),//給四面八方
    .test_ack_n(n33_test_ack_n_27),
    .test_ack_e(n33_test_ack_e_34),
    .test_ack_s(),
    .test_ack_w(n33_test_ack_w_32),
    .test_set_to_input(n33_test_set)
);


//n34 --> n28 port 0
wire [`DATA_WIDTH-1:0]      n34_odata_28;
wire                        n34_ovalid_28;
wire [`VCH_WIDTH_NUM-1:0]   n34_ovch_28;
wire [`VCH_WIDTH-1:0]       n34_olck_28;
wire [`VCH_WIDTH-1:0]       n34_oack_28;
wire                        n34_test_ack_n_28;
//n34 --> n35 port 1
wire [`DATA_WIDTH-1:0]      n34_odata_35;
wire                        n34_ovalid_35;
wire [`VCH_WIDTH_NUM-1:0]   n34_ovch_35;
wire [`VCH_WIDTH-1:0]       n34_olck_35;
wire [`VCH_WIDTH-1:0]       n34_oack_35;
wire                        n34_test_ack_e_35;
//n34 --> n33 port 3
wire [`DATA_WIDTH-1:0]      n34_odata_33;
wire                        n34_ovalid_33;
wire [`VCH_WIDTH_NUM-1:0]   n34_ovch_33;
wire [`VCH_WIDTH-1:0]       n34_olck_33;
wire [`VCH_WIDTH-1:0]       n34_oack_33;
wire                        n34_test_ack_w_33;
//34 - 28 35 33
wire [`F_NODE-1:0]          n34_faulty_out;
router #(34,WIDTHX,WIDTHY) n34(
    .clk(clk),
    .reset(reset),

    .my_xpos(4),
    .my_ypos(5),

    .idata_0(n28_odata_34),
    .ivalid_0(n28_ovalid_34),
    .ivch_0(n28_ovch_34),
    .oack_0(n34_oack_28),
    .ordy_0(),//X
    .olck_0(n34_olck_28),
    .iack_0(n28_oack_34),
    .ilck_0(n28_olck_34),
    .odata_0(n34_odata_28),
    .ovalid_0(n34_ovalid_28),
    .ovch_0(n34_ovch_28),

    .idata_1(n35_odata_34),
    .ivalid_1(n35_ovalid_34),
    .ivch_1(n35_ovch_34),
    .oack_1(n34_oack_35),
    .ordy_1(),//X
    .olck_1(n34_olck_35),
    .iack_1(n35_oack_34),
    .ilck_1(n35_olck_34),
    .odata_1(n34_odata_35),
    .ovalid_1(n34_ovalid_35),
    .ovch_1(n34_ovch_35),

    .idata_2(`DATA_WIDTH'b0),
    .ivalid_2(1'b0),
    .ivch_2(`VCH_WIDTH_NUM'b0),
    .oack_2(),
    .ordy_2(),//X
    .olck_2(),
    .iack_2(`VCH_WIDTH'b0),
    .ilck_2(`VCH_WIDTH'b0),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n33_odata_34),
    .ivalid_3(n33_ovalid_34),
    .ivch_3(n33_ovch_34),
    .oack_3(n34_oack_33),
    .ordy_3(),//X
    .olck_3(n34_olck_33),
    .iack_3(n33_oack_34),
    .ilck_3(n33_olck_34),
    .odata_3(n34_odata_33),
    .ovalid_3(n34_ovalid_33),
    .ovch_3(n34_ovch_33),

    .idata_4(n34_idata_p0),
    .ivalid_4(n34_ivalid_p0),
    .ivch_4(n34_ivch_p0),
    .oack_4(),//X
    .ordy_4(n34_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n34_odata_p0),
    .ovalid_4(n34_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n28_test_ack_s_34),
    .test_ack_e_in(n35_test_ack_w_34),
    .test_ack_s_in(),
    .test_ack_w_in(n33_test_ack_e_34),
    .n_faulty(n28_faulty_out),
    .e_faulty(n35_faulty_out),
    .s_faulty(),
    .w_faulty(n33_faulty_out),
    .faulty_to_out(n34_faulty_out),//給四面八方
    .test_ack_n(n34_test_ack_n_28),
    .test_ack_e(n34_test_ack_e_35),
    .test_ack_s(),
    .test_ack_w(n34_test_ack_w_33),
    .test_set_to_input(n34_test_set)
);


//n35 --> n29 port 0
wire [`DATA_WIDTH-1:0]      n35_odata_29;
wire                        n35_ovalid_29;
wire [`VCH_WIDTH_NUM-1:0]   n35_ovch_29;
wire [`VCH_WIDTH-1:0]       n35_olck_29;
wire [`VCH_WIDTH-1:0]       n35_oack_29;
wire                        n35_test_ack_n_29;
//n35 --> n34 port 3
wire [`DATA_WIDTH-1:0]      n35_odata_34;
wire                        n35_ovalid_34;
wire [`VCH_WIDTH_NUM-1:0]   n35_ovch_34;
wire [`VCH_WIDTH-1:0]       n35_olck_34;
wire [`VCH_WIDTH-1:0]       n35_oack_34;
wire                        n35_test_ack_w_34;
//35 - 29 34
wire [`F_NODE-1:0]          n35_faulty_out;
router #(35,WIDTHX,WIDTHY) n35(
    .clk(clk),
    .reset(reset),

    .my_xpos(5),
    .my_ypos(5),

    .idata_0(n29_odata_35),
    .ivalid_0(n29_ovalid_35),
    .ivch_0(n29_ovch_35),
    .oack_0(n35_oack_29),
    .ordy_0(),//X
    .olck_0(n35_olck_29),
    .iack_0(n29_oack_35),
    .ilck_0(n29_olck_35),
    .odata_0(n35_odata_29),
    .ovalid_0(n35_ovalid_29),
    .ovch_0(n35_ovch_29),

    .idata_1(`DATA_WIDTH'b0),
    .ivalid_1(1'b0),
    .ivch_1(`VCH_WIDTH_NUM'b0),
    .oack_1(),
    .ordy_1(),//X
    .olck_1(),
    .iack_1(`VCH_WIDTH'b0),
    .ilck_1(`VCH_WIDTH'b0),
    .odata_1(),
    .ovalid_1(),
    .ovch_1(),

    .idata_2(`DATA_WIDTH'b0),
    .ivalid_2(1'b0),
    .ivch_2(`VCH_WIDTH_NUM'b0),
    .oack_2(),
    .ordy_2(),//X
    .olck_2(),
    .iack_2(`VCH_WIDTH'b0),
    .ilck_2(`VCH_WIDTH'b0),
    .odata_2(),
    .ovalid_2(),
    .ovch_2(),

    .idata_3(n34_odata_35),
    .ivalid_3(n34_ovalid_35),
    .ivch_3(n34_ovch_35),
    .oack_3(n35_oack_34),
    .ordy_3(),//X
    .olck_3(n35_olck_34),
    .iack_3(n34_oack_35),
    .ilck_3(n34_olck_35),
    .odata_3(n35_odata_34),
    .ovalid_3(n35_ovalid_34),
    .ovch_3(n35_ovch_34),

    .idata_4(n35_idata_p0),
    .ivalid_4(n35_ivalid_p0),
    .ivch_4(n35_ivch_p0),
    .oack_4(),//X
    .ordy_4(n35_ordy_p0),
    .olck_4(),//X
    .iack_4(4'b1111),
    .ilck_4(4'b0000),
    .odata_4(n35_odata_p0),
    .ovalid_4(n35_ovalid_p0),
    .ovch_4(),//X

    .test_ack_n_in(n29_test_ack_s_35),
    .test_ack_e_in(),
    .test_ack_s_in(),
    .test_ack_w_in(n34_test_ack_e_35),
    .n_faulty(n29_faulty_out),
    .e_faulty(),
    .s_faulty(),
    .w_faulty(n34_faulty_out),
    .faulty_to_out(n35_faulty_out),//給四面八方
    .test_ack_n(n35_test_ack_n_29),
    .test_ack_e(),
    .test_ack_s(),
    .test_ack_w(n35_test_ack_w_34),
    .test_set_to_input(n35_test_set)
);

// //n8 --> n2 port 0
// wire [`DATA_WIDTH-1:0]      n_odata_;
// wire                        n_ovalid_;
// wire [`VCH_WIDTH_NUM-1:0]   n_ovch_;
// wire [`VCH_WIDTH-1:0]       n_olck_;
// wire [`VCH_WIDTH-1:0]       n_oack_;
// wire                        n_test_ack_n_;
// //n8 --> n9 port 1
// wire [`DATA_WIDTH-1:0]      n_odata_;
// wire                        n_ovalid_;
// wire [`VCH_WIDTH_NUM-1:0]   n_ovch_;
// wire [`VCH_WIDTH-1:0]       n_olck_;
// wire [`VCH_WIDTH-1:0]       n_oack_;
// wire                        n_test_ack_e_;
// //n8 --> n14 port 2
// wire [`DATA_WIDTH-1:0]      n_odata_;
// wire                        n_ovalid_;
// wire [`VCH_WIDTH_NUM-1:0]   n_ovch_;
// wire [`VCH_WIDTH-1:0]       n_olck_;
// wire [`VCH_WIDTH-1:0]       n_oack_;
// wire                        n_test_ack_s_;
// //n8 --> n7 port 3
// wire [`DATA_WIDTH-1:0]      n_odata_;
// wire                        n_ovalid_;
// wire [`VCH_WIDTH_NUM-1:0]   n_ovch_;
// wire [`VCH_WIDTH-1:0]       n_olck_;
// wire [`VCH_WIDTH-1:0]       n_oack_;
// wire                        n_test_ack_w_;

// router #() n(
//     .clk(clk),
//     .reset(reset),

//     .my_xpos(),
//     .my_ypos(),

//     .idata_0(n_odata_),
//     .ivalid_0(n_ovalid_),
//     .ivch_0(n_ovch_),
//     .oack_0(n_oack_),
//     .ordy_0(),//X
//     .olck_0(n_olck_),
//     .iack_0(n_oack_),
//     .ilck_0(n_olck_),
//     .odata_0(n_odata_),
//     .ovalid_0(n_ovalid_),
//     .ovch_0(n_ovch_),

//     .idata_1(n_odata_),
//     .ivalid_1(n_ovalid_),
//     .ivch_1(n_ovch_),
//     .oack_1(n_oack_),
//     .ordy_1(),//X
//     .olck_1(n_olck_),
//     .iack_1(n_oack_),
//     .ilck_1(n_olck_),
//     .odata_1(n_odata_),
//     .ovalid_1(n_ovalid_),
//     .ovch_1(n_ovch_),

//     .idata_2(n_odata_),
//     .ivalid_2(n_ovalid_),
//     .ivch_2(n_ovch_),
//     .oack_2(n_oack_),
//     .ordy_2(),//X
//     .olck_2(n_olck_),
//     .iack_2(n_oack_),
//     .ilck_2(n_olck_),
//     .odata_2(n_odata_),
//     .ovalid_2(n_ovalid_),
//     .ovch_2(n_ovch_),

//     .idata_3(n_odata_),
//     .ivalid_3(n_ovalid_),
//     .ivch_3(n_ovch_),
//     .oack_3(n_oack_),
//     .ordy_3(),//X
//     .olck_3(n_olck_),
//     .iack_3(n_oack_),
//     .ilck_3(n_olck_),
//     .odata_3(n_odata_),
//     .ovalid_3(n_ovalid_),
//     .ovch_3(n_ovch_),

//     .idata_4(n_idata_p0),
//     .ivalid_4(n_ivalid_p0),
//     .ivch_4(n_ivch_p0),
//     .oack_4(),//X
//     .ordy_4(nordy_p0),
//     .olck_4(),//X
//     .iack_4(4'b1111),
//     .ilck_4(4'b0000),
//     .odata_4(n_odata_p0),
//     .ovalid_4(n_ovalid_p0),
//     .ovch_4(),//X

//     .test_ack_n_in(n_test_ack_s_),
//     .test_ack_e_in(n_test_ack_w_),
//     .test_ack_s_in(n_test_ack_n_),
//     .test_ack_w_in(n_test_ack_e_),
//     .n_faulty(),
//     .e_faulty(),
//     .s_faulty(),
//     .w_faulty(),//X
//     .faulty_to_out(),//給四面八方
//     .test_ack_n(n_test_ack_n_),
//     .test_ack_e(n_test_ack_e_),
//     .test_ack_s(n_test_ack_s_),
//     .test_ack_w(n_test_ack_w_),
//     .test_set_to_input(n_test_set)
// );

endmodule

