`include "defines.v"
module inputc #(parameter  ROUTERID = 0 , parameter  PCHID = 0)(
    input wire clk,
    input wire reset,

    input wire [2:0] my_xpos,
    input wire [2:0] my_ypos,
    input wire test_mode,
    input wire border_mode,
    
    input wire nb_f,
    input wire [`F_NODE - 1 : 0] faulty_node,
    input wire [5:0]            up,
    input wire [5:0]            down,
    input wire [5:0]            left,
    input wire [5:0]            right,

    //
    //to / from other node //physical channel
    input wire [`DATA_WIDTH-1:0]idata,
    input wire ivalid,
    input wire [`VCH_WIDTH_NUM - 1:0]ivch,
    output reg [`VCH_WIDTH-1:0]oack,
    output reg [`VCH_WIDTH-1:0]ordy,
    output reg [`VCH_WIDTH-1:0]olck,

    //from outputc 每個outputc會回傳給inputc其每個出口之virtual channal 的狀態
    input wire [`VCH_WIDTH-1 : 0] irdy_0,
    input wire [`VCH_WIDTH-1 : 0] irdy_1,
    input wire [`VCH_WIDTH-1 : 0] irdy_2,
    input wire [`VCH_WIDTH-1 : 0] irdy_3,
    input wire [`VCH_WIDTH-1 : 0] irdy_4,
    input wire [`VCH_WIDTH-1 : 0] ilck_0,
    input wire [`VCH_WIDTH-1 : 0] ilck_1,
    input wire [`VCH_WIDTH-1 : 0] ilck_2,
    input wire [`VCH_WIDTH-1 : 0] ilck_3,
    input wire [`VCH_WIDTH-1 : 0] ilck_4,

    //to / from cb
    input wire [4:0] grt,
    output reg req,
    output reg [`PORT_NUM-1:0] port,
    output reg ovalid,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch,
    output reg [`DATA_WIDTH-1:0] odata

);

/*vc0中的所有變數*/
wire [`DATA_WIDTH-1 : 0] buf_data0; //從fifo出來的資料
wire [2:0] btype0;
wire [`PORT_NUM-1:0] port0;
wire [`VCH_WIDTH_NUM - 1:0] ovch0;

/*vc1中的所有變數*/
wire [`DATA_WIDTH-1 : 0] buf_data1;
wire [2:0] btype1;
wire [`PORT_NUM-1:0] port1;
wire [`VCH_WIDTH_NUM - 1:0] ovch1;

/*vc2中的所有變數*/
wire [`DATA_WIDTH-1 : 0] buf_data2; //從fifo出來的資料
wire [2:0] btype2;
wire [`PORT_NUM-1:0] port2;
wire [`VCH_WIDTH_NUM - 1:0] ovch2;

