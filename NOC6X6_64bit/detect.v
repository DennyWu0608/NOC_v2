`include "defines.v"
module detect #(parameter WIDTHX = 0, parameter WIDTHY = 0)(
    input wire clk,
    input wire reset,
    //要傳入自己這一顆router的座標位置
    input signed [3:0] my_xpos,
    input signed [3:0] my_ypos,

    input wire [`T_D_WIDTH-1:0] test_data_n_in,
    input wire [`T_D_WIDTH-1:0] test_data_e_in,
    input wire [`T_D_WIDTH-1:0] test_data_s_in,
    input wire [`T_D_WIDTH-1:0] test_data_w_in,

    input wire ack_n_in,
    input wire ack_e_in,
    input wire ack_s_in,
    input wire ack_w_in,

    output reg test_set,
    output reg border_set,
    //收到test_data_X_in的回覆信號
    output reg ack_n,
    output reg ack_e,
    output reg ack_s,
    output reg ack_w,

    output reg status,

    //確認是否為8鄰居有壞掉的 傳給rtcomp
    input wire [`F_NODE-1:0] n_faulty,
    input wire [`F_NODE-1:0] e_faulty,
    input wire [`F_NODE-1:0] s_faulty,
    input wire [`F_NODE-1:0] w_faulty,
    output reg nb_f,
    output reg [`F_NODE - 1 : 0] faulty_node,
    output reg [`F_NODE-1:0] faulty_node_inverter_out,
    output reg [5:0]            up,
    output reg [5:0]            down,
    output reg [5:0]            left,
    output reg [5:0]            right,



    //給自己的input測試用data 
    output reg [`T_D_WIDTH-1:0] test_data_n,
    //output reg [`T_D_WIDTH-1:0] test_data_ne,
    output reg [`T_D_WIDTH-1:0] test_data_e,
    //output reg [`T_D_WIDTH-1:0] test_data_es,
    output reg [`T_D_WIDTH-1:0] test_data_s,
    //output reg [`T_D_WIDTH-1:0] test_data_sw,
    output reg [`T_D_WIDTH-1:0] test_data_w
    //output reg [`T_D_WIDTH-1:0] test_data_wn
);

assign status = (ack_n_got && ack_e_got && ack_s_got && ack_w_got) ? 1'b1 : 1'b0;


