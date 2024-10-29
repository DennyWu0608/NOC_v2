/* 
 * data width 
 *   34 33 32         31 ~ 14    13  12 ---  11 10 9 8 7 6  5 4 3  2 1 0
 * --3 bit type----18 bit data----  vc  ---   SRC_Y  SRC_X  DST_Y  DST_X
 *  前面改位置改成
 *  63 62 61     60 ～ 14
 *  3 bit type    data              剩下一樣                                          
 */

//SD
`define NUM_NODE        2
`define F_NODE          8
`define T_D_WIDTH       64

//
`define DATA_WIDTH      64               
`define DST_LSB         0                   
`define DST_MSB         5                  
`define SRC_LSB         6                  
`define SRC_MSB         11    
//細_位置
`define DSTX_LSB         0
`define DSTX_MSB         2
`define DSTY_LSB         3                         
`define DSTY_MSB         5                  
`define SRCX_LSB         6
`define SRCX_MSB         8
`define SRCY_LSB         9                  
`define SRCY_MSB         11    

//              
`define VCH_LSB         12                  
`define VCH_MSB         13                  

//要改
`define TYPE_LSB        61                  
`define TYPE_MSB        63         

//data flit
`define DATA_LSB        14
`define DATA_MSB        60

/* flit type */
`define TYPEW           3      
`define TYPE_NONE       3'b000  //0
`define TYPE_HEAD       3'b001  //1
`define TYPE_TAIL       3'b010  //2
`define TYPE_HEADTAIL   3'b011  //3
`define TYPE_DATA       3'b100  //4

`define TYPE_ACK        3'b101  //5
`define TYPE_ACK_BACK   3'b110  //6
`define TYPE_TEST       3'b111  //7

/* virtaul channel -VC*/
`define VCH_WIDTH 4 //第 0 1 2 3 通道
`define VCH_WIDTH_NUM 2 // 00 01 10 11

/* port */
`define PORT_NUM 3
`define PORT 5

/* fifo */
`define PACKET_LEN 5

/* dimenion - order for routing data bit */
`define DST_ADDR_WIDTH 6
`define DSTX_POS_LSB 0
`define DSTX_POS_MSB 2
`define DSTY_POS_LSB 3
`define DSTY_POS_MSB 5
