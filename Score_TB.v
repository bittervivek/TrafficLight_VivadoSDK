`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2016 12:07:54
// Design Name: 
// Module Name: Score_TB
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


module Score_TB(

    );    
          reg    CLK;
          reg    RESET;
          reg    REACHED_TARGET;
          wire    [3:0] SEG_SELECT;
          wire    [7:0] DEC_OUT;
          wire    [3:0] Score;
          
    Score_counter uut4(
                       .CLK(CLK),
                       .RESET(RESET),
                       .REACHED_TARGET(REACHED_TARGET),
                       .SEG_SELECT(SEG_SELECT),
                       .DEC_OUT(DEC_OUT),
                       .Score(Score)
                       );
       
       
       

          
          initial begin
          CLK = 0;
          forever #50 CLK=~CLK;
          end
          
          initial begin 
          RESET = 1;
          #60 RESET = 0;
          end
          
          initial begin
          REACHED_TARGET=0;
          forever #150 REACHED_TARGET = ~REACHED_TARGET;
          end
          
endmodule
