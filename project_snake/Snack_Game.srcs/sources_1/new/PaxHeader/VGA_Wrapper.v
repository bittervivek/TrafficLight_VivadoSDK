module VGA_Wrapper(

                    input            CLK,
                    input     [11:0] COLOUR_IN,
                    output    [11:0] COLOUR_OUT,
                    output           HS,
                    output           VS
                    );
                    
    //Outputs  address preceded by wire
    wire  [9:0]  ADDRE;
    wire  [9:0]  ADDRV;
    
    //Define the value to get colour
    reg  [11:0]  change_colour_count_out;
    reg  [11:0] Colour; 
    reg [11:0] X;
    
    //to let the cube move along the border
    reg  [10:0]  H;
    reg   [9:0]  V;

/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
 
   //Instantiatiation of the vga_control 
   vga_control(
              .CLK(CLK),
              .COLOUR_IN(Colour),
              .COLOUR_OUT(COLOUR_OUT),
              .HS(HS),
              .VS(VS),
              .ADDRE(ADDRE),
              .ADDRV(ADDRV)
              );
   
  //Instantiation for a 100HZ clock                   
    Generic_counter # (.COUNTER_WIDTH(21),
                        .COUNTER_MAX(999999)
                       )
                       Slower_1(
                              .CLK(CLK),
                              .RESET(1'b0),
                              .ENABLE_IN(1'b1),
                              .TRIG_OUT(Tigg_out_100)  
                              );
                              
    //Instantiation for a 1HZ clock                           
    Generic_counter # (.COUNTER_WIDTH(8),
                       .COUNTER_MAX(99)
                        )
                        Slower_2(
                             .CLK(Tigg_out_100),
                             .RESET(1'b0),
                             .ENABLE_IN(1'b1),
                             .TRIG_OUT(Tigger_out_1) 
                             );
                               
 /******************************************************************************************************************************************************************/
 /******************************************************************************************************************************************************************/
                                                                              
   //a changing colour which will change not in order every second                           
  always@(posedge  Tigger_out_1)begin
               if(  change_colour_count_out >= 12'b111111111111)
                   change_colour_count_out <= 0;
               else  change_colour_count_out <= change_colour_count_out + 12'b000000000011;
               end  
                
  //Because of  Frequency is too big for the board, so it become a different colour             
  always@(posedge  CLK)begin
               if(  X >= 12'b111111111111)
                    X <= 0;
               else  X <= X + 12'b000000000001;
               end  
               
   //Define a counter to shift in Horizontal direction                           
   always@(posedge  Tigger_out_1)begin
                if(  H >= 640)
                     H <= 0;
                else  H <= H + 1;
                end    
   
   //Define a counter to shift in Vertical direction              
   always@(posedge  Tigger_out_1)begin
                if( V >= 480)
                    V <= 0;
                else  V<= V + 1;
                end                
       
  /******************************************************************************************************************************************************************/
  /******************************************************************************************************************************************************************/            
                                                            
   always@(posedge CLK)begin
    //define the cube area and add the variable to move and change the colour every second
    if (((ADDRE >= H)&&(ADDRE <= 10+H)&&(ADDRV >= 0)&&(ADDRV <= 10))
    ||((ADDRE >= 0)&&(ADDRE <= 10)&&(ADDRV <= 480-V)&&(ADDRV >= 470-V))
    ||((ADDRE >= 630)&&(ADDRE <= 640)&&(ADDRV >= 0+V)&&(ADDRV <= 10+V))
    ||((ADDRE >= 630-H)&&(ADDRE <= 640-H)&&(ADDRV <= 480)&&(ADDRV >= 470)))
    Colour <= change_colour_count_out;
    
    //define the first name area and change colour
    else if (((ADDRE >= 220)&&(ADDRE <= 420)&&(ADDRV >= 130)&&(ADDRV <= 150))
    ||((ADDRE + ADDRV >= 550)&&(ADDRE + ADDRV<=580)&&(ADDRE>=220)&&(ADDRE<=420)&&(ADDRV>=80)&&(ADDRV<=400))
    ||((ADDRE >= 220)&&(ADDRE <= 420)&&(ADDRV >= 340)&&(ADDRV <= 360)))
    Colour <= change_colour_count_out + 12'b101010101010;
    
    //define the different circle for beautiful
    else if ((ADDRE*ADDRE + ADDRV*ADDRV <= (15+H+V)*(15+H+V))||((ADDRE-640)*(ADDRE-640) + (ADDRV-480)*(ADDRV-480) <= (15-H-V)*(15-H-V)))
    Colour <= change_colour_count_out + 12'b010101010101;
    else if (((ADDRE-320)*(ADDRE-320) + (ADDRV-240)*(ADDRV-240) >=625)&&((ADDRE-320)*(ADDRE-320) + (ADDRV-240)*(ADDRV-240) <=900))
    Colour <= X + 12'b010010100101;
    else if ((ADDRE*ADDRE + ADDRV*ADDRV <= (15+H+V)*(15+H+V))&&((ADDRE-640)*(ADDRE-640) + (ADDRV-480)*(ADDRV-480) <= (15-H-V)*(15-H-V)))
    Colour <= change_colour_count_out + 12'b100100100100;
    
    //define the background colour
    else
    Colour <= 12'b111111111111;
    end
  
endmodule
