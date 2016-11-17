`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2016 11:34:02
// Design Name: 
// Module Name: VGA_TB
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


module VGA_TB(

    );
    reg CLK;
    reg [11:0] COLOUR_IN;
    wire [9:0] ADDRE;
    wire [9:0] ADDRV;
    wire [11:0] COLOUR_OUT;
    wire HS;
    wire VS;
    
    vga_control uut(
                    .CLK(CLK),
                    .COLOUR_IN(COLOUR_IN),
                    .ADDRE(ADDRE),
                    .ADDRV(ADDRV),
                    .COLOUR_OUT(COLOUR_OUT),
                    .HS(HS),
                    .VS(VS)
                    );
                    
    initial begin
        CLK = 0;
        forever #20 CLK = ~CLK;
    end
    
    initial begin
        COLOUR_IN = 12'b 111111111111;
        forever #20 COLOUR_IN = COLOUR_IN + 12'b 000000000001; 
    end
endmodule
