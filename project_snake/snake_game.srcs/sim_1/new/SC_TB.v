`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/17 22:10:36
// Design Name: 
// Module Name: SC_TB
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


module SC_TB(

    );
    
    reg CLK;
    reg RESET;
    //input Counter,
    reg [9:0] Pixel_Address_X;
    reg [8:0] Pixel_Address_Y;
    reg [7:0] Random_Target_Address_X;
    reg [6:0] Random_Target_Address_Y;
    reg [1:0] Direction_state;
   // input [1:0] MSM_State,
    reg [11:0] Colour;
    reg REACHED_TARGET;
    
    snake_control uut6(
                        .CLK(CLK),
                        .RESET(RESET),
                        .Pixel_Address_X(Pixel_Address_X),
                        .Pixel_Address_Y(Pixel_Address_Y),
                        .Random_Target_Address_X(Random_Target_Address_X),
                        .Random_Target_Address_Y(Random_Target_Address_Y),
                        .Direction_state(Direction_state),
                        .Colour(Colour),
                        .REACHED_TARGET(REACHED_TARGET)
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
     Pixel_Address_X = 80;
     Pixel_Address_Y = 60;
     Random_Target_Address_X =10 ;
     Random_Target_Address_Y =20 ;
     
     end  
     
     initial begin
     #150 Direction_state = 2'b01;
     #300 Direction_state = 2'b10;
     end                 
endmodule
