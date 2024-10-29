`include "defines.v"
//很簡單的概念 對input來說因為有兩個通道所以需要所謂的mux來去作判讀
//去決定誰要送到cross bar
module vcmux ( 
    input wire clk,
    input wire reset,
    // vc0
    input wire ivalid0,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch0,
    input wire [`DATA_WIDTH-1:0] idata0,
    input wire [`PORT_NUM-1:0] port0,
    input wire req0,

    // vc1
    input wire ivalid1,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch1,
    input wire [`DATA_WIDTH-1:0] idata1,
    input wire [`PORT_NUM-1:0] port1,
    input wire req1,

    // vc2
    input wire ivalid2,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch2,
    input wire [`DATA_WIDTH-1:0] idata2,
    input wire [`PORT_NUM-1:0] port2,
    input wire req2,

    // vc3
    input wire ivalid3,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch3,
    input wire [`DATA_WIDTH-1:0] idata3,
    input wire [`PORT_NUM-1:0] port3,
    input wire req3,

    // to cb
    output reg ovalid,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch,
    output reg [`DATA_WIDTH-1:0] odata,
    output reg [`PORT_NUM-1:0] port,
    output reg req,
    output [3:0] vcsel
);

// 每個通道的hold信號
wire [3:0] hold;
assign hold = last & {req3,req2,req1,req0};

//hold 的用意在於若是在同個時間點req0 / req1同時掛起 那會先將hold的（也就是先來的訊號）完成
//達成優先及的問題，也不要讓grt有同時 1 1

wire anyhold;
assign  anyhold = |hold;

//上一個clk的vcsel狀態
reg  [3:0] last;

//當前clk的通道優先級選擇訊號
wire [3:0] grt;
assign grt[0] = anyhold ? hold[0] : req0;
assign grt[1] = anyhold ? hold[1] : (!req0 & req1);
assign grt[2] = anyhold ? hold[2] : (!req0 & !req1 & req2);
assign grt[3] = anyhold ? hold[3] : (!req0 & !req1 & !req2 & req3);

//當前clk的狀態，要用來給inputc.v的grt選擇vc
assign vcsel = grt;


// 记录当前时钟周期的vcsel状态
always @(posedge clk) begin
    if (reset == 0) begin
        last <= 4'b0000;        
    end else if(last != grt)begin
        last <= grt;
    end
end

// 不會有選擇vc的問題其中一個有就是有
assign ovalid = ivalid0 | ivalid1 | ivalid2 | ivalid3; // ovalid取决于任意一个输入信号的有效性

assign req = req0 | req1 | req2 | req3; // req取决于任意一个输入信号的请求

//在st_stage send == 1時才傳入 so 用last 上一個
assign odata = (last[0] == 1) ? idata0 :
               (last[1] == 1) ? idata1 : 
               (last[2] == 1) ? idata2 : 
               (last[3] == 1) ? idata3 : `DATA_WIDTH'b0; // odata根据last的值选择对应的输入数据

assign ovch =  (last[0] == 1) ? ivch0 :
               (last[1] == 1) ? ivch1 :
               (last[2] == 1) ? ivch2 :
               (last[3] == 1) ? ivch3 : 2'b00; // ovch根据last的值选择对应的输入vc信号

assign port =  (vcsel[0] == 1) ? port0 :
               (vcsel[1] == 1) ? port1 :
               (vcsel[2] == 1) ? port2 :
               (vcsel[3] == 1) ? port3 : `PORT_NUM'b0; // port根据vcsel的值选择对应的输入端口号
endmodule