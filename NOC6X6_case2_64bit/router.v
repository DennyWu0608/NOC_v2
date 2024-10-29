`include "defines.v"
module router #(parameter  ROUTERID = 0, parameter WIDTHX = 0, parameter WIDTHY = 0)(
    input wire clk,
    input wire reset,

    input wire [2:0] my_xpos,
    input wire [2:0] my_ypos,

    //to / form input_unit 0
    input wire [`DATA_WIDTH - 1:0] idata_0,
    input wire ivalid_0,
    input wire [`VCH_WIDTH_NUM - 1:0]ivch_0, //0 1 2 3
    output reg [`VCH_WIDTH - 1:0]oack_0,
    output reg [`VCH_WIDTH - 1:0]ordy_0,
    output reg [`VCH_WIDTH - 1:0]olck_0, 

    //to / form input_unit 1
    input wire [`DATA_WIDTH - 1:0] idata_1,
    input wire ivalid_1,
    input wire [`VCH_WIDTH_NUM - 1:0]ivch_1,
    output reg [`VCH_WIDTH - 1:0]oack_1,
    output reg [`VCH_WIDTH - 1:0]ordy_1,
    output reg [`VCH_WIDTH - 1:0]olck_1, 

    //to / form input_unit 2
    input wire [`DATA_WIDTH - 1:0] idata_2,
    input wire ivalid_2,
    input wire [`VCH_WIDTH_NUM - 1:0]ivch_2,
    output reg [`VCH_WIDTH - 1:0]oack_2,
    output reg [`VCH_WIDTH - 1:0]ordy_2,
    output reg [`VCH_WIDTH - 1:0]olck_2,

    //to / form input_unit 3
    input wire [`DATA_WIDTH - 1:0] idata_3,
    input wire ivalid_3,
    input wire [`VCH_WIDTH_NUM - 1:0]ivch_3,
    output reg [`VCH_WIDTH - 1:0]oack_3,
    output reg [`VCH_WIDTH - 1:0]ordy_3,
    output reg [`VCH_WIDTH - 1:0]olck_3,

    //to / form input_unit 4
    input wire [`DATA_WIDTH - 1:0] idata_4,
    input wire ivalid_4,
    input wire [`VCH_WIDTH_NUM - 1:0]ivch_4,
    output reg [`VCH_WIDTH - 1:0]oack_4,
    output reg [`VCH_WIDTH - 1:0]ordy_4,
    output reg [`VCH_WIDTH - 1:0]olck_4,

    // to / form output_unit 0
    input wire [`VCH_WIDTH - 1:0] iack_0,
    input wire [`VCH_WIDTH - 1:0] ilck_0,
    output reg [`DATA_WIDTH - 1:0] odata_0,
    output reg ovalid_0,
    output reg [`VCH_WIDTH_NUM - 1:0]ovch_0,

    // to / form output_unit 1
    input wire [`VCH_WIDTH - 1:0] iack_1,
    input wire [`VCH_WIDTH - 1:0] ilck_1,
    output reg [`DATA_WIDTH - 1:0] odata_1,
    output reg ovalid_1,
    output reg [`VCH_WIDTH_NUM - 1:0]ovch_1,

    // to / form output_unit 2
    input wire [`VCH_WIDTH - 1:0] iack_2,
    input wire [`VCH_WIDTH - 1:0] ilck_2,
    output reg [`DATA_WIDTH - 1:0] odata_2,
    output reg ovalid_2,
    output reg [`VCH_WIDTH_NUM - 1:0]ovch_2,

    // to / form output_unit 3
    input wire [`VCH_WIDTH - 1:0] iack_3,
    input wire [`VCH_WIDTH - 1:0] ilck_3,
    output reg [`DATA_WIDTH - 1:0] odata_3,
    output reg ovalid_3,
    output reg [`VCH_WIDTH_NUM - 1:0]ovch_3,

    // to / form output_unit 4
    input wire [`VCH_WIDTH - 1:0] iack_4,
    input wire [`VCH_WIDTH - 1:0] ilck_4,
    output reg [`DATA_WIDTH - 1:0] odata_4,
    output reg ovalid_4,
    output reg [`VCH_WIDTH_NUM - 1:0]ovch_4,

    //test_ack
    input wire test_ack_n_in,
    input wire test_ack_e_in,
    input wire test_ack_s_in,
    input wire test_ack_w_in,
    input wire [`F_NODE-1:0]n_faulty,
    input wire [`F_NODE-1:0]e_faulty,
    input wire [`F_NODE-1:0]s_faulty,
    input wire [`F_NODE-1:0]w_faulty,
    output reg [`F_NODE-1:0]faulty_to_out,
    output reg test_ack_n,
    output reg test_ack_e,
    output reg test_ack_s,
    output reg test_ack_w,
    output reg test_set_to_input
);

wire [`T_D_WIDTH-1:0] test_data_n;
wire [`T_D_WIDTH-1:0] test_data_e;
wire [`T_D_WIDTH-1:0] test_data_s;
wire [`T_D_WIDTH-1:0] test_data_w;

wire test_ivalid_n;
assign test_ivalid_n = test_data_n ? 1'b1 : 1'b0;
wire test_ivalid_e;
assign test_ivalid_e = test_data_e ? 1'b1 : 1'b0;
wire test_ivalid_s;
assign test_ivalid_s = test_data_s ? 1'b1 : 1'b0;
wire test_ivalid_w;
assign test_ivalid_w = test_data_w ? 1'b1 : 1'b0;

//所有和detect有關的線
wire border_set_to_input;
wire router_status;
wire nb_f;
wire [`F_NODE-1:0] faulty_node;
wire [5:0] up;
wire [5:0] down;
wire [5:0] left;
wire [5:0] right;
detect #(WIDTHX,WIDTHY)detect0(
    .clk(clk),
    .reset(reset),

    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    //input
    .test_data_n_in(test_set_to_input ? idata_0 : `T_D_WIDTH'b0),
    .test_data_e_in(test_set_to_input ? idata_1 : `T_D_WIDTH'b0),
    .test_data_s_in(test_set_to_input ? idata_2 : `T_D_WIDTH'b0),
    .test_data_w_in(test_set_to_input ? idata_3 : `T_D_WIDTH'b0),
    //testmode
    .test_set(test_set_to_input),
    //bordermode
    .border_set(border_set_to_input),
    //receiving 
    .ack_n_in(test_ack_n_in),
    .ack_e_in(test_ack_e_in),
    .ack_s_in(test_ack_s_in),
    .ack_w_in(test_ack_w_in),
    //if get the test_data then giving the ack output back
    .ack_n(test_ack_n),
    .ack_e(test_ack_e),
    .ack_s(test_ack_s),
    .ack_w(test_ack_w),
    .status(router_status),
    //input for faulty_node correction
    .n_faulty(n_faulty),
    .e_faulty(e_faulty),
    .s_faulty(s_faulty),
    .w_faulty(w_faulty),
    .faulty_node(faulty_to_out),
    //output for rtcomp's using
    .nb_f(nb_f),
    .faulty_node_inverter_out(faulty_node),
    .up(up),
    .down(down),
    .left(left),
    .right(right),
    //test_data output for other node through the router
    .test_data_n(test_data_n),
    .test_data_e(test_data_e),
    .test_data_s(test_data_s),
    .test_data_w(test_data_w)
);

wire [`PORT-1:0]        cb_grt_0;
wire [`PORT_NUM-1:0]    ic_port_0;
wire                    ic_req_0;
wire [`DATA_WIDTH-1:0]  ic_odata_0;
wire                    ic_ovalid_0;
wire [`VCH_WIDTH_NUM - 1:0] ic_ovch_0;

inputc #( ROUTERID,0) input_unit0(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_set_to_input),
    .border_mode(border_set_to_input),
    
    .nb_f(nb_f),
    .faulty_node(faulty_node),
    .up(up),
    .down(down),
    .left(left),
    .right(right),

    // to / from other node
    .idata(test_data_n ? test_data_n : idata_0),
    .ivalid(test_data_n ? test_ivalid_n : ivalid_0),
    .ivch(test_data_n ? test_data_n[`VCH_MSB:`VCH_LSB]: ivch_0),
    .oack(oack_0),
    .ordy(ordy_0),
    .olck(olck_0),

    //from outputc 每個outputc會回傳給inputc其每個出口之virtual channal 的狀態
    .irdy_0(oc_ordy_0),
    .irdy_1(oc_ordy_1),
    .irdy_2(oc_ordy_2),
    .irdy_3(oc_ordy_3),
    .irdy_4(oc_ordy_4),
    .ilck_0(oc_olck_0),
    .ilck_1(oc_olck_1),
    .ilck_2(oc_olck_2),
    .ilck_3(oc_olck_3),
    .ilck_4(oc_olck_4),
    
    // to / from cb
    .grt(cb_grt_0),
    .req(ic_req_0),
    .port(ic_port_0),
    .ovalid(ic_ovalid_0),
    .ovch(ic_ovch_0),
    .odata(ic_odata_0)
);

