`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2016 13:28:40
// Design Name: 
// Module Name: Snack_Control
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


module Snake_Control(
    input CLK,
    input RESET,
    input Counter,
    input [9:0] Pixel_Address_X,
    input [8:0] Pixel_Address_Y,
    input [7:0] Random_Target_Address_X,
    input [6:0] Random_Target_Address_Y,
    input [1:0] Direction_state,
    input [1:0] MSM_State,
    output [11:0] Colour,
    output REACHED_TARGET

    );
    
    parameter Snakelength = 20;
    parameter MaxY = 120;
    parameter MaxX = 160;
    
    reg [7:0] SnakeState_X [0: SnakeLength-1];
    reg [6:0] SnakeState_Y [0: SnakeLength-1];
    //parameter 
    
    //Changing the position of the snake registers
    //Shift the SnakeState X and Y
    
    genvar PixNo;
    generate
        for (PixNo = 0; PixNo < Snakelength-1; Pix = PixNo+1)
        begin: PixShift
            always@(posedge CLK) begin
                if (RESET) begin
                    SnakeState_X[PixNo+1] <= 80;
                    SnakeState_Y[PixNo+1] <= 100;
                end
                else if (Counter == 0) begin
                    SnakeState_X[PixNo+1] <= SnakeState_X[PixNo];
                    SnakeState_Y[PixNo+1] <= SnakeState_Y[PixNo];
                end
            end
        end
    endgenerate
    
    //Replace top snake state with new one based on direction
    
    always@(posedge CLK)begin
        if (RESET) begin
            //Set the initial state of the snake
            SnakeState_X[PixNo+1] <= 80;
            SnakeState_Y[PixNo+1] <= 100;
        end
        else if (Counter == 0)begin
            case (Direction_state)
                2'b00   :begin//up
                    if(SnakeState_Y[0]==0)
                        SnakeState_Y[0] <= MaxY;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] - 1;
                end
                    
                2'b01   :begin//left
                    if(SnakeState_X[0]==0)
                        SnakeState_X[0] <= MaxX;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] - 1;
                end
                
                2'b10   :begin//right
                    if(SnakeState_X[0]==MaxX)
                        SnakeState_X[0] <= 0; 
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
                
                2'b11   :begin//down
                    if(SnakeState_Y[0]==MaxY)
                        SnakeState_Y[0] <= 0;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end
                   
            endcase
            
        end
    end
               
endmodule
