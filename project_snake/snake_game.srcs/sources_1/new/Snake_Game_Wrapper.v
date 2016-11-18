`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/17 23:20:12
// Design Name: 
// Module Name: Snake_Game_Wrapper
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


module Snake_Game_Wrapper(
input CLK,
input RESET,
input BTNL,
input BTNR,
input BTNU,
input BTND,

output    [11:0] COLOUR_OUT,
output    [3:0]  SEG_SELECT_OUT,
output    [7:0]  HEX_OUT,
output           HS,
output           VS
//output [7:0] LED_OUT

    );
    
    wire MSM_State;
    wire Direction_state;
    wire REACHED_TARGET;
    wire Score;
    wire Colour;
    wire rand_num_X;
    wire rand_num_Y;
    wire [9:0]  ADDRv;
    wire [9:0]  ADDRh;
    wire Counter;
    wire     [3:0]      COUNT;
    wire     [14:0]     seed;
    wire     [7:0]      AddrX;
    wire     [6:0]      AddrY;
    
    Master_State_Machine MSM(
                            .CLK(CLK),
                            .RESET(RESET),
                            .BTNL(BTNL),
                            .BTNR(BTNR),
                            .BTNU(BTNU),
                            .BTND(BTND),
                            .Score(Score),
                            .MSM_State(MSM_State)
                            );
                            
    Navigation_State_Machine  NSM(
                                 .CLK(CLK),
                                 .RESET(RESET),
                                 .BTNL(BTNL),
                                 .BTNR(BTNR),
                                 .BTNU(BTNU),
                                 .BTND(BTND),
                                 .Direction_state(Direction_state)  
                                 );
                                 
    Target_Generator TG(
                        .CLK(CLK),
                        .RESET(RESET),
                        .REACHED_TARGET(REACHED_TARGET),
                        .Counter(Counter),
                        .COUNT,
                        .seed,
                        .AddrX(AddrX),
                        .AddrY(AddrY),
                        .rand_num_X(rand_num_X),
                        .rand_num_Y(rand_num_Y)
                        );
     
     snake_control SnakeC(
                      .CLK(CLK),
                      .RESET(RESET), 
                      .MSM_State(MSM_State),
                      .AddrX(AddrX),
                      .AddrY(AddrY),
                      .Counter(Counter), 
                      .Pixel_Address_X(ADDRh),
                      .Pixel_Address_Y(ADDRv),
                      .Random_Target_Address_X(rand_num_X),
                      .Random_Target_Address_Y(rand_num_Y),
                      .Direction_state(Direction_state),
                      .Colour(Colour),
                      .REACHED_TARGET(REACHED_TARGET)
                      );
        
     Score_counter  ScoreC(
                           .CLK(CLK),
                           .RESET(RESET),
                           .REACHED_TARGET(REACHED_TARGET),
                           .SEG_SELECT(SEG_SELECT_OUT),
                           .DEC_OUT(HEX_OUT),
                           .Score(Score)
                           );
      
    VGA_Wrapper VW(
                   .CLK(CLK),
                   .COLOUR_IN(Colour),
                   .MSM_State(MSM_State),
                   .COLOUR_OUT(COLOUR_OUT),
                   .HS(HS),
                   .VS(VS),
                   .ADDRE(ADDRh),
                   .ADDRV(ADDRv)
                   );
                   
                   
                   
                                                   
endmodule
