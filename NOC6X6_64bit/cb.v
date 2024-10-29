`include "defines.v"
module cb (
    input wire clk,
    input wire reset,

    //to / from ic 0
    input wire [`DATA_WIDTH-1:0] idata_0,
    input wire ivalid_0,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_0,
    input wire [`PORT_NUM-1:0] port_0,
    input wire req_0,
    output  [4:0] grt_0,

    //to / from ic 1
    input wire [`DATA_WIDTH-1:0] idata_1,
    input wire ivalid_1,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_1,
    input wire [`PORT_NUM-1:0] port_1,
    input wire req_1,
    output [4:0] grt_1,

    //to / from ic 2
    input wire [`DATA_WIDTH-1:0] idata_2,
    input wire ivalid_2,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_2,
    input wire [`PORT_NUM-1:0] port_2,
    input wire req_2,
    output [4:0] grt_2,

    //to / from ic 3
    input wire [`DATA_WIDTH-1:0] idata_3,
    input wire ivalid_3,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_3,
    input wire [`PORT_NUM-1:0] port_3,
    input wire req_3,
    output [4:0] grt_3,

    //to / from ic 4
    input wire [`DATA_WIDTH-1:0] idata_4,
    input wire ivalid_4,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_4,
    input wire [`PORT_NUM-1:0] port_4,
    input wire req_4,
    output [4:0] grt_4,

    // to oc 0
    output reg [`DATA_WIDTH-1:0] odata_0,
    output reg ovalid_0,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch_0,

    // to oc 1
    output reg [`DATA_WIDTH-1:0] odata_1,
    output reg ovalid_1,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch_1,

    // to oc 2
    output reg [`DATA_WIDTH-1:0] odata_2,
    output reg ovalid_2,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch_2,

    // to oc 3
    output reg [`DATA_WIDTH-1:0] odata_3,
    output reg ovalid_3,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch_3,

    // to oc 4
    output reg [`DATA_WIDTH-1:0] odata_4,
    output reg ovalid_4,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch_4
);

//授權回傳
wire [`PORT-1:0] muxcont_grt0;
wire [`PORT-1:0] muxcont_grt1;
wire [`PORT-1:0] muxcont_grt2;
wire [`PORT-1:0] muxcont_grt3;
wire [`PORT-1:0] muxcont_grt4;

//          ic_x回傳    oc_x的代理人，授權給ic_x    
assign  grt_0[0] = muxcont_grt0[0];
assign  grt_0[1] = muxcont_grt1[0];
assign  grt_0[2] = muxcont_grt2[0];
assign  grt_0[3] = muxcont_grt3[0];
assign  grt_0[4] = muxcont_grt4[0]; // oc 4 授權給 ic 0

assign  grt_1[0] = muxcont_grt0[1];
assign  grt_1[1] = muxcont_grt1[1];
assign  grt_1[2] = muxcont_grt2[1];
assign  grt_1[3] = muxcont_grt3[1];
assign  grt_1[4] = muxcont_grt4[1]; 

assign  grt_2[0] = muxcont_grt0[2];
assign  grt_2[1] = muxcont_grt1[2];
assign  grt_2[2] = muxcont_grt2[2];
assign  grt_2[3] = muxcont_grt3[2];
assign  grt_2[4] = muxcont_grt4[2]; 

assign  grt_3[0] = muxcont_grt0[3];
assign  grt_3[1] = muxcont_grt1[3];
assign  grt_3[2] = muxcont_grt2[3];
assign  grt_3[3] = muxcont_grt3[3];
assign  grt_3[4] = muxcont_grt4[3]; 

assign  grt_4[0] = muxcont_grt0[4];
assign  grt_4[1] = muxcont_grt1[4];
assign  grt_4[2] = muxcont_grt2[4];
assign  grt_4[3] = muxcont_grt3[4];
assign  grt_4[4] = muxcont_grt4[4];

/* muxcont */
muxcont #(0) muxcont0 (
    .clk(clk),
    .reset(reset),

    .port_0(port_0),
    .req_0(req_0),

    .port_1(port_1),
    .req_1(req_1),

    .port_2(port_2),
    .req_2(req_2),

    .port_3(port_3),
    .req_3(req_3),

    .port_4(port_4),
    .req_4(req_4),

    .grt(muxcont_grt0),
    .sel(muxcont0_to_mux0_sel)
);

muxcont #(1) muxcont1 (
    .clk(clk),
    .reset(reset),

    .port_0(port_0),
    .req_0(req_0),

    .port_1(port_1),
    .req_1(req_1),

    .port_2(port_2),
    .req_2(req_2),

    .port_3(port_3),
    .req_3(req_3),

    .port_4(port_4),
    .req_4(req_4),

    .grt(muxcont_grt1),
    .sel(muxcont1_to_mux1_sel)
);

muxcont #(2) muxcont2 (
    .clk(clk),
    .reset(reset),

    .port_0(port_0),
    .req_0(req_0),

    .port_1(port_1),
    .req_1(req_1),

    .port_2(port_2),
    .req_2(req_2),

    .port_3(port_3),
    .req_3(req_3),

    .port_4(port_4),
    .req_4(req_4),

    .grt(muxcont_grt2),
    .sel(muxcont2_to_mux2_sel)
);

muxcont #(3) muxcont3 (
    .clk(clk),
    .reset(reset),

    .port_0(port_0),
    .req_0(req_0),

    .port_1(port_1),
    .req_1(req_1),

    .port_2(port_2),
    .req_2(req_2),

    .port_3(port_3),
    .req_3(req_3),

    .port_4(port_4),
    .req_4(req_4),

    .grt(muxcont_grt3),
    .sel(muxcont3_to_mux3_sel)
);

muxcont #(4) muxcont4 (
    .clk(clk),
    .reset(reset),

    .port_0(port_0),
    .req_0(req_0),

    .port_1(port_1),
    .req_1(req_1),

    .port_2(port_2),
    .req_2(req_2),

    .port_3(port_3),
    .req_3(req_3),

    .port_4(port_4),
    .req_4(req_4),

    .grt(muxcont_grt4),
    .sel(muxcont4_to_mux4_sel)
);

wire [`PORT-1:0] muxcont0_to_mux0_sel;

