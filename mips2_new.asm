.data			# What follows will be data
inputString: .space 64	# set aside 64 bytes to store the input string
prompt: .asciiz ">>>"
newLine : .asciiz "\n"
Errorp : .asciiz "please enter a valid expression"
newent: .asciiz "New user input now--which is "
valid: .asciiz "Valid"
myT2: .space 6
.text
main:
mul $t3,$t3,0
mul $t0,$t0,0 #### after coming back for done we want to start over from the first byte of string
mul $t2,$t2,0

mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0

li $v0,4
la $a0,valid
syscall

li $v0, 4
la $a0,newLine
syscall
# prompt 1 print out	`
li $v0, 4
la $a0,prompt
syscall

# Have to check if the input is valid.
# get user input for prompt 1.

la $a0,inputString
li $a1,64
li $v0, 8
syscall


addi $s1,$s1,1

space:## eliminate any space in the string.

lb $t2,inputString($t0)
addi $t0, $t0, 1
beq $t2,' ',done
beq $t2, '\n', blank
j space

blank:
mul $t0, $t0, 0
j alpha
alpha: ## look for the first charecter


lb $t2,inputString($t0)
addi $t0, $t0, 1

beq $t2, '\n', main
sle $t4,$t2,'Z'
sge $t5,$t2,'A'
and $t6,$t4,$t5
beq $t6,1,next
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
sle $t4,$t2,'z'
sge $t5,$t2,'a'
and $t6,$t4,$t5
beq $t6,1,next
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
sle $t4,$t2,'9'
sge $t5,$t2,'0'
and $t6,$t4,$t5
beq $t6,1,next
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0

j alpha



next: ### look for the next charecter
lb $s3,inputString($t0)
beq $s3,'\n',printval # branch to check the values of previously saved variables
beq $t2,$s0, pro1  ## check if the present first charecter input has already been used.
bne $s0,$s2, pro2  ## check if the two saved variables are same.

pro1:
sle $t4,$s3,'Z'
sge $t5,$s3,'A'
and $t6,$t4,$t5
beq $t6,1,done
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
sle $t4,$s3,'z'
sge $t5,$s3,'a'
and $t6,$t4,$t5
beq $t6,1,done
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
sle $t4,$s3,'9'
sge $t5,$s3,'0'
and $t6,$t4,$t5
beq $t6,1,done
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0

beq $s3, '=',next2
beq $s3, '+',addition # just had been replaced according to the arithmetic operation.

j alpha

addition:
sle $t4,$t2,'9'
sge $t5,$t2,'0'
and $t6,$t4,$t5
beq $t6,1,nextadd
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0


beq $s0,0,done
beq $s2,0,done
beq $s0,$t2,nextchar #only branch if the present character is equal to the any of the saved variable
beq $s2,$t2,nextchar


j done

nextchar:


addi $t0, $t0, 1
lb $t1,inputString($t0)
beq $s2,$t1,addchar
beq $s0,$t1,addchar

j done

addchar:
add $s5,$t7,$t8
li $v0, 4
la $a0,newLine

syscall

li $v0,1
move $a0,$s5
syscall
li $v0, 4
la $a0,newLine

syscall
j main



nextadd:
addi $t0, $t0, 1
lb $t1,inputString($t0)
sle $t4,$t1,'9'
sge $t5,$t1,'0'
and $t6,$t4,$t5
beq $t6,1,immadd
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
j done

immadd:
add $s4,$t2,$t1
sub $s4,$s4,96

li $v0, 4
la $a0,newLine

syscall

li $v0,1
move $a0,$s4
syscall
li $v0, 4
la $a0,newLine

syscall
j main



next2:
addi $t0, $t0, 1
lb $t1,inputString($t0)
sle $t4,$t1,'9'
sge $t5,$t1,'1'
and $t6,$t4,$t5
beq $t6,1,value
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
j done

value:
move $t7,$t1
sub $t7,$t7,48
move $s0,$t2

li $v0, 4
la $a0,newLine

syscall

li $v0,1
move $a0,$t7
syscall
li $v0, 4
la $a0,newLine

syscall
j main

printval:
beq $t7,0, alpha
bne $s0,$t2, printval2
li $v0, 4
la $a0,newLine
syscall

li $v0,1
move $a0,$t7
syscall
li $v0, 4
la $a0,newLine
syscall

j main
##########################################################################
pro2:
sle $t4,$s3,'Z'
sge $t5,$s3,'A'
and $t6,$t4,$t5
beq $t6,1,done
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
sle $t4,$s3,'z'
sge $t5,$s3,'a'
and $t6,$t4,$t5
beq $t6,1,done
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
sle $t4,$s3,'9'
sge $t5,$s3,'0'
and $t6,$t4,$t5
beq $t6,1,done
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0

beq $s3, '=',next3
beq $s3, '+',addition

j alpha

next3:
addi $t0, $t0, 1
lb $t1,inputString($t0)
sle $t4,$t1,'9'
sge $t5,$t1,'1'
and $t6,$t4,$t5
beq $t6,1,value2
mul $t4,$t4,0
mul $t5,$t5,0
mul $t6,$t6,0
j done



value2:
move $t8,$t1
sub $t8,$t8,48
move $s2,$t2

li $v0, 4
la $a0,newLine

syscall

li $v0,1
move $a0,$t8
syscall
li $v0, 4
la $a0,newLine

syscall
j main

printval2:
beq $t8,0, alpha
bne $s2,$t2, done
li $v0, 4
la $a0,newLine
syscall

li $v0,1
move $a0,$t8
syscall
li $v0, 4
la $a0,newLine
syscall
j main


done:
li $v0,4
la $a0,Errorp
syscall
li $v0, 4
la $a0,newLine
syscall
li $v0, 4
la $a0,newent
syscall
li $v0, 4
la $a0,newLine
syscall
j main
