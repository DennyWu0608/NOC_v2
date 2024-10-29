`include "defines.v"
module fifo (
    input wire clk,
    input wire reset,

    input wire [`DATA_WIDTH-1:0] idata,
    input wire wr_en,
    input wire rd_en,

    output reg ordy,
    output reg [`DATA_WIDTH-1:0] odata
);
    integer  i;
    reg [`DATA_WIDTH-1:0] ram [0:4];

    reg [2:0] wr_addr, rd_addr;
    reg [3:0] data_count;

    wire full,empty,set;

    assign full = (data_count == 5);
    assign empty = (data_count == 0);
    assign set = (~full | rd_en) & wr_en; //rd_en 因為如果有可讀信號 就可以新寫入一資料

    /*write address*/ /*read address*/
    always @(posedge clk) begin
        if(reset == 0)begin
            rd_addr <= 0;
            wr_addr <= 0;
        end 

        if (set) begin
            if (wr_addr == 4) begin 
                wr_addr <= 0;
            end else begin
                wr_addr <= wr_addr + 1;
            end
        end 

        if (rd_en & ~empty) begin //可讀信號 & 有東西
            if (rd_addr == 4) begin
                rd_addr <= 0;
            end else begin
                rd_addr <= rd_addr + 1;
            end
        end
           
    end

    /*data counter*/
    always @(posedge clk) begin
        if (reset == 0) begin
            data_count <= 0;
        end else if (~full & wr_en & ~(rd_en & ~empty))begin
            data_count <= data_count + 1;
        end else if (~empty & rd_en & ~wr_en)begin
            data_count <= data_count - 1;
        end
    end

    /* ordy empty space for a single packet*/
    assign ordy = ((5 - data_count) < `PACKET_LEN) ? 1'b0 : 1'b1;

    /*Memory I/O*/
    assign odata = empty ? `DATA_WIDTH'b0 : ram[rd_addr];

    always @(posedge clk) begin
        if (reset == 0) begin
            for (i = 0; i < 5; i++) begin
                ram[i] <= 0;
            end
        end else if (set) begin
            ram[wr_addr] <= idata;
        end
    end
endmodule