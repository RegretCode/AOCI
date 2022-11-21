# 7. Escreva uma subrotina que retorne a média entre três valores. A subrotina deve
# receber como argumentos três inteiros e retornar a média entre eles. Escreva um
# programa para testar a subrotina que leia três valores do usuário e imprima o
# resultado. Importante: Utilize os registradores convencionados para a passagem de
# argumentos e valor de retorno! Armazene o retorno da subrotina (média entre os três
# valores) no registrador $t5.

# Exemplo:
# Entrada Saída
# 51
# 42
# 39 44 -- 44 também deve ser armazenado em $t5

.data 
	num: 	.asciiz "\nDigite um numero: \n"
	med:	.asciiz "\nMedia: \n"

.text
	#imprime
	li $v0, 4
	la $a0, num
	syscall
	#le
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	#imprime
	li $v0, 4
	la $a0, num
	syscall
	#le
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	#imprime
	li $v0, 4
	la $a0, num
	syscall
	#le
	li $v0, 5
	syscall
	
	move $s0, $t0
	move $s1, $t1
	move $s2, $v0
	
	jal  media
	
	move $t5, $v0
	
	#imprime
	li $v0, 4
	la $a0, med
	syscall
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 10
	syscall
	
	media:
		add $s0, $s0, $s1
		add $s0, $s0, $s2
		
		li $t3, 3
		
		div $s0, $t3
		
		mflo $v0
		jr $ra
	
	
