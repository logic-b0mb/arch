/* This routine is based on the interrupt service assembly code */
/* A routine to write an accending pattern to 7 segment display */
/* has been added */
/* Define symbols */
c0_cause = $13
c0_epc = $14
c0_status = $12
.set noreorder 
.text
    j    start             # entry on reset            %
    nop                    #                           %
exc_base:                  # exception handler         %
    mfc0 $26, c0_cause     # read cp0 cause reg        %
    andi $27, $26, 0xc     # get exccode, 2 bits here  %
    lw $27,0x20($27)       # get address from table    %
    nop                    #                           %
    jr   $27               # jump to that address      %
    nop                    #                           %
    nop
    nop
    nop
    nop
int_entry:                 # 0. interrupt handler      %
    nop                    # deal with interrupt here  %
    eret                   # retrun from interrupt     %
    nop                    #                           %
sys_entry:                 # 1. syscall handler        %
    nop                    # do something here         %
epc_plus4:                 #                           %
    mfc0  $26, c0_epc      # get epc                   %
    addi  $26, $26, 4      # epc + 4                   %
    mtc0  $26, c0_epc      # epc <- epc + 4            %
    eret                   # retrun from exception     %
    nop                    #                           %
uni_entry:                 # 2. unimpl. inst. handler  %
    nop                    # do something here         %
    j     epc_plus4        # return                    %
    nop                    #                           %
    nop
    nop
ovf_entry:                 # 3. overflow handler       %
    nop                    # do something here         %
    j     epc_plus4        # return                    %
    nop                    #                           %
start:                     #                           %
    addi $8, $0, 0xf       # im[3:0] <- 1111           %
    mtc0 $8, c0_status     # exc/intr enable           %
    lw   $8, 0x48($0)      # try overflow exception    %
    lw   $9, 0x4c($0)      # caused by add             %
ov:                        #                           %
    add  $8, $8, $9        # overflow                  %
    nop                    #                           %
sys:                       #                           %
    syscall                # system call               %
    nop                    #                           %
unimpl:                    #                           %
     div  $zero, $9, $8    # div, but not implemented  %
    nop                    #                           %
int:                       #                           %
    ori  $4, $1, 0x50      # address of data[0]        %
    addi $5, $0,  4        # counter                   %
    add  $8, $0, $0        # sum <- 0                  %
loop:                      #                           %
    lw   $9, 0($4)         # load data                 %
    addi $4, $4,  4        # address + 4               %
    add  $8, $8, $9        # sum                       %
    addi $5, $5, -1        # counter - 1               %
    bne  $5, $0, loop      # finish?                   %
    nop                    #                           %
finish:                    #                           %
# $8 = I/O base
# $9 = cnt (value to write to 7-segment dislays)
# $10 = 0 and digit values
# $12 = 4 (bit width of digits)
# $13 = temporary variable (holds number of bits to shift left)
# $14 = concatenated value of 8 7-segment display digits 

main:
   lui   $12, 0xbf80    # $12 = address of LEDs (0xbf800000)
   ori $13, $12, 4    # $13 = address of switches
   addi $9, $0, 7         # cnt = 7
   addi  $10, $0, 0x0      # $10 = 0
   sw    $10, 0xc($12)      # enable all 8 of the 7-segment displays
readIO: 	
   lw    $10, 0($13)    # read switches: $10 = switch values
   sw    $10, 0($12)    # write switch values to LEDs 
   sw    $10, 0x10($12) # write the switch values to the 7 segment display in hex
   beq   $0, $0, readIO # repeat
   nop                  # branch delay slot
.data
 
dataspace: .word 0,0,0,0,0,0,0,0
j_table:   .word int_entry
	   .word sys_entry
           .word uni_entry
           .word ovf_entry
           .word 0,0,0,0,0,0
           .word 2
           .word 0x7fffffff
           .word 0xa3
           .word 0x27
           .word 0x79
           .word 0x115
           .word 0,0,0,0,0,0,0,0