wire [`PORT-1:0]        cb_grt_1;
wire [`PORT_NUM-1:0]    ic_port_1;
wire                    ic_req_1;
wire [`DATA_WIDTH-1:0]  ic_odata_1;
wire                    ic_ovalid_1;
wire [`VCH_WIDTH_NUM - 1:0] ic_ovch_1;

inputc #( ROUTERID,1) input_unit1(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_set_to_input),
    .border_mode(border_set_to_input),

    .nb_f(nb_f),
    .faulty_node(faulty_node),
    .up(up),
    .down(down),
    .left(left),
    .right(right),
    
    // to / from other node
    .idata(test_data_e ? test_data_e : idata_1),
    //reset == 0 ? test_data : idata_1
    .ivalid(test_data_e ? test_ivalid_e : ivalid_1),
    .ivch(test_data_e ? test_data_e[`VCH_MSB:`VCH_LSB] : ivch_1),
    .oack(oack_1),
    .ordy(ordy_1),
    .olck(olck_1),

    //from outputc 每個outputc會回傳給inputc其每個出口之virtual channal 的狀態
    .irdy_0(oc_ordy_0),
    .irdy_1(oc_ordy_1),
    .irdy_2(oc_ordy_2),
    .irdy_3(oc_ordy_3),
    .irdy_4(oc_ordy_4),
    .ilck_0(oc_olck_0),
    .ilck_1(oc_olck_1),
    .ilck_2(oc_olck_2),
    .ilck_3(oc_olck_3),
    .ilck_4(oc_olck_4),
    
    // to / from cb
    .grt(cb_grt_1),
    .req(ic_req_1),
    .port(ic_port_1),
    .ovalid(ic_ovalid_1),
    .ovch(ic_ovch_1),
    .odata(ic_odata_1)    
);

