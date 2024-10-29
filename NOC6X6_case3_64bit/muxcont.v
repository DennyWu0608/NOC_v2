`include "defines.v"
module muxcont #(parameter  PORTID = 0)(
    input wire clk,
    input wire reset,

    input wire [`PORT_NUM-1:0] port_0,
    input wire req_0,

    input wire [`PORT_NUM-1:0] port_1,
    input wire req_1,

    input wire [`PORT_NUM-1:0] port_2,
    input wire req_2,

    input wire [`PORT_NUM-1:0] port_3,
    input wire req_3,

    input wire [`PORT_NUM-1:0] port_4,
    input wire req_4,

    output reg [`PORT-1:0] grt,
    output [`PORT-1:0] sel
);

reg [`PORT-1:0] last;
wire [`PORT-1:0] hold;
wire [`PORT-1:0] req;
wire [`PORT-1:0] grt0;
wire anyhold;

//  是那一個ic_x的請求  來自ic_x的請求    來自ic_x要前往的oc_x
assign  req[0] = (req_0 == 1) && (port_0 == PORTID);
assign  req[1] = (req_1 == 1) && (port_1 == PORTID);
assign  req[2] = (req_2 == 1) && (port_2 == PORTID);
assign  req[3] = (req_3 == 1) && (port_3 == PORTID);
assign  req[4] = (req_4 == 1) && (port_4 == PORTID);

assign  hold = last & req;
assign  anyhold = |hold;
assign  sel = last; //選outputc.v通道

//last 到底有洨屁用

always @(posedge clk) begin
    if (reset == 0) begin
        last <= 5'b0;
    end else if (last != grt) begin //grant回去通知inputc.v後last變化準備下階段outputc.v
        last <= grt;
    end
end

//有優先級別 有req就需要grant回去
assign  grt0[0] =                   req[0];
assign  grt0[1] = (req[0]   == 0) & req[1];
assign  grt0[2] = (req[1:0] == 0) & req[2];
assign  grt0[3] = (req[2:0] == 0) & req[3];
assign  grt0[4] = (req[3:0] == 0) & req[4];

assign  grt[0]  = anyhold ? hold[0] : grt0[0]; 
assign  grt[1]  = anyhold ? hold[1] : grt0[1]; 
assign  grt[2]  = anyhold ? hold[2] : grt0[2]; 
assign  grt[3]  = anyhold ? hold[3] : grt0[3]; 
assign  grt[4]  = anyhold ? hold[4] : grt0[4];

endmodule