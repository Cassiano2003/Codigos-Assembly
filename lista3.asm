.data
x:			.ascii				"x  =  "

y:			.ascii				"y  =  "

.text
_start:jal		 main			# Vai para a main
	addi 		$v0, $zero, 10		#Set syscol para exis
	syscall					#finaliza o progama


main:addi		$sp, $sp, -12		#Alocando 2 ints
	sw		$ra, 8($sp)		#Guarda o ra
	sw 		$fp, 4($sp)		#salvando o fp
	sw 		$s0, 0($sp)		#Salvando o s0
	addi 		$fp, $sp,4			#inicio do stackFrame


	addi		$t0,$zero,10		#x = 10
	addi		$t1,$zero,20		#y = 20
	

if:	slt		$t2,$zero,$t0		#x < 0
	beq		$t2,$zero, else		#0 = x
	add		$t1,$t0,$t0		#y = x + x
	add		$t0,$zero,$zero		#x = 0
	j		fimif

else:addi		$t1,$t1,1			#y = y + 1

fimif:add		$a1,$zero,$t0
	add		$a2,$zero,$t1
	la		$a0, x
	la		$a3, y
	jal		print

	lw		$ra, 8($sp)		#Carega o ra
	lw		$fp,  4($sp)		#Restaura o fp
	lw		$s0, 0($sp)		#Restalra o s0
	addi		$sp, $sp, 4		#Restaura o sp
	
	jr		$ra


print:addi 		$v0,  $zero,  4		#Print string
	syscall					#Imprime a string

	addi		$v0, $zero,  1		#Pirnt ints
	add		$a0,$zero, $a1		#a0 <- a1
	syscall

	addi		$v0,$zero, 11		#print char
	addi		$a0,$zero, '\n'		#print \n
	syscall

	addi 		$v0,  $zero,  4		#Print string
	add		$a0,$zero,$a3
	syscall	

	addi		$v0, $zero,  1		#Pirnt ints
	add		$a0,$zero, $a2		#a0 <- a1
	syscall
	
	jr		$ra				#Return
	