wire [`PORT-1:0]        cb_grt_2;
wire [`PORT_NUM-1:0]    ic_port_2;
wire                    ic_req_2;
wire [`DATA_WIDTH-1:0]  ic_odata_2;
wire                    ic_ovalid_2;
wire [`VCH_WIDTH_NUM - 1:0] ic_ovch_2;

inputc #( ROUTERID,2) input_unit2(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_set_to_input),
    .border_mode(border_set_to_input),

    .nb_f(nb_f),
    .faulty_node(faulty_node),
    .up(up),
    .down(down),
    .left(left),
    .right(right),

    // to / from other node
    .idata(test_data_s ? test_data_s : idata_2),
    .ivalid(test_data_s ? test_ivalid_s : ivalid_2),
    .ivch(test_data_s ? test_data_s[`VCH_MSB:`VCH_LSB] : ivch_2),
    .oack(oack_2),
    .ordy(ordy_2),
    .olck(olck_2),

    //from outputc 每個outputc會回傳給inputc其每個出口之virtual channal 的狀態
    .irdy_0(oc_ordy_0),
    .irdy_1(oc_ordy_1),
    .irdy_2(oc_ordy_2),
    .irdy_3(oc_ordy_3),
    .irdy_4(oc_ordy_4),
    .ilck_0(oc_olck_0),
    .ilck_1(oc_olck_1),
    .ilck_2(oc_olck_2),
    .ilck_3(oc_olck_3),
    .ilck_4(oc_olck_4),
    
    // to / from cb
    .grt(cb_grt_2),
    .req(ic_req_2),
    .port(ic_port_2),
    .ovalid(ic_ovalid_2),
    .ovch(ic_ovch_2),
    .odata(ic_odata_2)    
);

wire [`PORT-1:0]        cb_grt_3;
wire [`PORT_NUM-1:0]    ic_port_3;
wire                    ic_req_3;
wire [`DATA_WIDTH-1:0]  ic_odata_3;
wire                    ic_ovalid_3;
wire [`VCH_WIDTH_NUM - 1:0] ic_ovch_3;

