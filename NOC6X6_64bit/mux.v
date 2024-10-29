`include "defines.v"
module mux(
    input wire [`DATA_WIDTH-1:0] idata_0,
    input wire ivalid_0,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_0,

    input wire [`DATA_WIDTH-1:0] idata_1,
    input wire ivalid_1,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_1,

    input wire [`DATA_WIDTH-1:0] idata_2,
    input wire ivalid_2,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_2,

    input wire [`DATA_WIDTH-1:0] idata_3,
    input wire ivalid_3,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_3,

    input wire [`DATA_WIDTH-1:0] idata_4,
    input wire ivalid_4,
    input wire [`VCH_WIDTH_NUM - 1:0] ivch_4,

    input wire [4:0] sel,

    output reg [`DATA_WIDTH-1:0] odata,
    output reg ovalid,
    output reg [`VCH_WIDTH_NUM - 1:0] ovch
);
    assign odata = 
                    (sel == `PORT'b00001) ? idata_0 :
                    (sel == `PORT'b00010) ? idata_1 :
                    (sel == `PORT'b00100) ? idata_2 :
                    (sel == `PORT'b01000) ? idata_3 :
                    (sel == `PORT'b10000) ? idata_4 : 
                    `DATA_WIDTH'b0;
    assign ovalid = 
                    (sel == `PORT'b00001) ? ivalid_0 : 
                    (sel == `PORT'b00010) ? ivalid_1 : 
                    (sel == `PORT'b00100) ? ivalid_2 : 
                    (sel == `PORT'b01000) ? ivalid_3 : 
                    (sel == `PORT'b10000) ? ivalid_4 : 
                    1'b0;
    assign ovch = 
                    (sel == `PORT'b00001) ? ivch_0 : 
                    (sel == `PORT'b00010) ? ivch_1 : 
                    (sel == `PORT'b00100) ? ivch_2 : 
                    (sel == `PORT'b10000) ? ivch_4 : 
                    (sel == `PORT'b01000) ? ivch_3 : 
                    2'b00;
endmodule
