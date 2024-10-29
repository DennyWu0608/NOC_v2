`include "defines.v"
module vc #(parameter ROUTERID = 0, parameter PCHID = 0, parameter VCHID = 0)(
    input wire clk,
    input wire reset,

    //form / to fifo
    input wire [`DATA_WIDTH-1:0] idata,
    output reg send,

    //to other node
    output reg olck,

    //form outputc check for vch ready or lock
    input wire [3:0] irdy_0,
    input wire [3:0] irdy_1,
    input wire [3:0] irdy_2,
    input wire [3:0] irdy_3,
    input wire [3:0] irdy_4,
    input wire [3:0] ilck_0,
    input wire [3:0] ilck_1,
    input wire [3:0] ilck_2,
    input wire [3:0] ilck_3,
    input wire [3:0] ilck_4,

    //form cb after the req
    input wire grt_0,
    input wire grt_1,
    input wire grt_2,
    input wire grt_3,
    input wire grt_4,

    //form rtcomp
    input wire [`PORT_NUM-1:0] port,
    input wire [`VCH_WIDTH_NUM - 1:0] ovch,

    //to vcmux
    output reg req  /* Request signal */

);

/* 變數 */
reg  [1:0]  state;
wire [`TYPEW-1:0]  btype;
wire        ilck;    /* 1: Next VC is locked by others */
wire        grt;	 /* 1: Output channel is allocated */
wire        irdy;	 /* 1: Next VC can receive a flit  */ 
assign btype = idata[`TYPE_MSB:`TYPE_LSB];



/* FSM state */
`define RC_STATE  2'b00  //routing computation
`define VSA_STATE 2'b01  //virtual channel
`define ST_STATE  2'b10  //switch traversal

// inputc 中的 rtcomp計算完port後，導向了同一顆router的 outputc
// ilck_0 ~ 4 是由outputc 通知同一顆的各個inputc.v
assign ilck = ((port == 0 && ilck_0[ovch]) ||
               (port == 1 && ilck_1[ovch]) ||
               (port == 2 && ilck_2[ovch]) ||
               (port == 3 && ilck_3[ovch]) ||
               (port == 4 && ilck_4[ovch]) 
               );
// outputc 在st_stage時(next clk send first data) 準備送其他的node
// 尚未傳送時，irdy == 1
// 傳送時, irdy == 0
// 全部傳送完，irdy == 1 (此時下一顆的inputc 進入且開始傳送send時 output回到原本的狀態，且等到其傳送完後，原本的router才回到正常的node)
assign irdy = ((port == 0 && irdy_0[ovch]) ||
               (port == 1 && irdy_1[ovch]) ||
               (port == 2 && irdy_2[ovch]) ||
               (port == 3 && irdy_3[ovch]) ||
               (port == 4 && irdy_4[ovch]) 
                );

// 來自crossbar
assign  grt = ((port == 0 && grt_0) || 
               (port == 1 && grt_1) || 
               (port == 2 && grt_2) || 
               (port == 3 && grt_3) || 
               (port == 4 && grt_4) 
               ); 

assign  olck    = (state != `RC_STATE); //給其他的node的說已經正在傳送此通道有人使用



always @(posedge clk) begin
    if (reset == 0) begin
        state <= `RC_STATE;
        send <= 0;
        req <= 0;
    end else begin
         case (state)
            `RC_STATE : begin
                if (btype == `TYPE_HEAD || btype == `TYPE_HEADTAIL || btype == `TYPE_TEST || btype == `TYPE_ACK || btype == `TYPE_ACK_BACK) begin
                    state <= `VSA_STATE;
                    send <= 0;
                    req <= 1;
                end
            end
            `VSA_STATE : begin
                if (ilck == 1) begin // next vc is locked so switch is locked. unable to start the arbitration(仲裁)
                    req <= 0;
                end if (grt == 0) begin // switch is not locked but it is not allocated
                    req <= 1;
                end if (irdy == 1 && grt == 1) begin // Switch is allocated and it is free!
                    state <= `ST_STATE;
                    send <= 1;
                    req <= 1;
                end
            end
            `ST_STATE : begin
                if (btype == `TYPE_TAIL || btype == `TYPE_HEADTAIL || btype == `TYPE_TEST || btype == `TYPE_ACK || btype == `TYPE_ACK_BACK) begin
                    state <= `RC_STATE;
                    send <= 0;
                    req <= 0;
                end
            end
            default: begin
                state <= state;
                req <= req;
                send <= send; 
            end
        endcase
    end
       
end


endmodule