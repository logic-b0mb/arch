.text
.globl main
main:
  addi $t1, $zero, 0
  
  LOOP:
    lw $s1, 0($s0)
    add $s2, $s2, $s1
    addi $s0, $s0, 4
    addi $t1, $t1, 1
    slti $t2, $t1, 100
    bne $t2, $zero, LOOP
  
  nop
  li $v0, 10
  syscall
