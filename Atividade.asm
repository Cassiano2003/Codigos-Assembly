.data
msg: 		.ascii				"A soma é: "
fim:			.ascii				 "Fim do programa!!!"

.text
_start:
	jal		 main			# Vai para a main
	addi 		$v0, $zero, 10		#Set syscol para exis
	syscall					#finaliza o progama

main:
	addi		$sp, $sp, -12		#Alocando 2 ints
	sw		$ra, 8($sp)		#Guarda o ra
	sw 		$fp, 4($sp)		#salvando o fp
	sw 		$s0, 0($sp)		#Salvando o s0
	addi 		$fp, $sp,4			#inicio do stackFrame
	
	la		$a0, msg			#Caregando mensagem
	addi 		$t2, $zero, 10		#t0 <- 10
	addi 		$a1, $t2, 5			#a1 <- 5
	

	jal		print				#Print
	
	
	lw		$ra, 8($sp)		#Carega o ra
	lw		$fp,  4($sp)		#Restaura o fp
	lw		$s0, 0($sp)		#Restalra o s0
	addi		$sp, $sp, 4		#Restaura o sp
	
	
	jr		$ra				#Return
	
print:
	addi 		$v0,  $zero,  4		#Print string
	syscall					#Imprime a string

	addi		$v0, $zero,  1		#Pirnt ints
	add		$a0,$zero, $a1		#a0 <- a1
	syscall

	addi		$v0,$zero, 11		#print char
	addi		$a0,$zero, '\n'		#print \n
	syscall

	addi		$v0, $zero,  4		#Pirnt ints
	add		$a0,$zero, $a2		#a0 <- a1
	syscall
	
	jr		$ra				#Return
	
