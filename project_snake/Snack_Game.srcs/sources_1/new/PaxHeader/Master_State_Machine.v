
module Master_State_Machine(
input            CLK,
input            RESET,
input            BTNU,
input            BTNL,
input            BTNR,
input            BTND,
input            Score,
//input     [11:0] COLOUR_IN,
output [1:0] MSM_State
//output    [11:0] COLOUR_OUT,
//output    [3:0]  SEG_SELECT_OUT,
//output    [7:0]  HEX_OUT,
//output           HS,
//output           VS,
//output [7:0] LED_OUT
    );

    reg [1:0] curr_state;
    reg [1:0] next_state;



     always@(posedge CLK)begin
           if(RESET)begin
              curr_state <= 4'h0;
           end

           else begin
              curr_state <= next_state;
           end
        end

     always@(curr_state or BTNL or BTNU or BTNR or BTND or Score)begin
           case (curr_state)
           2'b00    :   begin
               if (BTNL||BTNU||BTNR||BTND)
                   next_state <= 2'b01;

               else
                   next_state <= curr_state;

           end



           2'b01    :   begin
               if (Score==10) begin
                  next_state <= 2'b10;
                  end

               else begin
                  next_state <= curr_state;
                  end
           end


           2'b10    :   begin

                   next_state <= curr_state;
           end

        endcase
     end

     assign MSM_State = curr_state;

endmodule