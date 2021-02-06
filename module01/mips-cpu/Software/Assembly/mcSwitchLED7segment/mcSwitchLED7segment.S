/* This routine is based on the interrupt service assembly code */
/* A routine to write an accending pattern to 7 segment display */
/* has been added */
/* Define symbols */

.set noreorder 
.text
                   #                           %
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

 

