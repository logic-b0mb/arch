/************************************************
  The Verilog HDL code example is from the book
  Computer Principles and Design in Verilog HDL
  by Yamin Li, published by A JOHN WILEY & SONS
************************************************/

`include "mfp_ahb_const.vh"
module mccomp_sys (
    input                   SI_ClkIn,
    input                   SI_Reset_N,
    output [2:0]            q,
    output [31:0]           a,
    output [31:0]           b,
    output [31:0]           alu,
    output [31:0]           adr,
    output [31:0]           tom,
    output [31:0]           fromm,
    output [31:0]           pc,
    output [31:0]           ir,
    input                   memclk,
    input  [`MFP_N_SW-1 :0] IO_Switch,
    input  [`MFP_N_PB-1 :0] IO_PB,
    output [`MFP_N_LED-1:0] IO_LED,
    output [ 7          :0] IO_7SEGEN_N,
    output [ 6          :0] IO_7SEG_N,
    output                  IO_BUZZ,                  
    output                  IO_RGB_SPI_MOSI,
    output                  IO_RGB_SPI_SCK,
    output                  IO_RGB_SPI_CS,
    output                  IO_RGB_DC,
    output                  IO_RGB_RST,
    output                  IO_RGB_VCC_EN,
    output                  IO_RGB_PEN,
    output                  IO_CS,
    output                  IO_SCK,
    input                   IO_SDO,
    input                   UART_RX,
    inout[4:1]              JB
    );

     wire[31:0] data_cpu; //data driven by cpu
     wire[31:0] data_mem; //data driven by data memory
     wire[31:0] data_gpio; //data driven by GPIO module
     wire[31:0] memout;
     
     wire dbg_resetn_cpu;
     wire dbg_halt_cpu;
     
     wire          wmem;                           // write data memory
     wire clk;
     wire clrn;
     assign clk=SI_ClkIn;
     assign clrn = SI_Reset_N & dbg_resetn_cpu;
 // Check if memory mapped I/O
     wire[2:0] HSEL;
     
    mccpu mc_cpu (clk,clrn,memout,pc,ir,a,b,alu,wmem,adr,data_cpu,q);    // cpu
    mccomp_decoder mccomp_decoder(adr,HSEL);

    //Be sure to use forward slashes '/', even on Windows
    parameter RAM_FILE = "/home/besernd1/Downloads/Distro/mips-cpu/Software/Assembly/mc7segment/mem.mem";

    wire[31:0] dbg_mem_addr;
    wire[31:0] dbg_mem_din;
    wire dbg_mem_cs;
    wire dbg_mem_we;

    wire effectiveMemWE = dbg_mem_cs ? dbg_mem_we : wmem;
    wire effectiveMemCE = dbg_mem_cs | HSEL[1];
    wire[31:0] effectiveMemAddr = dbg_mem_cs ? dbg_mem_addr : adr;
    wire[31:0] effectiveRAMDataInput = dbg_mem_we ? dbg_mem_din : memout;
    uram #(.A_WIDTH(9), .INIT_FILE(RAM_FILE), .READ_DELAY(0)) system_ram
        (.clk(clk), .we(effectiveMemWE), .cs(effectiveMemCE), .addr(effectiveMemAddr), .data_in(effectiveRAMDataInput), .data_out(data_mem));
 
 
    cpugpio gpio (.clk(clk),
        .clrn(clrn),
        .dataout(data_gpio),
        .datain(memout),
        .haddr(adr[5:2]),
        .we(wmem),
        .HSEL(HSEL[2]),
        .IO_Switch(IO_Switch),
        .IO_PB(IO_PB),
        .IO_LED(IO_LED),
        .IO_7SEGEN_N(IO_7SEGEN_N),
        .IO_7SEG_N(IO_7SEG_N),
        .IO_BUZZ(IO_BUZZ),                
        .IO_RGB_SPI_MOSI(IO_RGB_SPI_MOSI),
        .IO_RGB_SPI_SCK(IO_RGB_SPI_SCK),
        .IO_RGB_SPI_CS(IO_RGB_SPI_CS),
        .IO_RGB_DC(IO_RGB_DC),
        .IO_RGB_RST(IO_RGB_RST),
        .IO_RGB_VCC_EN(IO_RGB_VCC_EN),
        .IO_RGB_PEN(IO_RGB_PEN),
        .IO_SDO(IO_SDO),
        .IO_CS(IO_CS),
        .IO_SCK(IO_SCK));
    
    assign memout = wmem ? data_cpu :
                    HSEL[1] ? data_mem :
                    HSEL[2] ? data_gpio :
                    32'b0;
                    
     debug_control debug_if(.serial_tx(JB[2]), .serial_rx(JB[3]), .cpu_clk(clk),
        .sys_rstn(SI_Reset_N), .cpu_imem_addr(dbg_imem_addr), 
        .cpu_debug_to_imem_data(dbg_imem_din), .cpu_imem_to_debug_data(inst),
        .cpu_imem_we(dbg_imem_we), .cpu_imem_ce(dbg_imem_ce),
        .cpu_dmem_addr(dbg_dmem_addr), .cpu_debug_to_dmem_data(dbg_dmem_din),
        .cpu_imem_to_debug_data_ready(dbg_imem_ce & ~dbg_imem_we),
        .cpu_dmem_to_debug_data_ready(dbg_dmem_ce & ~dbg_dmem_we),
        .cpu_dmem_to_debug_data(data_mem), .cpu_dmem_we(dbg_dmem_we),
        .cpu_dmem_ce(dbg_dmem_ce), .cpu_resetn_cpu(dbg_resetn_cpu),
        .cpu_halt_cpu(dbg_halt_cpu));

                                        
endmodule
