`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2016 13:23:10
// Design Name: 
// Module Name: Target_TB
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


module Target_TB(

    );
         reg   RESET;
      reg   CLK;
      reg   REACHED_TARGET;
       //input     [14:0]     seed,
      wire  [7:0]     rand_num_X;
      wire  [6:0]     rand_num_Y;
      
    Target_Generator uut5(
                          .RESET(RESET),
                          .CLK(CLK),
                          .REACHED_TARGET(REACHED_TARGET),
                          .rand_num_X(rand_num_X),
                          .rand_num_Y(rand_num_Y)
                          );
    
 
      
      
      initial begin
      CLK = 0;
      forever #50 CLK = ~CLK;
      end
      
      initial begin
      RESET = 1;
      #60 RESET  = 0;
      end
      
      initial begin
      REACHED_TARGET = 0;
      forever #150 REACHED_TARGET = ~REACHED_TARGET;
      end
      
endmodule
