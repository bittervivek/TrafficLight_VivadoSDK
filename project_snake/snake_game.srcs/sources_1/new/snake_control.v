`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/16 15:25:29
// Design Name: 
// Module Name: snake_control
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


module snake_control(
  input CLK,
  input RESET,
  //input Counter,
  input [9:0] Pixel_Address_X,
  input [8:0] Pixel_Address_Y,
  input [7:0] Random_Target_Address_X,
  input [6:0] Random_Target_Address_Y,
  input [1:0] Direction_state,
  input [1:0] MSM_State,
  output reg [11:0] Colour,
  output reg REACHED_TARGET,
  output reg Counter,
  output [7:0] AddrX,
  output [6:0] AddrY

  );
  
  parameter SnakeLength = 7;
  parameter MaxY = 119;
  parameter MaxX = 159;
  parameter CounterMax = 500;
//  reg Counter;
  
//  wire [7:0] AddrX;
//  wire [6:0] AddrY;
  
  reg [7:0] SnakeState_X [0: SnakeLength-1];
  reg [6:0] SnakeState_Y [0: SnakeLength-1];
  
  assign AddrX = Pixel_Address_X [9:2];
  assign AddrY = Pixel_Address_Y [8:2];
  
  //parameter 
  always @ ( posedge CLK ) begin
      if (Counter>0)begin
        Counter <= Counter - 1;
        end
      else begin
        Counter <= CounterMax;
     end
  end
  //Changing the position of the snake registers
  //Shift the SnakeState X and Y
  
 
  generate 
  genvar PixNo;
      for (PixNo = 0; PixNo < SnakeLength-1; PixNo = PixNo+1)
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

always@( posedge CLK ) begin
    if (MSM_State == 2'b01)begin
    if ((SnakeState_X[0]==Random_Target_Address_X)&&(SnakeState_Y[0]==Random_Target_Address_Y))
         REACHED_TARGET <= 1;
    else
         REACHED_TARGET <= 0;
     end
end 

always@(posedge CLK) begin
if (MSM_State==2'b01)begin
    if ((AddrX[0]==SnakeState_X[0]) &&(AddrY[0]==SnakeState_Y[0])
        ||(AddrX[1]==SnakeState_X[1]) &&(AddrY[1]==SnakeState_Y[1])
        ||(AddrX[2]==SnakeState_X[2]) &&(AddrY[2]==SnakeState_Y[2])
        ||(AddrX[3]==SnakeState_X[3]) &&(AddrY[3]==SnakeState_Y[3])
        ||(AddrX[4]==SnakeState_X[4]) &&(AddrY[4]==SnakeState_Y[4])
        ||(AddrX[5]==SnakeState_X[5]) &&(AddrY[5]==SnakeState_Y[5])
        ||(AddrX[6]==SnakeState_X[6]) &&(AddrY[6]==SnakeState_Y[6]))  
        Colour <= 12'b000011110000;
    else if ((AddrX==Random_Target_Address_X)&&(AddrY==Random_Target_Address_Y))
        Colour <= 12'b111111110000;
    else
        Colour <= 12'b111111111111;
    end
end         
endmodule
