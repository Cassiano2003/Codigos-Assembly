# Faculdade de Computação
# Universidade Federal de Mato Grosso do Sul
# Arquitetura de Computadores I
# Alunos:
#Cassiano Carvalho de Souza
#Aron Petta Sarabia
# Cidigo de ordenaçao HaepSort.

# Endereços na memoria
.data
tam: 		.word 50
vetor: 	.word 52, 81, 11, 18, 63, 29, 65, 22, 64, 8, 19, 36, 98, 75, 25, 82, 96, 13, 55, 87, 71, 62, 20, 92, 23, 1, 5, 51, 27, 91, 46, 94, 80, 74, 40, 15, 97, 90, 68, 93, 67, 48, 12, 37, 76, 24, 2, 4, 44, 53
		#         1 ,  2 ,   2, 3, , 20
copia:	.word

#Inicio do codigo
.text
_start:
	jal		 main				# Vai para a main
	addi 		$v0, $zero, 10		#Set syscol para exis
	syscall						#finaliza o progama

#MAIN
main:
	addi		$sp, $sp, -12			#Alocando 2 ints
	sw		$ra, 8($sp)			#Guarda o ra
	sw 		$fp, 4($sp)			#salvando o fp
	sw 		$s0, 0($sp)			#Salvando o s0
	addi 		$fp, $sp,4				#inicio do stackFrame

        la $a0, vetor 					# ¨$a0 -> vetor
	lw $s1, tam 					# ¨$s2 -> tamanho
	subi $a1, $s1,1 				# $a1 -> num = m-1

	jal ordena_vet					# chama a funcao de ordena heapsort
	#jal ordena

	lw		$ra, 8($sp)			#Carega o ra
	lw		$fp,  4($sp)			#Restaura o fp
	lw		$s0, 0($sp)			#Restalra o s0
	addi		$sp, $sp, 4			#Restaura o sp
	
	
	jr		$ra					#Return

#Funçao de subir
subir:
	add $s3,$zero,$s2	
	#$s3 = i
if: 
	add $s5,$zero,$t3
	add $t4,$zero,$t3
	div $s3,$t1
	mflo $s5
	j ifcas
ifinicio:
	add $s5,$zero,$s2
	mul $t4,$s5,4					#$s2 = i
        lw $t8, vetor($t4) 				# $t8 = lista[i]
ifcas:
	subi $t2, $s5, 1 				# $t2 = (i+(-1))				
	addi $t3, $zero, 2				#$t3 = 2
        div $t2, $t3 					# divisao j = $t1/$t2
        mflo $s3 						# quociente
	mul $t3,$s3,4					#$s3 = j
        lw $t9, vetor($t3) 				# $t9 = lista[j]
 

	slt $t1, $t9, $t8 					# IF2, compara $t9 < $t8 e atribui valor verdade
        beq $t1,$zero, fim 				# se $t3 == 0 entao volta ao if
	add $t2,$zero,$t8				#temp = lista[i]
       	sw  $t9, vetor($t4)				# lista[i] = lista[j]
	sw  $t2, vetor($t3)				#lista[j] = temp
	j if 							# chama a funcao SUBIR
fim:
	jr $ra


#Funçao para ordenaor em um heap
ordena:
	addi		$sp, $sp, -12			#Alocando 2 ints
	sw		$ra, 8($sp)			#Retorno para main
	sw 		$fp, 4($sp)			#Ponteiro stackFreme
	addi 		$fp, $sp,4				#inicio do stackFrame


	addi $s2,$zero,1				#$s0 -> i = 1

for:   
	slt $t0, $s2, $s1 				# FOR, compara se $0 < $s1 e atribui 1 ou 0
	beq $t0, $zero, fim_for 			#FIM1 se $t0 == 0 entao pula ao fim_for

        jal ifinicio 						# chama a funcao SUBIR


	addi $s2,$s2,1					#$s0 -> i = 1

	j for

fim_for:
	lw		$ra, 8($sp)			#Retorno para main
	lw		$fp,  4($sp)			#Restaura o fp
	addi		$sp, $sp, 4			#Restaura o sp
	
	jr $ra


#Funçao que ordena em heapSort
ordena_vet:
	addi		$sp, $sp, -12			#Alocando 2 ints
	sw		$ra, 8($sp)			#Retorno para main
	sw 		$fp, 4($sp)			#Ponteiro stackFreme
	addi 		$fp, $sp,4				#inicio do stackFrame

ordena_inicio:
	jal ordena 						# chama a funcao ORDENA

	mul $t4,$a1,4

	lw $t0, vetor($zero)
        add $t2, $zero, $t0 				# valor = lista[0]
        lw $t5, vetor($t4) 				# lista[num]
        sw $t5, vetor($zero) 				#lista[0] = lista[num]

	sw $t2, vetor($t4) 				#lista[num] = valor

	#addi $t3,$zero,-1
	#sw $t3, vetor($t4) 				# lista[num]

	#sw $t2,copia($t4)
	sub $a1,$a1,1
	sub $s1, $s1, 1
	beq $s1, 1, fim1 				# compara se num == -1, se nao pula para
	j ordena_inicio					# recurcivo

fim1:
	lw		$ra, 8($sp)			#Retorno para main
	lw		$fp,  4($sp)			#Restaura o fp
	addi		$sp, $sp, 4			#Restaura o sp

.data
msg:		.ascii				"Vetor: "
.text
print:
	#addi 		$v0,  $zero,  4		#Print string
	#syscall					#Imprime a string

	la		$t8, msg			#Caregando mensagem
	addi		$v0, $zero,  4		#Pirnt ints
	add		$a0,$zero, $t8		#a0 <- a1
	syscall

	addi		$v0,$zero, 11		#print char
	addi		$a0,$zero, '\n'		#print \n
	syscall

	add		$s7,$zero,$zero
	add		$t2,$zero,$zero
	lw $s1, tam

for2:
	addi		$v0, $zero,  1		#Pirnt ints
	lw		$t1,vetor($s7)
	add		$a0,$zero, $t1		#a0 <- a1
	syscall
	
	addi 		$s7,$s7,4
	addi		$t2,$t2,1
	beq		$t2,$s1,F

	addi		$v0,$zero, 11		#print char
	addi		$a0,$zero, ' '		#print \n
	syscall

	j for2

F:
	syscall

