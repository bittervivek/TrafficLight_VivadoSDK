module vga_control(
    input                     CLK,
input              [11:0] COLOUR_IN,
output     reg      [9:0] ADDRE,
output     reg      [9:0] ADDRV,
output     reg     [11:0] COLOUR_OUT,
output     reg            HS,
output     reg            VS
);




//Time in Front Horizontal Lines
parameter HorzTimeToPulseWidthEnd     =   10'd96;
parameter HorzTimeToBackPorchEnd      =   10'd144;
parameter HorzTimeToDisplayTimeEnd    =   10'd784;
parameter HorzTimeToFrontPorchEnd     =   10'd800;


//Time in Vertical Lines
parameter VertTimeToPulseWidthEnd     =   10'd2;
parameter VertTimeToBackPorchEnd      =   10'd31;
parameter VertTimeToDisplayTimeEnd    =   10'd521;
parameter VertTimeToFrontPorchEnd     =   10'd521;



//wires 
//    wire horz_addr_trig_out;
//    wire vert_addr_trig_out;
//  wire slower_out;
wire [9:0] horz_addr_count_out;
wire [9:0] vert_addr_count_out;

//slower counters
Generic_counter # (.COUNTER_WIDTH(2),
                   .COUNTER_MAX(3)
                  )
                  Slower(
                  .CLK(CLK),
                  .RESET(1'b0),
                  .ENABLE_IN(1'b1),
                  .TRIG_OUT(slower_out)  
                                  
                  );
                  
//Horizontal address counters
Generic_counter # (.COUNTER_WIDTH(10),
                  .COUNTER_MAX(799)
                 )
                 Horizontal_Addr(
                 .CLK(slower_out),
                 .RESET(1'b0),
                 .ENABLE_IN(1'b1),
                 .TRIG_OUT(horz_addr_trig_out), 
                 .COUNT(horz_addr_count_out)                   
                 );
                       
//Vertical address counters
Generic_counter # (.COUNTER_WIDTH(10),
                  .COUNTER_MAX(520)
                 )
                 Vertical_Addr(
                 .CLK(horz_addr_trig_out),
                 .RESET(1'b0),
                 .ENABLE_IN(1'b1),
                 .TRIG_OUT(vert_addr_trig_out), 
                 .COUNT(vert_addr_count_out)                   
                 );                          

//Horizontal control
always@(posedge CLK) begin
  if (horz_addr_count_out < HorzTimeToPulseWidthEnd)     
    HS <= 0;
  else
    HS <= 1; 
end                     

//Vertical control
always@(posedge CLK) begin
  if (vert_addr_count_out < VertTimeToPulseWidthEnd)     
    VS <= 0;
  else
    VS <= 1;  
end   

    
always@(posedge CLK) begin
  if((horz_addr_count_out > HorzTimeToBackPorchEnd) && (horz_addr_count_out < HorzTimeToDisplayTimeEnd))
      ADDRE <= horz_addr_count_out - 144;
  else
      ADDRE <= 0;
end


always@(posedge CLK) begin
  if((vert_addr_count_out > VertTimeToBackPorchEnd) && (vert_addr_count_out < VertTimeToDisplayTimeEnd))
      ADDRV <= vert_addr_count_out - 31;
  else
      ADDRV <= 0;
end
       
       
always@(posedge CLK) begin
  if((horz_addr_count_out > HorzTimeToBackPorchEnd) && (horz_addr_count_out < HorzTimeToDisplayTimeEnd)&&(vert_addr_count_out > VertTimeToBackPorchEnd) && (vert_addr_count_out <  VertTimeToDisplayTimeEnd))
      COLOUR_OUT <= COLOUR_IN;
//          ADDRV <= vert_addr_count_out ;
//           ADDRE <= horz_addr_count_out;
       
  else
      COLOUR_OUT <= 0;
//          ADDRV <= 0;
//          ADDRE<=0;
//          end
end    
                        
endmodule