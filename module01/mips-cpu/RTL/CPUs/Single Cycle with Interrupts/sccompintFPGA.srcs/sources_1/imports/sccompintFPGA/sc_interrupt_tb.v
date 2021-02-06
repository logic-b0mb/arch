/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/
`include "mfp_ahb_const.vh"
`timescale 1ns/1ns
module sc_interrupt_tb;
   reg         clk,clrn,memclk,intr;
   wire [31:0] inst,pc,aluout,memout;
   wire        inta;
   reg  [`MFP_N_SW-1 :0] IO_Switch;
   reg  [`MFP_N_PB-1 :0] IO_PB;
   wire [`MFP_N_LED-1:0] IO_LED;
   wire [ 4          :1] JA;
   reg  [ 8          :1] JB;
   wire [ 7          :0] AN;
   wire                  CA, CB, CC, CD, CE, CF, CG;
   wire [ 10         :1] JC;
   wire [ 4          :1] JD;
   reg                   UART_RX;
   
      sc_interrupt_sys scint_sys (
                          .SI_ClkIn(clk),
                          .SI_Reset_N(clrn),
                          .inst(inst),
                          .pc(pc),
                          .aluout(aluout),
                          .memout(memout),
                          .memclk(memclk),
                          .intr(intr),
                          .inta(inta),
                          .IO_Switch(IO_Switch),
                          .IO_PB(IO_PB),
                          .IO_LED(IO_LED),
                          .IO_7SEGEN_N(AN),
                          .IO_7SEG_N({CA,CB,CC,CD,CE,CF,CG}), 
                          .IO_BUZZ(),
                          .IO_RGB_SPI_MOSI(JC[2]),
                          .IO_RGB_SPI_SCK(JC[4]),
                          .IO_RGB_SPI_CS(JC[1]),
                          .IO_RGB_DC(JC[7]),
                          .IO_RGB_RST(JC[8]),
                          .IO_RGB_VCC_EN(JC[9]),
                          .IO_RGB_PEN(JC[10]),
                          .IO_CS(JA[1]),
                          .IO_SCK(JA[4]),
                          .IO_SDO(JA[3]),
                          .UART_RX(UART_RX),
                          .JB(JB));
                       
                       
                              initial begin
                                  clk  = 0;
                                  forever
                                       #10 clk = ~ clk;
                                       
                                  end
                              
                              initial begin
                                 memclk = 0;
                                 forever
                                    #5 memclk = ~memclk;
                                 end
                                         
                              initial begin
                                   clrn  = 0;
                                    forever
                                       #5 clrn  = 1;
                                    end
                                          
      initial begin

                                              intr   = 0;
                                         #1240 intr   = 1;
                                         #20 intr   = 0;
                                 
                                     end                    
                             
                           initial begin
                               IO_Switch = 0;
                               forever 
                                 #100000 IO_Switch =16'h5555;
                            end 


endmodule
/*
1   0-140
2 140-280
3 280-420
4 420-560
5 560-700
6 700-840
7 840-980
8 980-1120
*/