inputc #( ROUTERID,3) input_unit3(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_set_to_input),
    .border_mode(border_set_to_input),

    .nb_f(nb_f),
    .faulty_node(faulty_node),
    .up(up),
    .down(down),
    .left(left),
    .right(right),
    
    // to / from other node
    .idata(test_data_w ? test_data_w : idata_3),
    .ivalid(test_data_w ? test_ivalid_w : ivalid_3),
    .ivch(test_data_w ? test_data_w[`VCH_MSB:`VCH_LSB] :ivch_3),
    .oack(oack_3),
    .ordy(ordy_3),
    .olck(olck_3),

    //from outputc 每個outputc會回傳給inputc其每個出口之virtual channal 的狀態
    .irdy_0(oc_ordy_0),
    .irdy_1(oc_ordy_1),
    .irdy_2(oc_ordy_2),
    .irdy_3(oc_ordy_3),
    .irdy_4(oc_ordy_4),
    .ilck_0(oc_olck_0),
    .ilck_1(oc_olck_1),
    .ilck_2(oc_olck_2),
    .ilck_3(oc_olck_3),
    .ilck_4(oc_olck_4),
    
    // to / from cb
    .grt(cb_grt_3),
    .req(ic_req_3),
    .port(ic_port_3),
    .ovalid(ic_ovalid_3),
    .ovch(ic_ovch_3),
    .odata(ic_odata_3)    
);

wire [`PORT-1:0]        cb_grt_4;
wire [`PORT_NUM-1:0]    ic_port_4;
wire                    ic_req_4;
wire [`DATA_WIDTH-1:0]  ic_odata_4;
wire                    ic_ovalid_4;
wire [`VCH_WIDTH_NUM - 1:0] ic_ovch_4;

inputc #( ROUTERID,4) input_unit4(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_set_to_input),
    .border_mode(border_set_to_input),

    .nb_f(nb_f),
    .faulty_node(faulty_node),
    .up(up),
    .down(down),
    .left(left),
    .right(right),
    
    // to / from other node
    .idata(test_set_to_input == 1'b1 || border_set_to_input == 1'b1 ? `DATA_WIDTH'b0 : idata_4),
    .ivalid(ivalid_4),
    .ivch(ivch_4),
    .oack(oack_4),
    .ordy(ordy_4),
    .olck(olck_4),

    //from outputc 每個outputc會回傳給inputc其每個出口之virtual channal 的狀態
    .irdy_0(oc_ordy_0),
    .irdy_1(oc_ordy_1),
    .irdy_2(oc_ordy_2),
    .irdy_3(oc_ordy_3),
    .irdy_4(oc_ordy_4),
    .ilck_0(oc_olck_0),
    .ilck_1(oc_olck_1),
    .ilck_2(oc_olck_2),
    .ilck_3(oc_olck_3),
    .ilck_4(oc_olck_4),
    
    // to / from cb
    .grt(cb_grt_4),
    .req(ic_req_4),
    .port(ic_port_4),
    .ovalid(ic_ovalid_4),
    .ovch(ic_ovch_4),
    .odata(ic_odata_4)    
);

wire [`DATA_WIDTH-1:0] cb_odata_0;
wire [`DATA_WIDTH-1:0] cb_odata_1;
wire [`DATA_WIDTH-1:0] cb_odata_2;
wire [`DATA_WIDTH-1:0] cb_odata_3;
wire [`DATA_WIDTH-1:0] cb_odata_4;

wire cb_ovalid_0;
wire cb_ovalid_1;
wire cb_ovalid_2;
wire cb_ovalid_3;
wire cb_ovalid_4;

