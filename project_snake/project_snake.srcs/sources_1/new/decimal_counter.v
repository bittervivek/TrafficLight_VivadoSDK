`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2016 12:54:45
// Design Name: 
// Module Name: decimal_counter
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

module Score_counter(
    input CLK,
    input RESET,
    input REACHED_TARGET,
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT,
    output [3:0] Score
    
    );
wire Bit17TriggOut,Bit4TriggOut0,Bit2TriggOut0;
wire [3:0] DecCount1;
wire [3:0] DecCount2;
wire [1:0] StrobeCount;
    // The 17 bit counter
  /*  Generic_counter # (.COUNTER_WIDTH(17),
                       .COUNTER_MAX(99999)
                       )
                       Bit17Counter(
                       .CLK(CLK),
                       .RESET(1'b0),
                       .ENABLE_IN(1'b1),
                       .TRIG_OUT(Bit17TriggOut)                    
                       );*/
      // The 2 bit counter
     Generic_counter # (.COUNTER_WIDTH(2),
                        .COUNTER_MAX(3)
                            )
                            Bit2Counter(
                            .CLK(CLK),
                            .RESET(1'b0),
                            .ENABLE_IN(1'b1),
                            .TRIG_OUT(Bit2TriggOut0),
                            .COUNT(StrobeCount)
                             );
    //Five 4_bit counter
    Generic_counter # (.COUNTER_WIDTH(4),
                           .COUNTER_MAX(9)
                           )
                           Bit4Counter0(
                           .CLK(CLK),
                           .RESET(RESET),
                           .ENABLE_IN(REACHED_TARGET),
                           .TRIG_OUT(Bit4TriggOut0),
                           .COUNT(DecCount1)
                           );
                          
     
      Generic_counter # (.COUNTER_WIDTH(4),
                         .COUNTER_MAX(1) )
                     Bit4Counter1(
                         .CLK(CLK),
                         .RESET(RESET),
                         .ENABLE_IN(Bit4TriggOut0),
                         .TRIG_OUT(Bit4TriggOut1),
                         .COUNT(DecCount2));
      /* Generic_counter # (.COUNTER_WIDTH(4),
                           .COUNTER_MAX(9)  )
                        Bit4Counter2(
                               .CLK(CLK),
                               .RESET(RESET),
                               .ENABLE_IN(Bit4TriggOut1),
                               .TRIG_OUT(Bit4TriggOut2),
                               .COUNT(DecCount2));
     Generic_counter # (.COUNTER_WIDTH(4),
                        .COUNTER_MAX(9)  )
                  Bit4Counter3(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(Bit4TriggOut2),
                        .TRIG_OUT(Bit4TriggOut3),
                        .COUNT(DecCount3));
      Generic_counter # (.COUNTER_WIDTH(4),
                         .COUNTER_MAX(9)  )
               Bit4Counter4(
                .CLK(CLK),
                .RESET(RESET),
                .ENABLE_IN(Bit4TriggOut3),
                .TRIG_OUT(Bit4TriggOut4),
                .COUNT(DecCount4));*/
     
 wire [4:0] DecCountAndDOT1;
 wire [4:0] DecCountAndDOT2;
 wire [4:0] DecCountAndDOT3;
 wire [4:0] DecCountAndDOT4;   
 
 wire [4:0] MuxOut;
 assign DecCountAndDOT1={1'b0,DecCount1};
 assign DecCountAndDOT2={1'b0,DecCount2};
 assign DecCountAndDOT3=5'b00000;
 assign DecCountAndDOT4=5'b00000;
 assign Score = DecCount2*10 + DecCount1;
 
 Multiplexer_4way Mux4(
             .CONTROL(StrobeCount),
             .IN0(DecCountAndDOT1),
             .IN1(DecCountAndDOT2),
             .IN2(DecCountAndDOT3), 
             .IN3(DecCountAndDOT4),
             .OUT(MuxOut));
             
   Decording_the_world Seg7(
               .SEG_SELECT_IN(StrobeCount),
               .BIN_IN(MuxOut[3:0]),
               .DOT_IN(MuxOut[4]),
               .SEG_SELECT_OUT(SEG_SELECT),
               .HEX_OUT(DEC_OUT));
endmodule

