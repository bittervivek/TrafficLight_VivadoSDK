module Navigation_State_Machine(
input CLK,
input BTNU,
input BTNL,
input BTNR,
input BTND,
input RESET,
output [1:0] Direction_state

    );
    
    reg [1:0] Curr_State;
    reg [1:0] Next_State;
    
    always@(posedge CLK)begin
          if(RESET)begin
             Curr_State <= 4'h0;
          end
                                                    
          else begin
             Curr_State <= Next_State;  
          end
      end
      
    always@(Curr_State or BTNL or BTNU or BTNR or BTND )begin
          case (Curr_State)
          2'b00    :   begin//up
               if (BTNL) begin
                   Next_State <= 2'b01;
               end  
               else if (BTNR) begin
                   Next_State <= 2'b10;
               end  
               else begin
                   Next_State <= Curr_State;
               end      
          end
                                         
                 
                                         
          2'b01    :   begin//left
               if (BTNU) begin
                   Next_State <= 2'b00;
               end
               else if (BTND) begin
                   Next_State <= 2'b11;
               end
               else begin
                   Next_State <= Curr_State;
               end
           end
                 
                 
          2'b10    :   begin//right
               if (BTNU) begin
                   Next_State <= 2'b00;
               end
               else if (BTND) begin
                   Next_State <= 2'b11;
               end
               else begin
                   Next_State <= Curr_State;
               end
          end     
          
          2'b11    :   begin//down
              if (BTNL) begin
                  Next_State <= 2'b01;
              end  
              else if (BTNR) begin
                  Next_State <= 2'b10;
              end  
              else begin
                  Next_State <= Curr_State;
              end      
          end     
       endcase
    end    
            
     assign Direction_state = Curr_State;       
            
endmodule