wire [`VCH_WIDTH_NUM - 1:0] cb_ovch_0;
wire [`VCH_WIDTH_NUM - 1:0] cb_ovch_1;
wire [`VCH_WIDTH_NUM - 1:0] cb_ovch_2;
wire [`VCH_WIDTH_NUM - 1:0] cb_ovch_3;
wire [`VCH_WIDTH_NUM - 1:0] cb_ovch_4;

cb cb(
    .clk(clk),
    .reset(reset),

    //to / from ic 0
    .idata_0(ic_odata_0),
    .ivalid_0(ic_ovalid_0),
    .ivch_0(ic_ovch_0),
    .port_0(ic_port_0),
    .req_0(ic_req_0),
    .grt_0(cb_grt_0),

    //to / from ic 1
    .idata_1(ic_odata_1),
    .ivalid_1(ic_ovalid_1),
    .ivch_1(ic_ovch_1),
    .port_1(ic_port_1),
    .req_1(ic_req_1),
    .grt_1(cb_grt_1),

    //to / from ic 2
    .idata_2(ic_odata_2),
    .ivalid_2(ic_ovalid_2),
    .ivch_2(ic_ovch_2),
    .port_2(ic_port_2),
    .req_2(ic_req_2),
    .grt_2(cb_grt_2),

    //to / from ic 3
    .idata_3(ic_odata_3),
    .ivalid_3(ic_ovalid_3),
    .ivch_3(ic_ovch_3),
    .port_3(ic_port_3),
    .req_3(ic_req_3),
    .grt_3(cb_grt_3),

    //to / from ic 4
    .idata_4(ic_odata_4),
    .ivalid_4(ic_ovalid_4),
    .ivch_4(ic_ovch_4),
    .port_4(ic_port_4),
    .req_4(ic_req_4),
    .grt_4(cb_grt_4),

    // to oc 0
    .odata_0(cb_odata_0),
    .ovalid_0(cb_ovalid_0),
    .ovch_0(cb_ovch_0),

    // to oc 1
    .odata_1(cb_odata_1),
    .ovalid_1(cb_ovalid_1),
    .ovch_1(cb_ovch_1),

    // to oc 2
    .odata_2(cb_odata_2),
    .ovalid_2(cb_ovalid_2),
    .ovch_2(cb_ovch_2),

    // to oc 3
    .odata_3(cb_odata_3),
    .ovalid_3(cb_ovalid_3),
    .ovch_3(cb_ovch_3),

    // to oc 4
    .odata_4(cb_odata_4),
    .ovalid_4(cb_ovalid_4),
    .ovch_4(cb_ovch_4)
);

wire [`VCH_WIDTH-1 : 0] oc_ordy_0;
wire [`VCH_WIDTH-1 : 0] oc_olck_0;

outputc #(ROUTERID,0) output_unit0(
    .clk(clk),
    .reset(reset),
    
    //from cb
    .idata(cb_odata_0),
    .ivalid(cb_ovalid_0),
    .ivch(cb_ovch_0),
    
    //from other node
    .iack(iack_0),
    .ilck(ilck_0),
    
    //to 各個 inputc.v
    .olck(oc_olck_0),
    .ordy(oc_ordy_0),

    //to other node
    .odata(odata_0),
    .ovalid(ovalid_0),
    .ovch(ovch_0) 
);

wire [`VCH_WIDTH-1 : 0] oc_ordy_1;
wire [`VCH_WIDTH-1 : 0] oc_olck_1;

outputc #(ROUTERID,1) output_unit1(
    .clk(clk),
    .reset(reset),
    
    //from cb
    .idata(cb_odata_1),
    .ivalid(cb_ovalid_1),
    .ivch(cb_ovch_1),
    
    //from other node
    .iack(iack_1),
    .ilck(ilck_1),
    
    //to 各個 inputc.v
    .olck(oc_olck_1),
    .ordy(oc_ordy_1),

    //to other node
    .odata(odata_1),
    .ovalid(ovalid_1),
    .ovch(ovch_1) 
);

wire [`VCH_WIDTH-1 : 0] oc_ordy_2;
wire [`VCH_WIDTH-1 : 0] oc_olck_2;

outputc #(ROUTERID,2) output_unit2(
    .clk(clk),
    .reset(reset),
    
    //from cb
    .idata(cb_odata_2),
    .ivalid(cb_ovalid_2),
    .ivch(cb_ovch_2),
    
    //from other node
    .iack(iack_2),
    .ilck(ilck_2),
    
    //to 各個 inputc.v
    .olck(oc_olck_2),
    .ordy(oc_ordy_2),

    //to other node
    .odata(odata_2),
    .ovalid(ovalid_2),
    .ovch(ovch_2)    
);

wire [`VCH_WIDTH-1 : 0] oc_ordy_3;
wire [`VCH_WIDTH-1 : 0] oc_olck_3;

outputc #(ROUTERID,3) output_unit3(
    .clk(clk),
    .reset(reset),
    
    //from cb
    .idata(cb_odata_3),
    .ivalid(cb_ovalid_3),
    .ivch(cb_ovch_3),
    
    //from other node
    .iack(iack_3),
    .ilck(ilck_3),
    
    //to 各個 inputc.v
    .olck(oc_olck_3),
    .ordy(oc_ordy_3),

    //to other node
    .odata(odata_3),
    .ovalid(ovalid_3),
    .ovch(ovch_3)    
);

wire [`VCH_WIDTH-1 : 0] oc_ordy_4;
wire [`VCH_WIDTH-1 : 0] oc_olck_4;

outputc #(ROUTERID,4) output_unit4(
    .clk(clk),
    .reset(reset),
    
    //from cb
    .idata(cb_odata_4),
    .ivalid(cb_ovalid_4),
    .ivch(cb_ovch_4),
    
    //from other node
    .iack(iack_4),
    .ilck(ilck_4),
    
    //to 各個 inputc.v
    .olck(oc_olck_4),
    .ordy(oc_ordy_4),

    //to other node
    .odata(odata_4),
    .ovalid(ovalid_4),
    .ovch(ovch_4)    
);
endmodule