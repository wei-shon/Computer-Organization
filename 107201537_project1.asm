.data 
    inputStr: .asciiz "Give two numbers: "
    outputStr: .asciiz "The GCD of two numbers: "
    endline: .asciiz "\n"
.text
main:
    # Give Input message and store input numbers to $a0 and $a1
    li $v0, 4 #li=load integer
    la $a0, inputStr #la=load address canbe used as the same as li, also can load address into register
    syscall #what syscall do is to watch what number is in $vo
    li $v0, 5 #read input ,this is used to input integer2 into $v0
    syscall
    add $a0, $v0, $zero
    li $v0, 5 #read input ,this is used to input integer2 into $v0
    syscall
    add $a1, $v0, $zero
    # TODO: The condition of the process terminated
    add $t6, $a0, $a1
    beq $t6, $zero, exit 
    # call GCD function recursively
    jal GCD
    add $t0, $v0, $zero

    # print the answer
    li $v0, 4
    la $a0, outputStr
    syscall
    add $a0, $t0, $zero
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, endline
    syscall
    j main
# END Main

GCD:
    # save in the stack
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    add $s0, $a0, $zero
    add $s1, $a1, $zero

    beq $s0, $zero, retGCD

    # TODO: Do Euclidean Algorithm
    blt $a1, $a0, L3
    add $a2, $a1, $zero
    move $a1, $a0
    move $a0, $a2
 L3: div $a1, $a0
    mfhi $t1
    move $a1, $a0
    move $a0, $t1
    beq $t1, $zero, retGCD
    j L3

return:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

retGCD:
    # TODO: What do you need to return?
    move $v0, $a1
    
    
    
    j return
# END GCD

exit:
    # The program is finished running
    li $v0, 10
    syscall