mux mux0(
    .idata_0(idata_0),
    .ivalid_0(ivalid_0),
    .ivch_0(ivch_0),

    .idata_1(idata_1),
    .ivalid_1(ivalid_1),
    .ivch_1(ivch_1),

    .idata_2(idata_2),
    .ivalid_2(ivalid_2),
    .ivch_2(ivch_2),

    .idata_3(idata_3),
    .ivalid_3(ivalid_3),
    .ivch_3(ivch_3),

    .idata_4(idata_4),
    .ivalid_4(ivalid_4),
    .ivch_4(ivch_4),

    .sel(muxcont0_to_mux0_sel),

    .odata(odata_0),    
    .ovalid(ovalid_0),
    .ovch(ovch_0)
);

wire [`PORT-1:0] muxcont1_to_mux1_sel;

mux mux1(
    .idata_0(idata_0),
    .ivalid_0(ivalid_0),
    .ivch_0(ivch_0),

    .idata_1(idata_1),
    .ivalid_1(ivalid_1),
    .ivch_1(ivch_1),

    .idata_2(idata_2),
    .ivalid_2(ivalid_2),
    .ivch_2(ivch_2),

    .idata_3(idata_3),
    .ivalid_3(ivalid_3),
    .ivch_3(ivch_3),

    .idata_4(idata_4),
    .ivalid_4(ivalid_4),
    .ivch_4(ivch_4),

    .sel(muxcont1_to_mux1_sel),

    .odata(odata_1),    
    .ovalid(ovalid_1),
    .ovch(ovch_1)
);

wire [`PORT-1:0] muxcont2_to_mux2_sel;

mux mux2(
    .idata_0(idata_0),
    .ivalid_0(ivalid_0),
    .ivch_0(ivch_0),

    .idata_1(idata_1),
    .ivalid_1(ivalid_1),
    .ivch_1(ivch_1),

    .idata_2(idata_2),
    .ivalid_2(ivalid_2),
    .ivch_2(ivch_2),

    .idata_3(idata_3),
    .ivalid_3(ivalid_3),
    .ivch_3(ivch_3),

    .idata_4(idata_4),
    .ivalid_4(ivalid_4),
    .ivch_4(ivch_4),

    .sel(muxcont2_to_mux2_sel),

    .odata(odata_2),    
    .ovalid(ovalid_2),
    .ovch(ovch_2)
);

wire [`PORT-1:0] muxcont3_to_mux3_sel;

mux mux3(
    .idata_0(idata_0),
    .ivalid_0(ivalid_0),
    .ivch_0(ivch_0),

    .idata_1(idata_1),
    .ivalid_1(ivalid_1),
    .ivch_1(ivch_1),

    .idata_2(idata_2),
    .ivalid_2(ivalid_2),
    .ivch_2(ivch_2),

    .idata_3(idata_3),
    .ivalid_3(ivalid_3),
    .ivch_3(ivch_3),

    .idata_4(idata_4),
    .ivalid_4(ivalid_4),
    .ivch_4(ivch_4),

    .sel(muxcont3_to_mux3_sel),

    .odata(odata_3),    
    .ovalid(ovalid_3),
    .ovch(ovch_3)
);

wire [`PORT-1:0] muxcont4_to_mux4_sel;

mux mux4(
    .idata_0(idata_0),
    .ivalid_0(ivalid_0),
    .ivch_0(ivch_0),

    .idata_1(idata_1),
    .ivalid_1(ivalid_1),
    .ivch_1(ivch_1),

    .idata_2(idata_2),
    .ivalid_2(ivalid_2),
    .ivch_2(ivch_2),

    .idata_3(idata_3),
    .ivalid_3(ivalid_3),
    .ivch_3(ivch_3),

    .idata_4(idata_4),
    .ivalid_4(ivalid_4),
    .ivch_4(ivch_4),

    .sel(muxcont4_to_mux4_sel),

    .odata(odata_4),    
    .ovalid(ovalid_4),
    .ovch(ovch_4)
);


endmodule