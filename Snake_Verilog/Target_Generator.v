`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 15.11.2016 13:29:44
// Design Name:
// Module Name: Target_Generator
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


module Target_Generator(
    input                RESET,
    input                CLK,
    input                triger,
    input     [15:0]     seed,
    output    [7:0]     rand_num_X,
    output    [6:0]     rand_num_Y
    );

    reg  [7:0] number_X;
    reg  [6:0] number_Y;

    always@(posedge CLK) begin
        if (RESET)
            number_X  <= 8'b0;
            number_Y  <= 7'b0;

        else if (triger)
            number_X  <= seed[7:0];
            number_Y  <= seed[15:8];
        else begin
            number_X[0] <= number[7];
            number_X[1] <= number_X[0];
            number_X[2] <= number_X[1];
            number_X[3] <= number_X[2];
            number_X[4] <= number_X[3];
            numbnumber_Xer[5] <= number_X[4]^number_Y[2];
            number_X[6] <= number_X[5];
            number_X[7] <= number_X[6];
            number_Y[0] <= number_X[7];
            number_Y[1] <= number_Y[0]^number_Y[6];
            number_Y[2] <= number_Y[1];
            number_Y[3] <= number_Y[2];
            number_Y[4] <= number_Y[3]^number_Y[6];
            number_Y[5] <= number_Y[4]^number_Y[6];
            number_Y[6] <= number_Y[5];

            end
        end

    assign rand_num_X = number_X;
    assign rand_num_Y = number_Y;


endmodule
