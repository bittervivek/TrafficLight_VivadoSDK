`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2016 10:21:14
// Design Name: 
// Module Name: MSM_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MSM_TB(

    );
    reg CLK;
    reg BTNL;
    reg BTNR;
    reg BTNU;
    reg BTND;
    reg RESET;
    reg COLLECT_10_SCORE;
    wire [1:0] MSM_State;
    
    Master_State_Machine uut1(
                             .CLK(CLK),
                             .BTNL(BTNL),
                             .BTNR(BTNR),
                             .BTNU(BNTU),
                             .BTND(BTND),
                             .RESET(RESET),
                             .MSM_State(MSM_State),
                             .COLLECT_10_SCORE(COLLECT_10_SCORE)
                             );
    
    
    initial begin
        CLK = 0;
        forever #50 CLK = ~CLK;
    end
    
    initial begin
        BTNU = 0;
        #150 BTNU = ~BTNU;

    end

    initial begin
        COLLECT_10_SCORE = 0;
        #250 COLLECT_10_SCORE = ~COLLECT_10_SCORE;
    end
    
    initial begin
        RESET = 1;
        #60 RESET = 0;
    end
    
endmodule