/*vc3中的所有變數*/
wire [`DATA_WIDTH-1 : 0] buf_data3; //從fifo出來的資料
wire [2:0] btype3;
wire [`PORT_NUM-1:0] port3;
wire [`VCH_WIDTH_NUM - 1:0] ovch3;



/*內含 1. fifo *2 2. virtual channel *2 3. rtcomp * 2 4. vcmux 5. data transmission */
/* virtual channel mux */
wire [3:0] vcsel;

wire [`DATA_WIDTH-1:0] odata0;
wire [`DATA_WIDTH-1:0] odata1;
wire [`DATA_WIDTH-1:0] odata2;
wire [`DATA_WIDTH-1:0] odata3;


assign odata0 = (send0 && btype0 != `TYPE_NONE) ? buf_data0 : `DATA_WIDTH'b0;
assign odata1 = (send1 && btype1 != `TYPE_NONE) ? buf_data1 : `DATA_WIDTH'b0;
assign odata2 = (send2 && btype2 != `TYPE_NONE) ? buf_data2 : `DATA_WIDTH'b0;
assign odata3 = (send3 && btype3 != `TYPE_NONE) ? buf_data3 : `DATA_WIDTH'b0;


wire ovalid0,ovalid1,ovalid2,ovalid3;
assign ovalid0 = (send0 && btype0 != `TYPE_NONE);
assign ovalid1 = (send1 && btype1 != `TYPE_NONE);
assign ovalid2 = (send2 && btype2 != `TYPE_NONE);
assign ovalid3 = (send3 && btype3 != `TYPE_NONE);


vcmux vcmux(
    .clk(clk),
    .reset(reset),
    //vc0
    .ivalid0(ovalid0),
    .ivch0(ovch0),
    .idata0(odata0),
    .port0(port0),
    .req0(req0),
    //vc1
    .ivalid1(ovalid1),
    .ivch1(ovch1),
    .idata1(odata1),
    .port1(port1),
    .req1(req1),
    //vc2
    .ivalid2(ovalid2),
    .ivch2(ovch2),
    .idata2(odata2),
    .port2(port2),
    .req2(req2),
    //vc3
    .ivalid3(ovalid3),
    .ivch3(ovch3),
    .idata3(odata3),
    .port3(port3),
    .req3(req3),
    
    //to cb
    .ovalid(ovalid),
    .ovch(ovch),
    .odata(odata),
    .port(port),
    .req(req),
    .vcsel(vcsel)
);

/* virtual channel */
wire send0;
wire send1;
wire send2;
wire send3;

assign  oack[0]        = send0;
assign  oack[1]        = send1;
assign  oack[2]        = send2;
assign  oack[3]        = send3;

wire req0;
wire req1;
wire req2;
wire req3;

vc #(ROUTERID, PCHID ,0) vc0(
    .clk(clk),
    .reset(reset),

    .idata(buf_data0),
    .send(send0),

    .olck(olck[0]),

    .irdy_0(irdy_0),
    .irdy_1(irdy_1),
    .irdy_2(irdy_2),
    .irdy_3(irdy_3),
    .irdy_4(irdy_4),
    .ilck_0(ilck_0),
    .ilck_1(ilck_1),
    .ilck_2(ilck_2),
    .ilck_3(ilck_3),
    .ilck_4(ilck_4),

    .grt_0(vcsel[0] ? grt[0] : 0),
    .grt_1(vcsel[0] ? grt[1] : 0),
    .grt_2(vcsel[0] ? grt[2] : 0),
    .grt_3(vcsel[0] ? grt[3] : 0),
    .grt_4(vcsel[0] ? grt[4] : 0),

    .port(port0),
    .ovch(ovch0),//in

    .req(req0) // to vcmux
);

vc #(ROUTERID, PCHID ,0) vc1(
    .clk(clk),
    .reset(reset),

    .idata(buf_data1),
    .send(send1),

    .olck(olck[1]),

    .irdy_0(irdy_0),
    .irdy_1(irdy_1),
    .irdy_2(irdy_2),
    .irdy_3(irdy_3),
    .irdy_4(irdy_4),
    .ilck_0(ilck_0),
    .ilck_1(ilck_1),
    .ilck_2(ilck_2),
    .ilck_3(ilck_3),
    .ilck_4(ilck_4),

    .grt_0(vcsel[1] ? grt[0] : 0),
    .grt_1(vcsel[1] ? grt[1] : 0),
    .grt_2(vcsel[1] ? grt[2] : 0),
    .grt_3(vcsel[1] ? grt[3] : 0),
    .grt_4(vcsel[1] ? grt[4] : 0),

    .port(port1),
    .ovch(ovch1),

    .req(req1) // to vcmux
);

vc #(ROUTERID, PCHID ,0) vc2(
    .clk(clk),
    .reset(reset),

    .idata(buf_data2),
    .send(send2),

    .olck(olck[2]),

    .irdy_0(irdy_0),
    .irdy_1(irdy_1),
    .irdy_2(irdy_2),
    .irdy_3(irdy_3),
    .irdy_4(irdy_4),
    .ilck_0(ilck_0),
    .ilck_1(ilck_1),
    .ilck_2(ilck_2),
    .ilck_3(ilck_3),
    .ilck_4(ilck_4),

    .grt_0(vcsel[2] ? grt[0] : 0),
    .grt_1(vcsel[2] ? grt[1] : 0),
    .grt_2(vcsel[2] ? grt[2] : 0),
    .grt_3(vcsel[2] ? grt[3] : 0),
    .grt_4(vcsel[2] ? grt[4] : 0),

    .port(port2),
    .ovch(ovch2),

    .req(req2) // to vcmux
);

vc #(ROUTERID, PCHID ,0) vc3(
    .clk(clk),
    .reset(reset),

    .idata(buf_data3),
    .send(send3),

    .olck(olck[3]),

    .irdy_0(irdy_0),
    .irdy_1(irdy_1),
    .irdy_2(irdy_2),
    .irdy_3(irdy_3),
    .irdy_4(irdy_4),
    .ilck_0(ilck_0),
    .ilck_1(ilck_1),
    .ilck_2(ilck_2),
    .ilck_3(ilck_3),
    .ilck_4(ilck_4),

    .grt_0(vcsel[3] ? grt[0] : 0),
    .grt_1(vcsel[3] ? grt[1] : 0),
    .grt_2(vcsel[3] ? grt[2] : 0),
    .grt_3(vcsel[3] ? grt[3] : 0),
    .grt_4(vcsel[3] ? grt[4] : 0),

    .port(port3),
    .ovch(ovch3),

    .req(req3) // to vcmux
);

/* routing computation */

assign btype0 = buf_data0 [`TYPE_MSB:`TYPE_LSB];
assign btype1 = buf_data1 [`TYPE_MSB:`TYPE_LSB];
assign btype2 = buf_data2 [`TYPE_MSB:`TYPE_LSB];
assign btype3 = buf_data3 [`TYPE_MSB:`TYPE_LSB];

rtcomp rc0(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_mode),
    .border_mode(border_mode),
    .nb_f(test_mode ? 0 : nb_f),
    .up(test_mode ? 0 : up),
    .down(test_mode ? 0 : down),
    .left(test_mode ? 0 : left),
    .right(test_mode ? 0 : right),
    .faulty_node((test_mode && (!border_mode))? 8'b00000000 : faulty_node),
    // .nb_f(1'b1),
    // .up(6'b001011),
    // .down(6'b110100),
    // .left(6'b010001),
    // .right(6'b011110),
    // .faulty_node(8'b00001110),
    
    .dst_addr(buf_data0 [`DST_MSB : `DST_LSB]),
    .ivch(buf_data0 [`VCH_MSB : `VCH_LSB]),
    .en(btype0 == `TYPE_HEAD || btype0 == `TYPE_HEADTAIL || btype0 == `TYPE_TEST || btype0 == `TYPE_ACK || btype0 == `TYPE_ACK_BACK),

    .port(port0), //to vc / vcmux
    .ovch(ovch0) // to vc / vcmux
);

