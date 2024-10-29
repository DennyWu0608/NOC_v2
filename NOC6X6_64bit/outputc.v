`include "defines.v"
module outputc #(parameter ROUTERID = 0, parameter PORTID = 0) (
    input wire clk,
    input wire reset,

    // from cb
    input wire [`DATA_WIDTH-1:0] idata,
    input wire ivalid,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch,

    // from 其他router之input的 ack & ilck
    input wire [`VCH_WIDTH-1 : 0] iack,
    input wire [`VCH_WIDTH-1 : 0] ilck,

    // to 各個 inputc.v 的virtual channel狀態
    output reg [`VCH_WIDTH-1 : 0] olck, //改
    output reg [`VCH_WIDTH-1 : 0] ordy, //改

    // to other node
    output reg [`DATA_WIDTH-1:0] odata,
    output reg ovalid,
    output reg [`VCH_WIDTH_NUM - 1:0]ovch
);

// /*
//  * Input/Output flit type
//  */
// wire [`TYPEW-1:0] itype;
// wire [`TYPEW-1:0] otype;
// assign itype = (ivalid == 1) ? idata[`TYPE_MSB:`TYPE_LSB] : `TYPE_NONE;
// assign otype = (ovalid == 1) ? odata[`TYPE_MSB:`TYPE_LSB] : `TYPE_NONE;

/*
 * Output data
 */
always @ (posedge clk) begin
        if (reset == 0) begin
                odata   <= `DATA_WIDTH'b0;
                ovalid  <= 1'b0;
                ovch    <= 2'b00;
        end else if (ivalid) begin
                odata   <= idata;
                ovalid  <= ivalid;
                ovch    <= ivch;
        end else if (~ivalid & ovalid) begin
                odata   <= `DATA_WIDTH'b0;
                ovalid  <= 1'b0;
                ovch    <= 2'b00;
        end
end


/*  
 * Virtual-channel status (lock) 
 */ 
 //vc0
 always @(posedge clk) begin
    if (reset == 0) begin
        olck[0] <= 1'b0;
                                        //最後一個狀態
    end else if ((ivalid && ivch == 0) || (ovalid && ovch == 0)) begin
        olck[0] <= 1'b1;
    end else if (olck[0] && ~ilck[0]) begin //若下一個inputc.v沒有lck且原本output lck住 則解開lck
        olck[0] <= 1'b0;
    end
 end

//vc1
 always @(posedge clk) begin
    if (reset == 0) begin
        olck[1] <= 1'b0;
                                        //最後一個狀態
    end else if ((ivalid && ivch == 1) || (ovalid && ovch == 1)) begin
        olck[1] <= 1'b1;
    end else if (olck[1] && ~ilck[1]) begin //若下一個inputc.v沒有lck且原本output lck住 則解開lck
        olck[1] <= 1'b0;
    end
 end

//vc2
 always @(posedge clk) begin
    if (reset == 0) begin
        olck[2] <= 1'b0;
                                        //最後一個狀態
    end else if ((ivalid && ivch == 2) || (ovalid && ovch == 2)) begin
        olck[2] <= 1'b1;
    end else if (olck[2] && ~ilck[2]) begin //若下一個inputc.v沒有lck且原本output lck住 則解開lck
        olck[2] <= 1'b0;
    end
 end

 //vc3
 always @(posedge clk) begin
    if (reset == 0) begin
        olck[3] <= 1'b0;
                                        //最後一個狀態
    end else if ((ivalid && ivch == 3) || (ovalid && ovch == 2)) begin
        olck[3] <= 1'b1;
    end else if (olck[3] && ~ilck[3]) begin //若下一個inputc.v沒有lck且原本output lck住 則解開lck
        olck[3] <= 1'b0;
    end
 end

/*  
 * Virtual-channel status (ready) 
 */ 

reg [3:0] cnt0; //for vc0
reg [3:0] cnt1; //for vc1
reg [3:0] cnt2; //for vc2
reg [3:0] cnt3; //for vc3


assign ordy[0] = ((5-cnt0) >= `PACKET_LEN) ? 1'b1 : 1'b0;
assign ordy[1] = ((5-cnt1) >= `PACKET_LEN) ? 1'b1 : 1'b0;
assign ordy[2] = ((5-cnt2) >= `PACKET_LEN) ? 1'b1 : 1'b0;
assign ordy[3] = ((5-cnt3) >= `PACKET_LEN) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    if (reset == 0) begin
        cnt0    <= 0;
                            //ivalid 要不等於1 且是通道0
    end else if (iack[0] && ~(ivalid && ivch == 0) && cnt0 != 0) begin
        cnt0    <= cnt0 - 1;
    end else if (~iack[0] && (ivalid && ivch == 0))begin
        cnt0    <= cnt0 + 1;
    end
end

always @(posedge clk) begin
    if (reset == 0) begin
        cnt1    <= 0;
                            //ivalid 要不等於1 且是通道0
    end else if (iack[1] && ~(ivalid && ivch == 1) && cnt1 != 0) begin
        cnt1    <= cnt1 - 1;
    end else if (~iack[1] && (ivalid && ivch == 1))begin
        cnt1    <= cnt1 + 1;
    end
end

always @(posedge clk) begin
    if (reset == 0) begin
        cnt2    <= 0;
                            //ivalid 要不等於1 且是通道0
    end else if (iack[2] && ~(ivalid && ivch == 2) && cnt2 != 0) begin
        cnt2    <= cnt2 - 1;
    end else if (~iack[2] && (ivalid && ivch == 2))begin
        cnt2    <= cnt2 + 1;
    end
end

always @(posedge clk) begin
    if (reset == 0) begin
        cnt3    <= 0;
                            //ivalid 要不等於1 且是通道0
    end else if (iack[3] && ~(ivalid && ivch == 3) && cnt3 != 0) begin
        cnt3    <= cnt3 - 1;
    end else if (~iack[3] && (ivalid && ivch == 3))begin
        cnt3    <= cnt3 + 1;
    end
end
endmodule