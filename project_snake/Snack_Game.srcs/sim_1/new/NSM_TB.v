`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2016 10:41:31
// Design Name: 
// Module Name: NSM_TB
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


module NSM_TB(

    );
 reg CLK;
 reg BTNL;
 reg BTNR;
 reg RESET;
 reg BTNU;
 reg BTND;
 wire [1:0]Direction_state;
        
        Navigation_State_Machine uut2(
                                 .CLK(CLK),
                                 .BTNL(BTNL),
                                 .BTNR(BTNR),
                                 .BTNU(BTNU),
                                 .BTND(BTND),
                                 .RESET(RESET),
                                 .Direction_state(Direction_state)
                                 );
        
        
        initial begin
            CLK = 0;
            forever #50 CLK = ~CLK;
        end
        
        initial begin
            RESET = 1;
            #60 RESET = 0;
        end
        
        initial begin
            BTNL = 0;
            #150 BTNL = ~BTNL;
        end
        
        initial begin
            BTNR = 0;
            #350 BTNR = ~BTNR;
        end
        
        initial begin
            BTNU = 0;
            #450 BTNU = ~BTNU;
        end
        
        initial begin
            BTND = 0;
            #250 BTND = ~BTND;
        end
        
        
    endmodule