rtcomp rc1(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_mode),
    .border_mode(border_mode),
    .nb_f(test_mode ? 0 : nb_f),
    .up(test_mode ? 0 : up),
    .down(test_mode ? 0 : down),
    .left(test_mode ? 0 : left),
    .right(test_mode ? 0 : right),
    .faulty_node((test_mode && (!border_mode))? 8'b00000000 : faulty_node),
    // .nb_f(1'b1),
    // .up(6'b001011),
    // .down(6'b110100),
    // .left(6'b010001),
    // .right(6'b011110),
    // .faulty_node(8'b00001110),

    .dst_addr(buf_data1 [`DST_MSB : `DST_LSB]),
    .ivch(buf_data1 [`VCH_MSB : `VCH_LSB]),
    .en(btype1 == `TYPE_HEAD || btype1 == `TYPE_HEADTAIL || btype1 == `TYPE_TEST || btype1 == `TYPE_ACK || btype1 == `TYPE_ACK_BACK),

    .port(port1),
    .ovch(ovch1)
);

rtcomp rc2(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_mode),
    .border_mode(border_mode),
    .nb_f(test_mode ? 0 : nb_f),
    .up(test_mode ? 0 : up),
    .down(test_mode ? 0 : down),
    .left(test_mode ? 0 : left),
    .right(test_mode ? 0 : right),
    .faulty_node((test_mode && (!border_mode))? 8'b00000000 : faulty_node),
    // .nb_f(1'b1),
    // .up(6'b001011),
    // .down(6'b110100),
    // .left(6'b010001),
    // .right(6'b011110),
    // .faulty_node(8'b00001110),

    .dst_addr(buf_data2 [`DST_MSB : `DST_LSB]),
    .ivch(buf_data2 [`VCH_MSB : `VCH_LSB]),
    .en(btype2 == `TYPE_HEAD || btype2 == `TYPE_HEADTAIL || btype2 == `TYPE_TEST || btype2 == `TYPE_ACK || btype2 == `TYPE_ACK_BACK),

    .port(port2),
    .ovch(ovch2)
);

rtcomp rc3(
    .clk(clk),
    .reset(reset),
    
    .my_xpos(my_xpos),
    .my_ypos(my_ypos),
    .test_mode(test_mode),
    .border_mode(border_mode),
    .nb_f(test_mode ? 0 : nb_f),
    .up(test_mode ? 0 : up),
    .down(test_mode ? 0 : down),
    .left(test_mode ? 0 : left),
    .right(test_mode ? 0 : right),
    .faulty_node((test_mode && (!border_mode))? 8'b00000000 : faulty_node),
    // .nb_f(1'b1),
    // .up(6'b001011),
    // .down(6'b110100),
    // .left(6'b010001),
    // .right(6'b011110),
    // .faulty_node(8'b00001110),

    .dst_addr(buf_data3 [`DST_MSB : `DST_LSB]),
    .ivch(buf_data3 [`VCH_MSB : `VCH_LSB]),
    .en(btype3 == `TYPE_HEAD || btype3 == `TYPE_HEADTAIL || btype3 == `TYPE_TEST || btype3 == `TYPE_ACK || btype3 == `TYPE_ACK_BACK),

    .port(port3),
    .ovch(ovch3)
);

/* input buffer */

fifo buf0(
    .clk(clk),
    .reset(reset),

    .idata(ivch == 0 ? idata : `DATA_WIDTH'b0),
    .wr_en(ivch == 0 ? ivalid : 0),
    .rd_en(send0), // from vc

    .ordy(ordy[0]),
    .odata(buf_data0)
);

fifo buf1(
    .clk(clk),
    .reset(reset),

    .idata(ivch == 1 ? idata : `DATA_WIDTH'b0),
    .wr_en(ivch == 1 ? ivalid : 0),
    .rd_en(send1), // from vc

    .ordy(ordy[1]),
    .odata(buf_data1)
);

fifo buf2(
    .clk(clk),
    .reset(reset),

    .idata(ivch == 2 ? idata : `DATA_WIDTH'b0),
    .wr_en(ivch == 2 ? ivalid : 0),
    .rd_en(send2), // from vc

    .ordy(ordy[2]),
    .odata(buf_data2)
);

fifo buf3(
    .clk(clk),
    .reset(reset),

    .idata(ivch == 3 ? idata : `DATA_WIDTH'b0),
    .wr_en(ivch == 3 ? ivalid : 0),
    .rd_en(send3), // from vc

    .ordy(ordy[3]),
    .odata(buf_data3)
);

endmodule