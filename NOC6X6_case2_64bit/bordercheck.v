`include "defines.v"
module bordercheck #(parameter WIDTHX = 0,parameter  WIDTHY = 0)(
    input wire clk,
    input wire reset,
    input wire [`T_D_WIDTH-1:0] n_in,
    input wire [`T_D_WIDTH-1:0] e_in,
    input wire [`T_D_WIDTH-1:0] s_in,
    input wire [`T_D_WIDTH-1:0] w_in,
    input wire [2:0]            state,
    input wire [2:0]            my_x,
    input wire [2:0]            my_y,
    // input wire [2:0]            x_max_now,
    // input wire [2:0]            y_max_now,
    output reg [2:0]            x_min,
    output reg [2:0]            y_min,
    output reg [2:0]            x_max,
    output reg [2:0]            y_max,
    output reg                  get_border,
    output reg [5:0]            up,
    output reg [5:0]            down,
    output reg [5:0]            left,
    output reg [5:0]            right
);

//reg [2:0] xy_array [0:3]; // 0 x_min 1 y_min 2 x_max 3 y_max
//reg [3:0] xy_compare; 4'1010
//reg [0:0] xy_compare [0:3]; // 共四層 每層1bit

// reg [5:0] up;
// reg [5:0] down;
// reg [5:0] left;
// reg [5:0] right;

assign get_border = (data_counter >= ((WIDTHX+WIDTHY)*2)-4) ? 1'b1 : 1'b0;
//網路的size x + y + 1
reg [4:0] data_counter;

always @(posedge clk) begin
    if (reset == 0) begin
        data_counter <= 0;
    end else if (state == 3'b100) begin
        if (n_in || s_in || w_in || e_in) begin
            data_counter <= data_counter + 1;
        end else begin
            data_counter <= data_counter;
        end
    end else begin
        data_counter <= 0;
    end
end

always @(*) begin
    if (state == 3'b000) begin
        x_min = my_x;
        y_min = my_y;
        x_max = my_x;
        y_max = my_y;
    end else if (state == 3'b100)begin
        if (n_in) begin
            //x_min
            if (x_min > n_in[25:23]) begin
                x_min = n_in[25:23];
            end else begin
                x_min = x_min;
            end
            //y_min
            if (y_min > n_in[22:20]) begin
                y_min = n_in[22:20];
            end else begin
                y_min = y_min;
            end
            //x_max
            if (x_max < n_in[19:17]) begin
                x_max = n_in[19:17];
            end else begin
                x_max = x_max;
            end
            //y_max
            if (y_max < n_in[16:14]) begin
                y_max = n_in[16:14];
            end else begin
                y_max = y_max;
            end
        end else if (e_in) begin
            //x_min
            if (x_min > e_in[25:23]) begin
                x_min = e_in[25:23];
            end else begin
                x_min = x_min;
            end
            //y_min
            if (y_min > e_in[22:20]) begin
                y_min = e_in[22:20];
            end else begin
                y_min = y_min;
            end
            //x_max
            if (x_max < e_in[19:17]) begin
                x_max = e_in[19:17];
            end else begin
                x_max = x_max;
            end
            //y_max
            if (y_max < e_in[16:14]) begin
                y_max = e_in[16:14];
            end else begin
                y_max = y_max;
            end
        end else if (s_in) begin
            //x_min
            if (x_min > s_in[25:23]) begin
                x_min = s_in[25:23];
            end else begin
                x_min = x_min;
            end
            //y_min
            if (y_min > s_in[22:20]) begin
                y_min = s_in[22:20];
            end else begin
                y_min = y_min;
            end
            //x_max
            if (x_max < s_in[19:17]) begin
                x_max = s_in[19:17];
            end else begin
                x_max = x_max;
            end
            //y_max
            if (y_max < s_in[16:14]) begin
                y_max = s_in[16:14];
            end else begin
                y_max = y_max;
            end
        end else if (w_in) begin
            //x_min
            if (x_min > w_in[25:23]) begin
                x_min = w_in[25:23];
            end else begin
                x_min = x_min;
            end
            //y_min
            if (y_min > w_in[22:20]) begin
                y_min = w_in[22:20];
            end else begin
                y_min = y_min;
            end
            //x_max
            if (x_max < w_in[19:17]) begin
                x_max = w_in[19:17];
            end else begin
                x_max = x_max;
            end
            //y_max
            if (y_max < w_in[16:14]) begin
                y_max = w_in[16:14];
            end else begin
                y_max = y_max;
            end
        end
    end else begin
        x_min = x_min;
        y_min = y_min;
        x_max = x_max;
        y_max = y_max;
    end
end

always @(*) begin
    if (!get_border && state == 3'b000) begin
        up = 6'b000000;
        down = 6'b000000;
        left = 6'b000000;
        right = 6'b000000;
    end else if (get_border && state == 3'b100) begin
        up[2:0] = (x_min + x_max) / 2;
        up[5:3] = y_min;
        down[2:0] = (x_min + x_max) / 2;
        down[5:3] = y_max;
        left[2:0] = x_min;
        left[5:3] = (y_min + y_max) / 2;
        right[2:0] = x_max;
        right[5:3] = (y_min + y_max) / 2;
    end else begin
        up = up;
        down = down;
        left = left;
        right = right;
    end
end

// always @(*) begin
//     if (xy_array[0] !== x_min) begin
//         xy_array[0] = x_min;
//         xy_compare[0] = 1'b0;
//     end else begin
//         xy_array[0] = xy_array[0];
//         xy_compare[0] = 1'b1;
//     end

//     if (xy_array[1] !== y_min) begin
//         xy_array[1] = y_min;
//         xy_compare[1] = 1'b0;
//     end else begin
//         xy_array[1] = xy_array[1];
//         xy_compare[1] = 1'b1;
//     end

//     if (xy_array[2] !== x_max) begin
//         xy_array[2] = x_max;
//         xy_compare[2] = 1'b0;
//     end else begin
//         xy_array[2] = xy_array[2];
//         xy_compare[2] = 1'b1;
//     end

//     if (xy_array[3] !== y_max) begin
//         xy_array[3] = y_max;
//         xy_compare[3] = 1'b0;
//     end else begin
//         xy_array[3] = xy_array[3];
//         xy_compare[3] = 1'b1;
//     end
// end
endmodule