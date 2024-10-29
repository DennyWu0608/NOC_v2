`include "defines.v"
module rtcomp (
    input wire clk,
    input wire reset,

    input wire [2:0] my_xpos,
    input wire [2:0] my_ypos,
    input wire test_mode,
    input wire border_mode,

    input wire nb_f,
    input wire [5:0] up, //000 000
    input wire [5:0] down,
    input wire [5:0] left,
    input wire [5:0] right,

    input wire [7:0] faulty_node, // M h7 g6 f5 e4 d3 c2 b1 a0 L

    input wire [5:0] dst_addr,
    input wire [1:0] ivch, // 00 01 10 11
    input wire en, // 為了判斷是否為第一筆資料
    
    output reg [2:0] port,
    output reg [1:0] ovch // 00 01 10 11
);

    wire [2:0] ux;
    wire [2:0] uy;
    wire [2:0] dx;
    wire [2:0] dy;
    wire [2:0] lx;
    wire [2:0] ly;
    wire [2:0] rx;
    wire [2:0] ry;

    assign ux = up[2:0];
    assign uy = up[5:3];
    assign dx = down[2:0];
    assign dy = down[5:3];
    assign lx = left[2:0];
    assign ly = left[5:3];
    assign rx = right[2:0];
    assign ry = right[5:3];

/*首先，由於資料是以negedge clk傳遞，在過程中，資料會先傳達到inputc.v中的所有需要data的地方，
  此時，rtcomp也會接收到dst_addr（特別是header flit因為資料在此），若是在clk = 0 同時 header flit傳
  進來時，沒有將路徑計算好（未用邏輯電路），當下一個clk進來時，header flit的資料將會遺失改變成其他的資料*/
    reg  [2:0] port0;
    reg  [2:0] port1;
    reg  [1:0] ovch0; 
    reg  [1:0] ovch1;

    wire [2:0] dst_ypos;
    wire [2:0] dst_xpos;

    assign dst_xpos = dst_addr[`DSTX_POS_MSB:`DSTX_POS_LSB];
    assign dst_ypos = dst_addr[`DSTY_POS_MSB:`DSTY_POS_LSB];

    assign port = en ? port0 : port1;
    assign ovch = en ? ovch0 : ovch1;
    
    always @(posedge clk) begin
        if (reset == 0) begin
            port1 <= 3'b0;
            ovch1 <= 2'b0;
        end else if (en) begin
            port1 <= port0;
            ovch1 <= ovch0;
        end
    end

    reg b_to_mini;
     always @(*) begin
        if ((test_mode) && (!border_mode)) begin // test 1 and not go to border mode 0
            if (my_xpos == dst_xpos && my_ypos == dst_ypos) begin//卐字演算法
                port0 = 4;
            end else begin
                if (my_xpos < dst_xpos && my_ypos > dst_ypos) begin//右上
                    port0 = 0;
                end else if (my_xpos < dst_xpos && my_ypos < dst_ypos) begin//右下
                    port0 = 1;
                end else if (my_xpos > dst_xpos && my_ypos < dst_ypos) begin//左下
                    port0 = 2;
                end else if (my_xpos > dst_xpos && my_ypos > dst_ypos) begin//左上
                    port0 = 3;
                end else if (my_xpos < dst_xpos && my_ypos == dst_ypos) begin//右
                    port0 = 1;
                end else if (my_xpos == dst_xpos && my_ypos < dst_ypos) begin//上
                    port0 = 2;
                end else if (my_xpos > dst_xpos && my_ypos == dst_ypos) begin//左
                    port0 = 3;
                end else if (my_xpos == dst_xpos && my_ypos > dst_ypos) begin//下
                    port0 = 0;
                end
            end
            //$display("IN TEST_MODE");
        end else if ((test_mode) && (border_mode)) begin //test mode finishing and goin to border mode 邊界演算法
            //$display("IN BORDER_MODE");
            if (dst_xpos == my_xpos && dst_ypos == my_ypos) begin
                port0 = 4;
            end else begin
                if (faulty_node[0] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[7] != 1'b1) begin
                    //a 錯 b 對 h 對
                    port0 = 3;
                end else if (faulty_node[1] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[7] != 1'b1) begin
                    //b 錯 d 對 h 對
                    port0 = 3;
                end else if (faulty_node[1] == 1'b1 && faulty_node[3] == 1'b1 && faulty_node[5] != 1'b1 && faulty_node[7] != 1'b1) begin
                    //b 錯 d 錯 f 對 h 對
                    port0 = 3;
                end else if (faulty_node[4] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[5] != 1'b1) begin
                    //e4 錯 d3 對 f5 對
                    port0 = 1;
                end else if (faulty_node[5] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[7] != 1'b1) begin
                    //f 錯 d 對 h 對
                    port0 = 1;
                end else if (faulty_node[5] == 1'b1 && faulty_node[7] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[3] != 1'b1) begin
                    //f 錯 h 錯 b 對 d 對
                    port0 = 1;
                end else if (faulty_node[2] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[3] != 1'b1) begin
                    //c 錯 b 對 d 對
                    port0 = 0;
                end else if (faulty_node[3] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[5] != 1'b1) begin
                    //d 錯 b 對 f 對
                    port0 = 0;
                end else if (faulty_node[3] == 1'b1 && faulty_node[5] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[7] != 1'b1) begin
                    //d 錯 f 錯 b 對 h 對
                    port0 = 0;
                end else if (faulty_node[6] == 1'b1 && faulty_node[5] != 1'b1 && faulty_node[7] != 1'b1) begin
                    //g 錯 f 對 h 對
                    port0 = 2;
                end else if (faulty_node[7] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[5] != 1'b1) begin
                    //h 錯 f 對 b 對
                    port0 = 2;
                end else if (faulty_node[7] == 1'b1 && faulty_node[1] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[5] != 1'b1) begin
                    //h 錯 b 錯 f 對 d 對
                    port0 = 2;
                end 
            end
        end else if ((!test_mode) && (!border_mode)) begin//test mode == 0 and bordermode == 0
            if ((nb_f & ~b_to_mini)) begin//附近有錯誤節點的deadlock free
                if (dst_xpos == my_xpos && dst_ypos == my_ypos) begin //目的地點位於convexg上
                    port0 = 4;
                end else begin
                    if (ovch0 == 2'b00 || ovch0 == 2'b10) begin//逆時針
                        if (faulty_node[0] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 0;
                        end else if (faulty_node[1] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 1;
                        end else if (faulty_node[1] == 1'b1 && faulty_node[3] == 1'b1 && faulty_node[5] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 2;
                        end else if (faulty_node[4] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 2;
                        end else if (faulty_node[5] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 3;
                        end else if (faulty_node[5] == 1'b1 && faulty_node[7] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[3] != 1'b1) begin
                            port0 = 0;
                        end else if (faulty_node[2] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[3] != 1'b1) begin
                            port0 = 1;
                        end else if (faulty_node[3] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 2;
                        end else if (faulty_node[3] == 1'b1 && faulty_node[5] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 3;
                        end else if (faulty_node[6] == 1'b1 && faulty_node[5] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 3;
                        end else if (faulty_node[7] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 0;
                        end else if (faulty_node[7] == 1'b1 && faulty_node[1] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 1;
                        end
                    end else if (ovch0 == 2'b01 || ovch0 == 2'b11) begin//順時針
                        if (faulty_node[0] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 3;
                        end else if (faulty_node[1] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 3;
                        end else if (faulty_node[1] == 1'b1 && faulty_node[3] == 1'b1 && faulty_node[5] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 3;
                        end else if (faulty_node[4] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 1;
                        end else if (faulty_node[5] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 1;
                        end else if (faulty_node[5] == 1'b1 && faulty_node[7] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[3] != 1'b1) begin
                            port0 = 1;
                        end else if (faulty_node[2] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[3] != 1'b1) begin
                            port0 = 0;
                        end else if (faulty_node[3] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 0;
                        end else if (faulty_node[3] == 1'b1 && faulty_node[5] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 0;
                        end else if (faulty_node[6] == 1'b1 && faulty_node[5] != 1'b1 && faulty_node[7] != 1'b1) begin
                            port0 = 2;
                        end else if (faulty_node[7] == 1'b1 && faulty_node[1] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 2;
                        end else if (faulty_node[7] == 1'b1 && faulty_node[1] == 1'b1 && faulty_node[3] != 1'b1 && faulty_node[5] != 1'b1) begin
                            port0 = 2;
                        end
                    end
                end
            end else if (!(nb_f & ~b_to_mini)) begin//正常最短路徑演算法
                if (dst_xpos == my_xpos && dst_ypos == my_ypos) begin
                    port0 = 4;
                end else if (dst_xpos > my_xpos) begin
                    port0 = 1;
                end else if (dst_xpos < my_xpos) begin
                    port0 = 3;
                end else if (dst_ypos > my_ypos) begin
                    port0 = 2;
                end else begin
                    port0 = 0;
                end
            end 
        end
    end

    integer d1,d2; // d1順 d2逆
    always @(*) begin
        if (!nb_f) begin
            d1 = 0;
            d2 = 0;
            ovch0 = ivch;
        end else begin
            if (my_xpos < dst_xpos) begin // X+ C在D左邊
                if (my_ypos > ly && my_ypos > ry) begin //在l和r的下方
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D在右上
                        if (my_xpos <= dx) begin
                            //C->l->u->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->d->r->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->d->l->u->D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->r->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end
                        //d1 V.S. d2
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin // D左上
                        if (my_xpos <= dx) begin
                            //C->l->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->d->r->u->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->d->l->D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->r->u->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;
                        end
                        //d1 V.S. d2
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin // D在右下
                        if (my_xpos <= dx) begin
                            //C->l->u->r->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C->d->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C -> down -> left -> up -> right -> D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(dx - lx))+
                                 ((dy > ly)?(dy - ly):(dy - ly))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C -> D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));   
                            b_to_mini = 1;
                        end
                        //d1 V.S. d2
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin // D在左下
                        //C -> down -> left -> up -> right -> D
                        d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > lx)?(dx - lx):(dx - lx))+
                             ((dy > ly)?(dy - ly):(dy - ly))+
                             ((lx > ux)?(lx - ux):(ux - lx))+
                             ((ly > uy)?(ly - uy):(uy - ly))+
                             ((ux > rx)?(ux - rx):(rx - ux))+
                             ((uy > ry)?(uy - ry):(ry - uy))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                        //C -> D
                        d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        b_to_mini = 1; 
                        if (d1 <= d2) begin
                                ovch0 = 2'b01;
                            end else begin
                                ovch0 = 2'b00;
                            end
                    end
                end else if (my_ypos <= ly && my_ypos > ry) begin //介於l/r中間，l下r上
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D右上
                        if (my_xpos <= dx) begin
                            //C->u->D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+
                                 ((my_ypos > uy)?(my_xpos - uy):(uy - my_ypos))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->l->d->r->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->d->l->u->D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->r->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end
                        //d1 V.S. d2
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        if (my_xpos <= dx) begin
                            //C->D
                            d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            //C->l->d->r->u->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 1;
                        end else if (my_xpos > dx) begin //不符合
                            b_to_mini = 0;
                        end
                        //d1 V.S. d2
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        if (my_xpos <= dx) begin
                            //C->u->r->D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+
                                 ((my_ypos > uy)?(my_xpos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C->l->d->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+
                                 ((my_ypos > ly)?(my_xpos - ly):(ly - my_ypos))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->D
                            d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            //C->r->u->l->d->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 1;
                        end
                        //d1 V.S. d2
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= dx) begin
                            //C->u->r->d->D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+
                                 ((my_ypos > uy)?(my_xpos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            //C->l->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //不太可能 因為D在down的左邊且必須滿足C在D左邊如果今天C比dx大此條件不可能符合
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end else if (my_ypos > ly && my_ypos <= ry) begin //介於l/r中間，r下l上
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D右上
                        if (my_xpos <= dx) begin
                            //C->l->u->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->d->r->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->r->d->l->u->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            b_to_mini = 1;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        if (my_xpos <= dx) begin
                            //C->l->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->d->r->u->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin //不太可能發生 因為C要同時滿足在D左邊且在down右邊有點少
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        if (my_xpos <= dx) begin
                            //C->l->u->r->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C->d->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->r->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C->u->l->d->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= dx) begin
                            //C->l->u->r->d->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            //C->D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            b_to_mini = 1;
                        end else if (my_xpos > dx) begin
                            //不太可能今天D要小於等於down x 且C要大於down x同時間
                            //C又要在D左邊
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end else if (my_ypos <= ly && my_ypos <= ry) begin //絕對上方 (包含著在r點上)
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D右上
                        if (my_xpos <= ux) begin
                            // C -> up -> D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+
                                 ((my_ypos > uy)?(my_xpos - uy):(uy - my_ypos))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C -> left -> down -> right -> D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end else if (my_xpos > ux) begin
                            //C->D
                            d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                             //C -> up -> left -> down -> right -> D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 1;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        //只有Cx <= ux的可能
                        //C->D
                        d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        //C->l->d->r->u->D
                        d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                             ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                             ((lx > dx)?(lx - dx):(dx - lx))+
                             ((ly > dy)?(ly - dy):(dy - ly))+
                             ((dx > rx)?(dx - rx):(rx - dx))+
                             ((dy > ry)?(dy - ry):(ry - dy))+
                             ((rx > ux)?(rx - ux):(ux - rx))+
                             ((ry > uy)?(ry - uy):(uy - ry))+
                             ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                             ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end 
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        if (my_xpos <= ux) begin
                            //C->u->r->D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+
                                 ((my_ypos > uy)?(my_xpos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C->l->d->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;
                        end else if (my_xpos > ux) begin
                            //C->r->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                                 ((my_ypos > ry)?(my_xpos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            //C->u->l->d->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= ux) begin
                            //C->u->r->d->D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+
                                 ((my_ypos > uy)?(my_xpos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            //C->l->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;
                        end else if (my_xpos > ux) begin
                            //C->r->d->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                                 ((my_ypos > ry)?(my_xpos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            //C->u->l->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end
            end else if (my_xpos > dst_xpos) begin // X- C在D右邊
                if (my_ypos > ly && my_ypos > ry) begin //在l和r的下方
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D在右上
                        if (my_xpos <= dx) begin
                            //C->l->u->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->d->r->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                                 b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->d->l->u->D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->r->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        if (my_xpos <= dx) begin
                            //C->l->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->d->r->u->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;
                        end else if (my_xpos > dx) begin
                            //C->d->l->D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->r->u->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        //my_xpos <= dx 相對位置矛盾所以只有一種可能
                        d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        //C->r->u->l->d->D
                        d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                             ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                             ((rx > ux)?(rx - ux):(ux - rx))+
                             ((ry > uy)?(ry - uy):(uy - ry))+
                             ((ux > lx)?(ux - lx):(lx - ux))+
                             ((uy > ly)?(uy - ly):(ly - uy))+
                             ((lx > dx)?(lx - dx):(dx - lx))+
                             ((ly > dy)?(ly - dy):(dy - ly))+
                             ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                             ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= dx) begin
                            //C->D
                            d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            //C->d->r->u->l->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 1;
                        end else if (my_xpos > dx) begin
                            // C -> d -> D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            // C -> r -> u -> l -> D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > lx)?(ux - lx):(ux - lx))+
                                 ((uy > ly)?(uy - ly):(uy - ly))+                             
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end
                end else if (my_ypos <= ly && my_ypos > ry) begin //介於l/r中間，l下r上
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D在右上
                        //Cx <= dx和Dx相對位置不符合
                        //C -> d -> l -> u -> D
                        d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > lx)?(dx - lx):(lx - dx))+
                             ((dy > ly)?(dy - ly):(ly - dy))+
                             ((lx > ux)?(lx - ux):(ux - lx))+
                             ((ly > uy)?(ly - uy):(uy - ly))+
                             ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                             ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                        //C -> r -> D
                        d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                             ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        if (my_xpos <= dx) begin
                            //C->D
                            d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            //C->l->d->r->u->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                ((lx > dx)?(lx - dx):(dx - lx))+
                                ((ly > dy)?(ly - dy):(dy - ly))+
                                ((dx > rx)?(dx - rx):(rx - dx))+
                                ((dy > ry)?(dy - ry):(ry - dy))+
                                ((rx > ux)?(rx - ux):(ux - rx))+
                                ((ry > uy)?(ry - uy):(uy - ry))+
                                ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 1;
                        end else if (my_xpos > dx) begin
                            // C -> d -> l -> D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            // C -> r -> u -> D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;     
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        if (my_xpos <= dx) begin
                            //不符合
                        end else if (my_xpos > dx) begin
                            //C->D
                            d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            //C->r->u->l->d->D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 1;  
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= dx) begin
                            //C->u->r->d->D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+                             
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            //C->l->D
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;  
                        end else if (my_xpos > dx) begin
                            // C -> d -> D
                            d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            // C -> r -> u -> l -> D
                            d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > lx)?(ux - lx):(ux - lx))+
                                 ((uy > ly)?(uy - ly):(uy - ly))+                             
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;  
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end
                end else if (my_ypos > ly && my_ypos <= ry) begin //介於l/r中間，r下l上
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D在右上
                        if (my_xpos <= dx) begin
                            //不符合 相對位置錯誤
                        end else if (my_xpos > dx) begin
                            //C->r->d->l->u->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            //C->D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            b_to_mini = 1;  
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        if (my_xpos <= dx) begin
                            //C->l->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->d->r->u->D
                            d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                                 ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                                 ((dx > rx)?(dx - rx):(rx - dx))+
                                 ((dy > ry)?(dy - ry):(ry - dy))+
                                 ((rx > ux)?(rx - ux):(ux - rx))+
                                 ((ry > uy)?(ry - uy):(uy - ry))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;  
                        end else if (my_xpos > dx) begin
                            //C->r->d->l->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly)); 
                            //C->u->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0;  
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        if (my_xpos <= dx) begin
                            //不成立
                        end else if (my_xpos > dx) begin
                            //C->r->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry)); 
                            //C->u->l->d->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0;  
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= dx) begin
                            //C->l->u->r->d->D
                            d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy)); 
                            //C->D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            b_to_mini = 1;  
                        end else if (my_xpos > dx) begin
                            //C->r->d->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy)); 
                            //C->u->l->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;  
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end
                end else if (my_ypos <= ly && my_ypos <= ry) begin //絕對上方 (包含著在r點上)
                    if (dst_xpos > ux && dst_ypos <= ry) begin //D在右上
                        if (my_xpos <= dx) begin
                            //不成立
                        end else if (my_xpos > dx) begin
                            //C->r->d->l->u->D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > ux)?(lx - ux):(ux - lx))+
                                 ((ly > uy)?(ly - uy):(uy - ly))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy)); 
                            //C->D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            b_to_mini = 1; 
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= ux && dst_ypos <= ly) begin //D左上
                        if (my_xpos <= dx) begin
                            // C -> u -> r -> d -> l -> D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->D
                            d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+
                                 ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                            b_to_mini = 1; 
                        end else if (my_xpos > dx) begin
                            // C -> r -> d -> l -> D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > lx)?(dx - lx):(lx - dx))+
                                 ((dy > ly)?(dy - ly):(ly - dy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            //C->u->D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                                 ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                            b_to_mini = 0; 
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > dx && dst_ypos > ry) begin //D右下
                        if (my_xpos <= dx) begin
                            // C -> u -> r -> D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            // C - > l -> d -> D     
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+ 
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0; 
                        end else if (my_xpos > dx) begin
                            // C -> r -> D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                                 ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                            // C -> u -> l -> d -> D     
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+ 
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dx)?(lx - dx):(dx - lx))+
                                 ((ly > dy)?(ly - dy):(dy - ly))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            b_to_mini = 0; 
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos <= dx && dst_ypos > ly) begin //D左下
                        if (my_xpos <= dx) begin
                            // C -> u -> r -> d -> D
                            d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > rx)?(ux - rx):(rx - ux))+
                                 ((uy > ry)?(uy - ry):(ry - uy))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                            // C - > l ->  D     
                            d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                                 ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+ 
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0; 
                        end else if (my_xpos > dx) begin
                            // C -> r -> d -> D
                            d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                                 ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                                 ((rx > dx)?(rx - dx):(dx - rx))+
                                 ((ry > dy)?(ry - dy):(dy - ry))+
                                 ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                                 ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy)); 
                            // C -> u -> l -> D
                            d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                                 ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                                 ((ux > lx)?(ux - lx):(lx - ux))+
                                 ((uy > ly)?(uy - ly):(ly - uy))+
                                 ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                                 ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                            b_to_mini = 0;
                        end
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end
                end
            end else if (my_xpos == dst_xpos && my_ypos < dst_ypos) begin //Y+
                if (my_xpos <= ux && my_ypos <= ly) begin//固定左右 判斷在上還在下
                    if (dst_xpos <= dx) begin
                        // C -> u -> r -> d -> D
                        d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                             ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                             ((ux > rx)?(ux - rx):(rx - ux))+
                             ((uy > ry)?(uy - ry):(ry - uy))+
                             ((rx > dx)?(rx - dx):(dx - rx))+
                             ((ry > dy)?(ry - dy):(dy - ry))+
                             ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                             ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                        // C -> l -> D
                        d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                             ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                             ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                             ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx) begin
                        // C -> u -> r -> D
                        d1 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                             ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                             ((ux > rx)?(ux - rx):(rx - ux))+
                             ((uy > ry)?(uy - ry):(ry - uy))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                        // C - > l -> d -> D     
                        d2 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                             ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+ 
                             ((lx > dx)?(lx - dx):(dx - lx))+
                             ((ly > dy)?(ly - dy):(dy - ly))+
                             ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                             ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end else if (my_xpos <= ux && my_ypos <= ly) begin
                    if (dst_xpos <= dx) begin
                        // C -> l -> u -> r -> d -> D
                        d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                             ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                             ((lx > ux)?(lx - ux):(ux - lx))+
                             ((ly > uy)?(ly - uy):(uy - ly))+
                             ((ux > rx)?(ux - rx):(rx - ux))+
                             ((uy > ry)?(uy - ry):(ry - uy))+
                             ((rx > dx)?(rx - dx):(dx - rx))+
                             ((ry > dy)?(ry - dy):(dy - ry))+
                             ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                             ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                        // C -> D     
                        d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx) begin
                        //C->d->l->u->r->D
                        d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+ 
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > lx)?(dx - lx):(lx - dx))+
                             ((dy > ly)?(dy - ly):(ly - dy))+
                             ((lx > ux)?(lx - ux):(ux - lx))+
                             ((ly > uy)?(ly - uy):(uy - ly))+
                             ((ux > rx)?(ux - rx):(rx - ux))+
                             ((ry > ry)?(ry - ry):(ry - uy))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                        //C->D
                        d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end else if (my_xpos > ux && my_ypos <= ry) begin
                    if (dst_xpos <= dx) begin
                        // C -> r -> d -> D
                        d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                             ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                             ((rx > dx)?(rx - dx):(dx - rx))+
                             ((ry > dy)?(ry - dy):(dy - ry))+
                             ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                             ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy)); 
                        // C -> u -> l -> D
                        d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                             ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                             ((ux > lx)?(ux - lx):(lx - ux))+
                             ((uy > ly)?(uy - ly):(ly - uy))+
                             ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                             ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx) begin
                        // C -> r -> D
                        d1 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+ 
                             ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry)); 
                        // C -> u -> l -> d -> D
                        d2 = ((my_xpos > ux)?(my_xpos - ux):(ux - my_xpos))+ 
                             ((my_ypos > uy)?(my_ypos - uy):(uy - my_ypos))+
                             ((ux > lx)?(ux - lx):(lx - ux))+
                             ((uy > ly)?(uy - ly):(ly - uy))+
                             ((lx > dx)?(lx - dx):(dx - lx))+
                             ((ly > dy)?(ly - dy):(dy - ly))+
                             ((dx > dst_xpos)?(dx - dst_xpos):(dst_xpos - dx))+
                             ((dy > dst_ypos)?(dy - dst_ypos):(dst_ypos - dy));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end else if (my_xpos > ux && my_ypos > ry) begin
                    if (dst_xpos <= dx) begin
                        //C->D
                        d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        //C->d->r->u->l->D
                        d2 = 100;
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end else if (dst_xpos > dx) begin
                        //C->D
                        d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        //C->r->u->l->d->D
                        d2 = 100;
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b11;
                        end else begin
                            ovch0 = 2'b00;
                        end
                    end
                end
            end else if (my_xpos == dst_xpos && my_ypos > dst_ypos) begin //Y-
                if (my_xpos <= dx && my_ypos <= ly) begin
                    if (dst_xpos <= ux) begin
                        // C -> l -> D
                        d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                             ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                             ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                             ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                        // C -> d -> r -> u -> D
                        d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > rx)?(dx - rx):(rx - dx))+
                             ((dy > ry)?(dy - ry):(ry - dy))+
                             ((rx > ux)?(rx - ux):(ux - rx))+
                             ((ry > uy)?(ry - uy):(uy - ry))+
                             ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                             ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));    
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > ux) begin
                        // C -> l -> u -> D
                        d1 = ((my_xpos > lx)?(my_xpos - lx):(lx - my_xpos))+ 
                             ((my_ypos > ly)?(my_ypos - ly):(ly - my_ypos))+
                             ((lx > ux)?(lx - ux):(ux - lx))+
                             ((ly > uy)?(ly - uy):(uy - ly))+
                             ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                             ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                        // C -> d -> r -> D
                        d2 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > rx)?(dx - rx):(rx - dx))+
                             ((dy > ry)?(dy - ry):(ry - dy))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end 
                    end
                end else if (my_xpos <= dx && my_ypos > ly) begin
                    if (dst_xpos <= ux) begin
                        //C->D
                        d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        //C->l->d->r->u->D
                        d2 = 100;
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > ux) begin
                        //C->D
                        d1 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        //C->u->l->d->r->D
                        d2 = 100;
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end
                end else if (my_xpos > dx && my_ypos <= ry) begin
                    if (dst_xpos <= ux) begin
                        //C->u->r->d->l->D
                        d1 = 100;
                        //C->D
                        d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end else if (dst_xpos > ux) begin
                        //C->r->d->l->u->D
                        d1 = 100;
                        //C->D
                        d2 = ((my_xpos > dst_xpos)?(my_xpos - dst_xpos):(dst_xpos - my_xpos))+ 
                             ((my_ypos > dst_ypos)?(my_ypos - dst_ypos):(dst_ypos - my_ypos));
                        b_to_mini = 1;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end
                    end
                end else if (my_xpos > dx && my_ypos > ry) begin
                    if (dst_xpos <= ux) begin
                        // C -> d -> l -> D
                        d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > lx)?(dx - lx):(lx - dx))+
                             ((dy > ly)?(dy - ly):(ly - dy))+
                             ((lx > dst_xpos)?(lx - dst_xpos):(dst_xpos - lx))+
                             ((ly > dst_ypos)?(ly - dst_ypos):(dst_ypos - ly));
                        // C -> r -> u -> D
                        d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                             ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                             ((rx > ux)?(rx - ux):(ux - rx))+
                             ((ry > uy)?(ry - uy):(uy - ry))+
                             ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                             ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end 
                    end else if (dst_xpos > ux) begin
                        // C -> d -> l -> u -> D
                        d1 = ((my_xpos > dx)?(my_xpos - dx):(dx - my_xpos))+
                             ((my_ypos > dy)?(my_ypos - dy):(dy - my_ypos))+
                             ((dx > lx)?(dx - lx):(lx - dx))+
                             ((dy > ly)?(dy - ly):(ly - dy))+
                             ((lx > ux)?(lx - ux):(ux - lx))+
                             ((ly > uy)?(ly - uy):(uy - ly))+
                             ((ux > dst_xpos)?(ux - dst_xpos):(dst_xpos - ux))+
                             ((uy > dst_ypos)?(uy - dst_ypos):(dst_ypos - uy));
                        // C -> r -> D
                        d2 = ((my_xpos > rx)?(my_xpos - rx):(rx - my_xpos))+
                             ((my_ypos > ry)?(my_ypos - ry):(ry - my_ypos))+
                             ((rx > dst_xpos)?(rx - dst_xpos):(dst_xpos - rx))+
                             ((ry > dst_ypos)?(ry - dst_ypos):(dst_ypos - ry));
                        b_to_mini = 0;
                        if (d1 <= d2) begin
                            ovch0 = 2'b01;
                        end else begin
                            ovch0 = 2'b10;
                        end 
                    end
                end
            end
        end
    end
endmodule