assign ack_n = (test_data_n_in[`TYPE_MSB:`TYPE_LSB] == 3'b111) && (test_data_n_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_n_in[`DSTX_MSB:`DSTX_LSB] == my_xpos) ? 1'b1 : 1'b0;
assign ack_e = (test_data_e_in[`TYPE_MSB:`TYPE_LSB] == 3'b111) && (test_data_e_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_e_in[`DSTX_MSB:`DSTX_LSB] == my_xpos) ? 1'b1 : 1'b0;
assign ack_s = (test_data_s_in[`TYPE_MSB:`TYPE_LSB] == 3'b111) && (test_data_s_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_s_in[`DSTX_MSB:`DSTX_LSB] == my_xpos) ? 1'b1 : 1'b0;
assign ack_w = (test_data_w_in[`TYPE_MSB:`TYPE_LSB] == 3'b111) && (test_data_w_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_w_in[`DSTX_MSB:`DSTX_LSB] == my_xpos) ? 1'b1 : 1'b0;

/* 
 * data width 
 *   34 33 32         31 ~ 14     13  12 ---  11 10 9 8 7 6  5 4 3  2 1 0
 * --3 bit type----18 bit data----  vc  ---   `define NUM_NODE 2
`define F_NODE 8
`define T_D_WIDTH 35SRC_Y   SRC_X   DST_Y   DST_X
 */

/* FSM state */  //000 001 010 011 100
`define TD_STATE  3'b000  
`define ACK_STATE 3'b001  
//`define WAIT_FOR_NEXT 3'b010
`define FINISH_STATE  3'b011
`define CHECK_BORDER 3'b100  

reg  [2:0] state;
// reg  [1:0] data_count;
// assign data_count[0] = (faulty_check_e[0] && faulty_check_n[0] && faulty_check_s[0] && faulty_check_w[0]);
// assign data_count[1] = (faulty_check_e[1] && faulty_check_n[1] && faulty_check_s[1] && faulty_check_w[1]);


//TD 6 clk ACK 70 - 7 = 63 BORDER 129 - 81 = 48
always @(posedge clk) begin
    if (reset == 0) begin
        state <= `TD_STATE;
    end else begin
        case (state)
            `TD_STATE: begin
                if (counter >= 6) begin //status 6 clk
                    state <= `ACK_STATE;
                end else begin
                    state <= `TD_STATE;
                end
            end
            `ACK_STATE: begin
                if (counter < 76) begin //test_set 40 clk 60 clk
                    state <= `ACK_STATE;
                    border_set <= 1'b0;
                end else begin
                    state <= `CHECK_BORDER;
                    border_set <= 1'b1;
                end
            end
            `CHECK_BORDER: begin
                if (counter >= 76 && counter < (76 + ((((WIDTHX+WIDTHY)*2)-4)*6))) begin
                    state <= `CHECK_BORDER;    
                end else if (counter >= (76 + ((((WIDTHX+WIDTHY)*2)-4)*6))) begin ///用一個訊號來卡它 check_com == 1 則代表其已經回到傳送資料已經回到原點 又或者就用counter來計數
                    state <= `FINISH_STATE;
                    border_set <= 1'b0;
                end
            end
            `FINISH_STATE: begin
                if (counter >= (76 + ((((WIDTHX+WIDTHY)*2)-4)*6))) begin //test_set == 1'b1
                    state <= `FINISH_STATE;
                    border_set <= 1'b0;
                end else if (counter == 0)begin
                    state <= `TD_STATE;
                    border_set <= 1'b0;
                end else begin
                    state <= state;
                end
            end
            default: begin
                state <= state;
            end
        endcase
    end
end

reg [7:0] counter; //
//計數器
always @(posedge clk) begin
    if (reset == 0) begin
        counter <= 5'b0;
    end else begin
        if (test_set == 1'b1) begin
            counter <= counter + 1;
        end else if (test_set == 1'b0) begin
            counter <= counter;    
        end
    end
end

//計算測試時斷結束
always @(*) begin
    if (counter >= (76 + (((((WIDTHX+WIDTHY)*2)-4)*6))+10)) begin
        test_set = 1'b0;
    end else begin
        test_set = 1'b1;
    end
end

/* test orientation*/



// N 
wire signed [3:0] Nx;
wire signed [3:0] Ny;

// 如果y座標是負數則將Nx Ny設為高阻抗等同於斷路 ＝＝>表示其上面沒有router
assign Nx = ((my_ypos - 1) >= 0)?  my_xpos     : 3'bz;
assign Ny = ((my_ypos - 1) >= 0)? (my_ypos - 1): 3'bz;

// NE
wire signed [3:0] NEx;
wire signed [3:0] NEy;
assign NEx = ((my_ypos - 1) >= 0 && (my_xpos + 1) <= 5) ? (my_xpos + 1) : 3'bz; //parameter
assign NEy = ((my_ypos - 1) >= 0 && (my_xpos + 1) <= 5) ? (my_ypos - 1) : 3'bz;


/* 初始化標記為為發送狀態 */
reg self_detect_sent_n;
reg [1:0] faulty_check_n;

/* 控制訊號for border */
reg borderget;
reg [2:0] x_min_temp;
reg [2:0] y_min_temp;
reg [2:0] x_max_temp;
reg [2:0] y_max_temp;
reg first_border_sent;
bordercheck #(WIDTHX,WIDTHY) checking(
    .clk(clk),
    .reset(reset),
    .n_in(test_data_n_in),
    .e_in(test_data_e_in),
    .s_in(test_data_s_in),
    .w_in(test_data_w_in),
    .state(state),
    .my_x(my_xpos),
    .my_y(my_ypos),
    // .x_min_now(xy_array[0]),
    // .y_min_now(xy_array[1]),
    // .x_max_now(xy_array[2]),
    // .y_max_now(xy_array[3]),
    .x_min(x_min_temp),
    .y_min(y_min_temp),
    .x_max(x_max_temp),
    .y_max(y_max_temp),
    .get_border(borderget),
    .up(up),
    .down(down),
    .left(left),
    .right(right)
);
reg signed [3:0] temp_dst_x;
reg signed [3:0] temp_dst_y;
//為了border校正所使用的邏輯電路運算應該要去往那一個x y座標
always @(*) begin
    if (faulty_node_inverter_out[0] == 1'b1 && faulty_node_inverter_out[1] != 1'b1 && faulty_node_inverter_out[7] != 1'b1) begin
        temp_dst_x = my_xpos - 1;
        temp_dst_y = my_ypos;
    end else if (faulty_node_inverter_out[1] == 1'b1 && faulty_node_inverter_out[3] != 1'b1 && faulty_node_inverter_out[7] != 1'b1) begin
        temp_dst_x = my_xpos - 1;
        temp_dst_y = my_ypos;
    end else if (faulty_node_inverter_out[1] == 1'b1 && faulty_node_inverter_out[3] == 1'b1 && faulty_node_inverter_out[5] != 1'b1 && faulty_node_inverter_out[7] != 1'b1) begin
        temp_dst_x = my_xpos - 1;
        temp_dst_y = my_ypos;
    end else if (faulty_node_inverter_out[4] == 1'b1 && faulty_node_inverter_out[3] != 1'b1 && faulty_node_inverter_out[5] != 1'b1) begin
        temp_dst_x = my_xpos + 1;
        temp_dst_y = my_ypos;
    end else if (faulty_node_inverter_out[5] == 1'b1 && faulty_node_inverter_out[3] != 1'b1 && faulty_node_inverter_out[7] != 1'b1) begin
        temp_dst_x = my_xpos + 1;
        temp_dst_y = my_ypos;
    end else if (faulty_node_inverter_out[5] == 1'b1 && faulty_node_inverter_out[7] == 1'b1 && faulty_node_inverter_out[1] != 1'b1 && faulty_node_inverter_out[3] != 1'b1) begin
        temp_dst_x = my_xpos + 1;
        temp_dst_y = my_ypos;
    end else if (faulty_node_inverter_out[2] == 1'b1 && faulty_node_inverter_out[1] != 1'b1 && faulty_node_inverter_out[3] != 1'b1) begin
        temp_dst_x = my_xpos;
        temp_dst_y = my_ypos - 1;
    end else if (faulty_node_inverter_out[3] == 1'b1 && faulty_node_inverter_out[1] != 1'b1 && faulty_node_inverter_out[5] != 1'b1) begin
        temp_dst_x = my_xpos;
        temp_dst_y = my_ypos - 1;
    end else if (faulty_node_inverter_out[3] == 1'b1 && faulty_node_inverter_out[5] == 1'b1 && faulty_node_inverter_out[1] != 1'b1 && faulty_node_inverter_out[7] != 1'b1) begin
        temp_dst_x = my_xpos;
        temp_dst_y = my_ypos - 1;
    end else if (faulty_node_inverter_out[6] == 1'b1 && faulty_node_inverter_out[5] != 1'b1 && faulty_node_inverter_out[7] != 1'b1) begin
        temp_dst_x = my_xpos;
        temp_dst_y = my_ypos + 1;
    end else if (faulty_node_inverter_out[7] == 1'b1 && faulty_node_inverter_out[1] != 1'b1 && faulty_node_inverter_out[5] != 1'b1) begin
        temp_dst_x = my_xpos;
        temp_dst_y = my_ypos + 1;
    end else if (faulty_node_inverter_out[7] == 1'b1 && faulty_node_inverter_out[1] == 1'b1 && faulty_node_inverter_out[3] != 1'b1 && faulty_node_inverter_out[5] != 1'b1) begin
        temp_dst_x = my_xpos;
        temp_dst_y = my_ypos + 1;
    end 
end
//////////////////////////////////////////////////////////////////////
//test_data_n生成
//我們用test_data_n對於border_check來作發送資料的出口
always @(posedge clk) begin
    if (reset == 0) begin //所有其他模組工作 reset == 1
        test_data_n <= `T_D_WIDTH'b0;
        self_detect_sent_n <= 1'b0;
        faulty_check_n <= 2'b00;
        first_border_sent <= 1'b0;
    end else if (state == `TD_STATE) begin
        if (!self_detect_sent_n) begin
            if (Ny !== 3'bZ) begin //如果往上的Ny == my_ypos則代表其沒有上面節點
                test_data_n[`TYPE_MSB:`TYPE_LSB] <= 3'b111;
                test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_n[31:14] <= 18'b000000000000000000;
                test_data_n[`VCH_MSB:`VCH_LSB] <= 2'b00; //之後要看如何測試得所有的vc buffer
                test_data_n[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_n[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_n[`DSTY_MSB:`DSTY_LSB] <= Ny;
                test_data_n[`DSTX_MSB:`DSTX_LSB] <= Nx; 
                self_detect_sent_n <= 1'b1;
                faulty_check_n <= faulty_check_n;
            end else begin
                test_data_n <= `T_D_WIDTH'b0;
                self_detect_sent_n <= 1'b1;
                faulty_check_n <= faulty_check_n;
            end
        end else begin //self_detect_sent already
            test_data_n <= `T_D_WIDTH'b0;
            self_detect_sent_n <= self_detect_sent_n;
            faulty_check_n <= faulty_check_n;
        end
    end  else if (state == `ACK_STATE && status == 1'b1)begin
        if (faulty_check_n == 2'b00) begin
             if (Ny !== 3'bZ) begin 
                test_data_n[`TYPE_MSB:`TYPE_LSB] <= 3'b101;
                test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_n[31:14] <= 18'b100000000000000000;
                test_data_n[`VCH_MSB:`VCH_LSB] <= 2'b01;
                test_data_n[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_n[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_n[`DSTY_MSB:`DSTY_LSB] <= Ny;
                test_data_n[`DSTX_MSB:`DSTX_LSB] <= Nx;
                self_detect_sent_n <= self_detect_sent_n; 
                faulty_check_n <= 2'b01;
                //state <= `WAIT_FOR_NEXT;
            end else begin
                test_data_n <= `T_D_WIDTH'b0;
                self_detect_sent_n <= self_detect_sent_e;
                faulty_check_n <= 2'b01;
                faulty_node[1] = 1'b1;
            end
        end else if (faulty_check_n == 2'b01) begin
            if (NEx !== 3'bZ) begin
                test_data_n[`TYPE_MSB:`TYPE_LSB] <= 3'b101;
                test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_n[31:14] <= 18'b010000000000000000;
                test_data_n[`VCH_MSB:`VCH_LSB] <= 2'b10;
                test_data_n[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_n[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_n[`DSTY_MSB:`DSTY_LSB] <= NEy;
                test_data_n[`DSTX_MSB:`DSTX_LSB] <= NEx;
                self_detect_sent_n <= self_detect_sent_n; 
                faulty_check_n <= 2'b11;
                state <= state;
            end else begin
                test_data_n <= `T_D_WIDTH'b0;
                self_detect_sent_n <= self_detect_sent_e;
                faulty_check_n <= 2'b11;
                faulty_node[2] = 1'b1;
            end
        end else begin
            test_data_n <= `T_D_WIDTH'b0;
            self_detect_sent_n <= self_detect_sent_n;
            faulty_check_n <= faulty_check_n;
        end

        //////
        if ((test_data_n_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK) && (faulty_check_n == 2'b11) && (test_data_n_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_n_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
            if (test_data_n_in[28] == 1'b1) begin //SE 4
                //test_line <= 1'b1;
                test_data_n[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_n[31:14] <=  (status) ? 18'b000100000000010000 : 18'b000000000000000000;
                test_data_n[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_n[`SRCY_MSB:`SRCY_LSB] <=  test_data_n_in[`DSTY_MSB:`DSTY_LSB];
                test_data_n[`SRCX_MSB:`SRCX_LSB] <=  test_data_n_in[`DSTX_MSB:`DSTX_LSB];
                test_data_n[`DSTY_MSB:`DSTY_LSB] <=  test_data_n_in[`SRCY_MSB:`SRCY_LSB];
                test_data_n[`DSTX_MSB:`DSTX_LSB] <=  test_data_n_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_n <= self_detect_sent_n;
                faulty_check_n <= faulty_check_n;
            end else if (test_data_n_in[27] == 1'b1) begin //S 5
                test_data_n[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_n[31:14] <=  (status) ? 18'b000010000000100000 : 18'b000000000000000000;
                test_data_n[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_n[`SRCY_MSB:`SRCY_LSB] <=  test_data_n_in[`DSTY_MSB:`DSTY_LSB];
                test_data_n[`SRCX_MSB:`SRCX_LSB] <=  test_data_n_in[`DSTX_MSB:`DSTX_LSB];
                test_data_n[`DSTY_MSB:`DSTY_LSB] <=  test_data_n_in[`SRCY_MSB:`SRCY_LSB];
                test_data_n[`DSTX_MSB:`DSTX_LSB] <=  test_data_n_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_n <= self_detect_sent_n;
                faulty_check_n <= faulty_check_n;
            end
        end
    end else if (state == `CHECK_BORDER) begin
        if (nb_f && !first_border_sent) begin
            test_data_n[`TYPE_MSB:`TYPE_LSB] <= 3'b111;
            test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
            test_data_n[31:26] <= 6'b000000;
            test_data_n[25:23] <= my_xpos;
            test_data_n[22:20] <= my_ypos;
            test_data_n[19:17] <= my_xpos;
            test_data_n[16:14] <= my_ypos;
            test_data_n[`VCH_MSB:`VCH_LSB] <= 2'b00; 
            test_data_n[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
            test_data_n[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
            test_data_n[`DSTY_MSB:`DSTY_LSB] <= temp_dst_y;
            test_data_n[`DSTX_MSB:`DSTX_LSB] <= temp_dst_x; 
            self_detect_sent_n <= self_detect_sent_n;
            faulty_check_n <= faulty_check_n;
            first_border_sent <= 1'b1;
        end else if (nb_f && first_border_sent)begin
            if ((test_data_e_in || test_data_n_in || test_data_s_in || test_data_w_in) && (!borderget)) begin
                test_data_n[`TYPE_MSB:`TYPE_LSB] <= 3'b111;
                test_data_n[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_n[31:26] <= 6'b000000;
                test_data_n[25:23] <= x_min_temp;
                test_data_n[22:20] <= y_min_temp;
                test_data_n[19:17] <= x_max_temp;
                test_data_n[16:14] <= y_max_temp;
                test_data_n[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_n[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_n[`DSTY_MSB:`DSTY_LSB] <= temp_dst_y; // 如何設計讓其不要在繼續傳下去
                test_data_n[`DSTX_MSB:`DSTX_LSB] <= temp_dst_x; // 如何設計讓其不要在繼續傳下去
                self_detect_sent_n <= self_detect_sent_n;
                faulty_check_n <= faulty_check_n;
                first_border_sent <= first_border_sent;
            end else begin
                test_data_n <= `T_D_WIDTH'b0;
                self_detect_sent_n <= self_detect_sent_n;
                faulty_check_n <= faulty_check_n;
                first_border_sent <= first_border_sent;
            end
        end else begin
            test_data_n <= `T_D_WIDTH'b0;
            self_detect_sent_n <= self_detect_sent_n;
            faulty_check_n <= faulty_check_n;
            first_border_sent <= first_border_sent;
        end
    end else begin
        test_data_n <= `T_D_WIDTH'b0;
        self_detect_sent_n <= self_detect_sent_n;
        faulty_check_n <= faulty_check_n;
        first_border_sent <= first_border_sent;
    end
end

// E 
wire signed [3:0] Ex;
wire signed [3:0] Ey;

// x 往右 x+ 且需要小於邊界x
assign Ex = ((my_xpos + 1) <= 5)? (my_xpos + 1) : 3'bZ;
assign Ey = ((my_xpos + 1) <= 5)?  my_ypos      : 3'bZ;

// SE 
wire signed [3:0] SEx;
wire signed [3:0] SEy;

// x 往右 x+ 且需要小於邊界x
assign SEx = ((my_xpos + 1) <= 5 && (my_ypos + 1) <= 5)? (my_xpos + 1) : 3'bZ;
assign SEy = ((my_xpos + 1) <= 5 && (my_ypos + 1) <= 5)? (my_ypos + 1) : 3'bZ;

reg self_detect_sent_e;

reg [1:0] faulty_check_e;

reg test_line;
reg test_line_2;

//test_data_e生成
always @(posedge clk) begin
    if (reset == 0) begin //所有其他模組工作 reset == 1
        test_data_e <= `T_D_WIDTH'b0;
        self_detect_sent_e <= 1'b0;
        faulty_check_e <= 2'b00;
    end else if (state == `TD_STATE) begin 
        if (!self_detect_sent_e) begin
            if (Ex !== 3'bZ) begin
                test_data_e[`TYPE_MSB:`TYPE_LSB] <= 3'b111;
                test_data_e[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_e[31:14] <= 18'b000000000000000000;
                test_data_e[`VCH_MSB:`VCH_LSB] <= 2'b00; //之後要看如何測試得所有的vc buffer
                test_data_e[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_e[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_e[`DSTY_MSB:`DSTY_LSB] <= Ey;
                test_data_e[`DSTX_MSB:`DSTX_LSB] <= Ex; 
                self_detect_sent_e <= 1'b1;
                faulty_check_e <= faulty_check_e;
            end else begin
                test_data_e <= `T_D_WIDTH'b0;
                self_detect_sent_e <= 1'b1;
                faulty_check_e <= faulty_check_e;
            end
        end else begin //self_detect_sent already
            test_data_e <= `T_D_WIDTH'b0;
            self_detect_sent_e <= self_detect_sent_e;
            faulty_check_e <= faulty_check_e;
        end 
    end else if (state == `ACK_STATE && status == 1'b1) begin
        if (faulty_check_e[0] == 1'b0) begin
            if (Ex !== 3'bz) begin
                test_data_e[`TYPE_MSB:`TYPE_LSB] <= 3'b101;
                test_data_e[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_e[31:14] <= 18'b001000000000000000;
                test_data_e[`VCH_MSB:`VCH_LSB] <= 2'b01; //之後要看如何測試得所有的vc buffer
                test_data_e[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_e[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_e[`DSTY_MSB:`DSTY_LSB] <= Ey;
                test_data_e[`DSTX_MSB:`DSTX_LSB] <= Ex;
                self_detect_sent_e <= self_detect_sent_e;
                faulty_check_e[0] <= 1'b1; 
                //state <= `WAIT_FOR_NEXT;
            end else begin
                test_data_e <= `T_D_WIDTH'b0;
                self_detect_sent_e <= self_detect_sent_e;
                faulty_check_e[0] <= 1'b1;
                faulty_node[3] = 1'b1;
            end
        end else if (faulty_check_e[1] == 1'b0) begin
            if (SEx !== 3'bz) begin
                test_data_e[`TYPE_MSB:`TYPE_LSB] <= 3'b101;
                test_data_e[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_e[31:14] <= 18'b000100000000000000;
                test_data_e[`VCH_MSB:`VCH_LSB] <= 2'b10; //之後要看如何測試得所有的vc buffer
                test_data_e[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_e[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_e[`DSTY_MSB:`DSTY_LSB] <= SEy;
                test_data_e[`DSTX_MSB:`DSTX_LSB] <= SEx;
                self_detect_sent_e <= self_detect_sent_e;
                faulty_check_e[1] <= 1'b1;
                state <= state; 
            end else begin
                test_data_e <= `T_D_WIDTH'b0;
                self_detect_sent_e <= self_detect_sent_e;
                faulty_check_e[1] <= 1'b1;
                faulty_node[4] = 1'b1;
            end
        end else begin
            test_data_e <= `T_D_WIDTH'b0;
            self_detect_sent_e <= self_detect_sent_e;
            faulty_check_e <= faulty_check_e;
        end

        
        // // //////如果改成test_data_e卻可以動n不行
        if ((test_data_e_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK) && (faulty_check_e == 2'b11) && (test_data_e_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_e_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
            if (test_data_e_in[26] == 1'b1) begin//SW 6
                test_data_e[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_e[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_e[31:14] <= (status) ? 18'b000001000001000000 : 18'b000000000000000000;
                test_data_e[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_e[`SRCY_MSB:`SRCY_LSB] <=  test_data_e_in[`DSTY_MSB:`DSTY_LSB];
                test_data_e[`SRCX_MSB:`SRCX_LSB] <=  test_data_e_in[`DSTX_MSB:`DSTX_LSB];
                test_data_e[`DSTY_MSB:`DSTY_LSB] <=  test_data_e_in[`SRCY_MSB:`SRCY_LSB];
                test_data_e[`DSTX_MSB:`DSTX_LSB] <=  test_data_e_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_e <= self_detect_sent_e;
                faulty_check_e <= faulty_check_e;
            end else if (test_data_e_in[25] == 1'b1) begin//W 7
                test_data_e[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_e[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_e[31:14] <= (status) ? 18'b000000100010000000 : 18'b000000000000000000;
                test_data_e[`VCH_MSB:`VCH_LSB] <= 2'b11;
                test_data_e[`SRCY_MSB:`SRCY_LSB] <=  test_data_e_in[`DSTY_MSB:`DSTY_LSB];
                test_data_e[`SRCX_MSB:`SRCX_LSB] <=  test_data_e_in[`DSTX_MSB:`DSTX_LSB];
                test_data_e[`DSTY_MSB:`DSTY_LSB] <=  test_data_e_in[`SRCY_MSB:`SRCY_LSB];
                test_data_e[`DSTX_MSB:`DSTX_LSB] <=  test_data_e_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_e <= self_detect_sent_e;
                faulty_check_e <= faulty_check_e;
            end
        end

    end else begin
        test_data_e <= `T_D_WIDTH'b0;
        self_detect_sent_e <= self_detect_sent_e;
        faulty_check_e <= faulty_check_e;
    end
end

// S
wire signed [3:0] Sx;
wire signed [3:0] Sy;

assign Sx = ((my_ypos + 1) <= 5)?  my_xpos      : 3'bz;
assign Sy = ((my_ypos + 1) <= 5)? (my_ypos + 1) : 3'bz;

wire signed [3:0] SWx;
wire signed [3:0] SWy;

assign SWx = ((my_ypos + 1) <= 5 && (my_xpos - 1) >= 0) ? (my_xpos - 1) : 3'bz;
assign SWy = ((my_ypos + 1) <= 5 && (my_xpos - 1) >= 0) ? (my_ypos + 1) : 3'bz;

reg self_detect_sent_s;
reg [1:0] faulty_check_s;

always @(posedge clk) begin
    if (reset == 0) begin
        test_data_s <= `T_D_WIDTH'b0;
        self_detect_sent_s <= 1'b0;
        faulty_check_s <= 2'b00;
    end else if (state == `TD_STATE) begin
        if (!self_detect_sent_s) begin
            if (Sy !== 3'bz) begin
                test_data_s[`TYPE_MSB:`TYPE_LSB] <= 3'b111;
                test_data_s[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_s[31:14] <= 18'b000000000000000000;
                test_data_s[`VCH_MSB:`VCH_LSB] <= 2'b00; //之後要看如何測試得所有的vc buffer
                test_data_s[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_s[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_s[`DSTY_MSB:`DSTY_LSB] <= Sy;
                test_data_s[`DSTX_MSB:`DSTX_LSB] <= Sx;
                self_detect_sent_s <= 1'b1;
                faulty_check_s <= faulty_check_s; 
            end else begin
                test_data_s <= `T_D_WIDTH'b0;
                self_detect_sent_s <= 1'b1;
                faulty_check_s <= faulty_check_s;
            end
        end else begin //self_detect_sent_s already
            test_data_s <= `T_D_WIDTH'b0;
            self_detect_sent_s <= self_detect_sent_s;
            faulty_check_s <= faulty_check_s;
        end 
    end else if (state == `ACK_STATE && status == 1'b1) begin
        if (faulty_check_s[0] == 1'b0) begin
            if (Sy !== 3'bz) begin
                test_data_s[`TYPE_MSB:`TYPE_LSB] <= 3'b101;
                test_data_s[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_s[31:14] <= 18'b000010000000000000;
                test_data_s[`VCH_MSB:`VCH_LSB] <= 2'b01; 
                test_data_s[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_s[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_s[`DSTY_MSB:`DSTY_LSB] <= Sy;
                test_data_s[`DSTX_MSB:`DSTX_LSB] <= Sx;
                self_detect_sent_s <= self_detect_sent_s;
                faulty_check_s[0] <= 1'b1;  
                //state <= `WAIT_FOR_NEXT;
            end else begin
                test_data_s <= `T_D_WIDTH'b0;
                self_detect_sent_s <= self_detect_sent_s;
                faulty_check_s[0] <= 1'b1;
                faulty_node[5] = 1'b1;
            end
        end else if (faulty_check_s[1] == 1'b0) begin
            if (SWx !== 3'bz) begin
                test_data_s[`TYPE_MSB:`TYPE_LSB] <= 3'b101;
                test_data_s[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_s[31:14] <= 18'b000001000000000000;
                test_data_s[`VCH_MSB:`VCH_LSB] <= 2'b10; 
                test_data_s[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_s[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_s[`DSTY_MSB:`DSTY_LSB] <= SWy;
                test_data_s[`DSTX_MSB:`DSTX_LSB] <= SWx;
                self_detect_sent_s <= self_detect_sent_s;
                faulty_check_s[1] <= 1'b1;
                state <= state;  
            end else begin
                test_data_s <= `T_D_WIDTH'b0;
                self_detect_sent_s <= self_detect_sent_s;
                faulty_check_s[1] <= 1'b1;
                faulty_node[6] = 1'b1; 
            end
        end else begin
            test_data_s <= `T_D_WIDTH'b0;
            self_detect_sent_s <= self_detect_sent_s;
            faulty_check_s <= faulty_check_s;
        end

        

        if ((test_data_s_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK) && (faulty_check_s == 2'b11) && (test_data_s_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_s_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
            if (test_data_s_in[31] == 1'b1) begin//N 1
                test_data_s[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_s[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_s[31:14] <= (status) ? 18'b100000000000000010 : 18'b000000000000000000;
                test_data_s[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_s[`SRCY_MSB:`SRCY_LSB] <=  test_data_s_in[`DSTY_MSB:`DSTY_LSB];
                test_data_s[`SRCX_MSB:`SRCX_LSB] <=  test_data_s_in[`DSTX_MSB:`DSTX_LSB];
                test_data_s[`DSTY_MSB:`DSTY_LSB] <=  test_data_s_in[`SRCY_MSB:`SRCY_LSB];
                test_data_s[`DSTX_MSB:`DSTX_LSB] <=  test_data_s_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_s <= self_detect_sent_s;
                faulty_check_s <= faulty_check_s;
            end else if (test_data_s_in[24] == 1'b1) begin//NW 0
                test_data_s[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_s[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_s[31:14] <= (status) ? 18'b000000010000000001 : 18'b000000000000000000;
                test_data_s[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_s[`SRCY_MSB:`SRCY_LSB] <=  test_data_s_in[`DSTY_MSB:`DSTY_LSB];
                test_data_s[`SRCX_MSB:`SRCX_LSB] <=  test_data_s_in[`DSTX_MSB:`DSTX_LSB];
                test_data_s[`DSTY_MSB:`DSTY_LSB] <=  test_data_s_in[`SRCY_MSB:`SRCY_LSB];
                test_data_s[`DSTX_MSB:`DSTX_LSB] <=  test_data_s_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_s <= self_detect_sent_s;
                faulty_check_s <= faulty_check_s;
            end
        end

    end else begin
        test_data_s <= `T_D_WIDTH'b0;
        self_detect_sent_s <= self_detect_sent_s;
        faulty_check_w <= faulty_check_w;
    end
end

// W
wire signed [3:0] Wx;
wire signed [3:0] Wy;

assign Wx = ((my_xpos - 1) >= 0) ? (my_xpos - 1) : 3'bz;
assign Wy = ((my_xpos - 1) >= 0) ?  my_ypos      : 3'bz;

//WN
wire signed [3:0] WNx;
wire signed [3:0] WNy;
assign WNx = ((my_xpos - 1) >= 0 && (my_ypos - 1) >= 0) ? (my_xpos - 1) : 3'bz;
assign WNy = ((my_xpos - 1) >= 0 && (my_ypos - 1) >= 0) ? (my_ypos - 1) : 3'bz;

reg self_detect_sent_w;
reg [1:0]faulty_check_w;


always @(posedge clk) begin
    if (reset == 0) begin
        test_data_w <= `T_D_WIDTH'b0;
        self_detect_sent_w <= 1'b0;
        faulty_check_w <= 2'b00;
    end else if (state == `TD_STATE) begin
        if (!self_detect_sent_w) begin
            if (Wx !== 3'bz) begin
                test_data_w[`TYPE_MSB:`TYPE_LSB] <= 3'b111;
                test_data_w[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_w[31:14] <= 18'b000000000000000000;
                test_data_w[`VCH_MSB:`VCH_LSB] <= 2'b00; //之後要看如何測試得所有的vc buffer
                test_data_w[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_w[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_w[`DSTY_MSB:`DSTY_LSB] <= Wy;
                test_data_w[`DSTX_MSB:`DSTX_LSB] <= Wx;
                self_detect_sent_w <= 1'b1;
                faulty_check_w <= faulty_check_w; 
            end else begin
                test_data_w <= `T_D_WIDTH'b0;
                self_detect_sent_w <= 1'b1;
                faulty_check_w <= faulty_check_w;
            end
        end else begin //self_detect_sent_s already
            test_data_w <= `T_D_WIDTH'b0;
            self_detect_sent_w <= self_detect_sent_w;
            faulty_check_w <= faulty_check_w;
        end 
    end else if (state == `ACK_STATE && status == 1'b1) begin
        if (faulty_check_w[0] == 1'b0) begin
            if (Wx !== 3'bz) begin
                test_data_w[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK;
                test_data_w[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_w[31:14] <= 18'b000000100000000000;
                test_data_w[`VCH_MSB:`VCH_LSB] <= 2'b01; 
                test_data_w[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_w[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_w[`DSTY_MSB:`DSTY_LSB] <= Wy;
                test_data_w[`DSTX_MSB:`DSTX_LSB] <= Wx;
                self_detect_sent_w <= self_detect_sent_w; 
                faulty_check_w[0] <= 1'b1;
                //state <= `WAIT_FOR_NEXT;
            end else begin
                test_data_w <= `T_D_WIDTH'b0;
                self_detect_sent_w <= self_detect_sent_w;
                faulty_check_w[0] <= 1'b1;
                faulty_node[7] = 1'b1;
            end
        end else if (faulty_check_w[1] == 1'b0) begin
            if (WNx !== 3'bz) begin
                test_data_w[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK;
                test_data_w[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_w[31:14] <= 18'b000000010000000000;
                test_data_w[`VCH_MSB:`VCH_LSB] <= 2'b10; 
                test_data_w[`SRCY_MSB:`SRCY_LSB] <= my_ypos;
                test_data_w[`SRCX_MSB:`SRCX_LSB] <= my_xpos;
                test_data_w[`DSTY_MSB:`DSTY_LSB] <= WNy;
                test_data_w[`DSTX_MSB:`DSTX_LSB] <= WNx;
                self_detect_sent_w <= self_detect_sent_w; 
                faulty_check_w[1] <= 1'b1;
                state <= state;
            end else begin
                test_data_w <= `T_D_WIDTH'b0;
                self_detect_sent_w <= self_detect_sent_w;
                faulty_check_w[1] <= 1'b1;
                faulty_node[0] = 1'b1;
            end
        end else begin
            test_data_w <= `T_D_WIDTH'b0;
            self_detect_sent_w <= self_detect_sent_w;
            faulty_check_w <= faulty_check_w;
        end
        //s 改 w
        if ((test_data_w_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK) && (faulty_check_w == 2'b11) && (test_data_w_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_w_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
            if (test_data_w_in[30] == 1'b1) begin//NE 2
                test_data_w[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_w[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_w[31:14] <= (status) ? 18'b010000000000000100: 18'b000000000000000000;
                test_data_w[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_w[`SRCY_MSB:`SRCY_LSB] <=  test_data_w_in[5:3];
                test_data_w[`SRCX_MSB:`SRCX_LSB] <=  test_data_w_in[2:0];
                test_data_w[`DSTY_MSB:`DSTY_LSB] <=  test_data_w_in[11:9];
                test_data_w[`DSTX_MSB:`DSTX_LSB] <=  test_data_w_in[8:6];
                self_detect_sent_w <= self_detect_sent_w;
                faulty_check_w <= faulty_check_w;
                //test_line_2 <= 1'b1;
            end else if (test_data_w_in[29] == 1'b1) begin//E 3
                //test_line <= 1'b1;
                test_data_w[`TYPE_MSB:`TYPE_LSB] <= `TYPE_ACK_BACK;
                test_data_w[`DATA_MSB:32] <= 29'b00000000000000000000000000000;
                test_data_w[31:14] <= (status) ? 18'b001000000000001000 : 18'b000000000000000000;
                test_data_w[`VCH_MSB:`VCH_LSB] <= 2'b11; //之後要看如何測試得所有的vc buffer
                test_data_w[`SRCY_MSB:`SRCY_LSB] <=  test_data_w_in[`DSTY_MSB:`DSTY_LSB];
                test_data_w[`SRCX_MSB:`SRCX_LSB] <=  test_data_w_in[`DSTX_MSB:`DSTX_LSB];
                test_data_w[`DSTY_MSB:`DSTY_LSB] <=  test_data_w_in[`SRCY_MSB:`SRCY_LSB];
                test_data_w[`DSTX_MSB:`DSTX_LSB] <=  test_data_w_in[`SRCX_MSB:`SRCX_LSB];
                self_detect_sent_w <= self_detect_sent_w;
                faulty_check_w <= faulty_check_w;
            end
        end


    end else begin
        test_data_w <= `T_D_WIDTH'b0;
        self_detect_sent_w <= self_detect_sent_w;
        faulty_check_w <= faulty_check_w;
    end
end


reg ack_n_got;
always @(posedge clk) begin
    if (reset == 0) begin
        ack_n_got <= 1'b0;
    end else if (state == `TD_STATE)begin
        if (Ny !== 3'bZ) begin
            if (ack_n_in) begin
                ack_n_got <= 1'b1;
            end else begin
                ack_n_got <= ack_n_got;
            end
        end else begin
            ack_n_got <= 1'b1;
        end
    end else begin
        ack_n_got <= ack_n_got;
    end
end

reg ack_e_got;
always @(posedge clk) begin
    if (reset == 0) begin
        // faulty_node[2:1] <= 2'b0;
        ack_e_got <= 1'b0;
    end else if (state == `TD_STATE) begin
        if (Ex !== 3'bZ) begin
            if (ack_e_in) begin
                ack_e_got <= 1'b1;   
            end else begin
                ack_e_got <= ack_e_got;
            end
        end else begin
            ack_e_got <= 1'b1; 
        end
    end else begin
        ack_e_got <= ack_e_got;
    end
end

reg ack_s_got;
always @(posedge clk) begin
    if (reset == 0) begin
        ack_s_got <= 1'b0;
    end else if (state == `TD_STATE) begin
        if (Sy !== 3'bz) begin
            if (ack_s_in) begin
                ack_s_got <= 1'b1;
            end else begin
                ack_s_got <= ack_s_got;
            end
        end else begin
            ack_s_got <= 1'b1; 
        end
    end else begin
        ack_s_got <= ack_s_got;
    end
end

reg ack_w_got;
always @(posedge clk) begin
    if (reset == 0) begin
        ack_w_got <= 1'b0;
    end else if (state == `TD_STATE) begin
        if (Wx !== 3'bz) begin
            if (ack_w_in) begin
                ack_w_got <= 1'b1;
            end else begin
                ack_w_got <= ack_w_got;
            end
        end else begin
            ack_w_got <= 1'b1;
        end
    end else begin
        ack_w_got <= ack_w_got;
    end
end


//test_data_n一定的時間內沒有回傳ack則代表其有問題

//reg [`F_NODE - 1 : 0] faulty_node;

always @(*) begin
    //test_data_n_in
    if ((state == `ACK_STATE) && test_data_n_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK_BACK && (test_data_n_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_n_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
        
        //N
        if (test_data_n_in[31] == 1'b1) begin 
            if (test_data_n_in[15] == 1'b1) begin
                faulty_node[1] = 1'b1;
            end else begin
                faulty_node[1] = faulty_node[1];
            end
        end

        //NW
        if (test_data_n_in[24] == 1'b1) begin 
            if (test_data_n_in[14] == 1'b1) begin
                faulty_node[0] = 1'b1;
            end else begin
                faulty_node[0] = faulty_node[0];
            end
        end

    end



    //test_data_e_in
    if ((state == `ACK_STATE) && test_data_e_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK_BACK && (test_data_e_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_e_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
        
        //test_line = 1'b1;
        //E
        if (test_data_e_in[29] == 1'b1) begin
            if (test_data_e_in[17] == 1'b1) begin
                faulty_node[3] = 1'b1;
            end else begin
                faulty_node[3] = faulty_node[3];
            end
        end
        
        //NE
        if (test_data_e_in[30] == 1'b1) begin
            if (test_data_e_in[16] == 1'b1) begin
                faulty_node[2] = 1'b1;
            end else begin
                faulty_node[2] = faulty_node[2];
            end
        end
    end

    //test_data_s_in
    if ((state == `ACK_STATE) && test_data_s_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK_BACK && (test_data_s_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_s_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin

        //S
        if (test_data_s_in[27] == 1'b1) begin
            if (test_data_s_in[19] == 1'b1) begin
                faulty_node[5] = 1'b1;
            end else begin
                faulty_node[5] = faulty_node[5];
            end
        end
    
        //SE
        if (test_data_s_in[28] == 1'b1) begin
            if (test_data_s_in[18] == 1'b1) begin
                faulty_node[4] = 1'b1;
            end else begin
                faulty_node[4] = faulty_node[4];
            end
        end
    end

     //test_data_w_in
    if ((state == `ACK_STATE) && test_data_w_in[`TYPE_MSB:`TYPE_LSB] == `TYPE_ACK_BACK && (test_data_w_in[`DSTY_MSB:`DSTY_LSB] == my_ypos && test_data_w_in[`DSTX_MSB:`DSTX_LSB] == my_xpos)) begin
        
        //W
        if (test_data_w_in[25] == 1'b1) begin
            if (test_data_w_in[21] == 1'b1) begin
                faulty_node[7] = 1'b1;
            end else begin
                faulty_node[7] = faulty_node[7];
            end
        end

        //SW
        if (test_data_w_in[26] == 1'b1) begin
            if (test_data_w_in[20] == 1'b1) begin
                faulty_node[6] = 1'b1;
            end else begin
                faulty_node[6] = faulty_node[6];
            end
        end
    end
end

assign nb_f = !(&faulty_node); ///要作mask把所有的fualty_node變成相反的
assign faulty_node_inverter_out = ~faulty_node;
reg [`F_NODE-1:0]   north_faulty;
assign north_faulty = ((my_ypos - 1) >= 0) ? n_faulty : 8'hFF;
reg [`F_NODE-1:0]   east_faulty;
assign east_faulty = ((my_xpos + 1) <= 5) ? e_faulty : 8'hFF;
reg [`F_NODE-1:0]   south_faulty;
assign south_faulty = ((my_ypos + 1) <= 5) ? s_faulty : 8'hFF;
reg [`F_NODE-1:0]   west_faulty;
assign west_faulty = ((my_xpos - 1) >= 0) ? w_faulty : 8'hFF;

always @(*) begin
    //錯誤在本router下方
    if (counter >= 70 && counter < 80) begin
        if (south_faulty == 8'b00000000) begin
            if (west_faulty[3]) begin //從左邊來的已確認本router未損壞
                faulty_node[6] = ((west_faulty[4] == faulty_node[5]) && (west_faulty[5] == !faulty_node[6]) ? 1'b1 : faulty_node[6]);
            end else begin //若本router被偵測為壞掉狀態，代表本router就是壞掉的，所以faulty_node不會被騙 而是會騙人
                faulty_node[6] = faulty_node[6];
            end

            if (east_faulty[7]) begin
                faulty_node[4] = ((east_faulty[6] == faulty_node[5]) && (east_faulty[5] == !faulty_node[4]) ? 1'b1 : faulty_node[4]);
            end else begin
                faulty_node[4] = faulty_node[4];
            end
        end

        if (west_faulty == 8'b00000000) begin
            if (north_faulty[5]) begin
                faulty_node[0] = ((north_faulty[6] == faulty_node[7]) && (north_faulty[7] == !faulty_node[0]) ? 1'b1 : faulty_node[0]);
            end else begin
                faulty_node[0] = faulty_node[0];
            end
        
            if (south_faulty[1]) begin
                faulty_node[6] = ((south_faulty[0] == faulty_node[7]) && (south_faulty[7] == !faulty_node[6]) ? 1'b1 : faulty_node[6]);
            end else begin
                faulty_node[6] = faulty_node[6];
            end
        end

        if (north_faulty == 8'b00000000) begin
            if (west_faulty[3]) begin
                faulty_node[0] = ((west_faulty[2] == faulty_node[1]) && (west_faulty[1] == !faulty_node[0]) ? 1'b1 : faulty_node[0]);
            end else begin
                faulty_node[0] = faulty_node[0];
            end

            if (east_faulty[7]) begin
                faulty_node[2] = ((east_faulty[0] == faulty_node[1]) && (east_faulty[1] == !faulty_node[2]) ? 1'b1 : faulty_node[2]);
            end else begin
                faulty_node[2] = faulty_node[2];
            end
        end
    
        if (east_faulty == 8'b00000000) begin
            if (north_faulty[5]) begin
                faulty_node[2] = ((north_faulty[4] == faulty_node[3]) && (north_faulty[3] == !faulty_node[2]) ? 1'b1 : faulty_node[2]);
            end else begin
                faulty_node[2] = faulty_node[2];
            end
        
            if (south_faulty[1]) begin
                faulty_node[4] = ((south_faulty[2] == faulty_node[3]) && (south_faulty[3] == !faulty_node[4]) ? 1'b1 : faulty_node[4]);
            end else begin
                faulty_node[4] = faulty_node[4];
            end
        end
    end
end

endmodule