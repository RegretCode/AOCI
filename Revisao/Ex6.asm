# 6. Escreva um programa que repetidamente pergunte ao usuário pelo número de
# quilômetros viajados e litros de gasolina consumidos e depois imprima o número de
# quilômetros por litro. Para sair do programa, o usuário deve digitar 0 como número
# de quilômetros.

# Armazene todos os números de quilômetros por litro na memória, iniciando pelo
# endereço 0x10010000.

# Exemplo:
# Entrada Saída
# 40
# 3 	   13 	-- 13 também deve ser armazenado em 0x10010000
# 60
# 5 	   12 	-- 12 também deve ser armazenado em 0x10010004
# 0 		-- Sai do programa

.data
	consumo: 	.space 40
	km:		.asciiz "\nDigite o numero de km viajados ou 0 para sair: \n"
	L:		.asciiz "Digite a quantidade de litros consumidos: \n"
	resposta:	.asciiz "Quilometros por litro: \n"

.text
		la $s0, consumo
		
	loop:	
		#imprime
		li $v0, 4
		la $a0, km
		syscall
		#le
		li $v0, 5
		syscall
		move $s1, $v0
		
		beq $s1, $zero, fim
		
		#imprime
		li $v0, 4
		la $a0, L
		syscall
		#le
		li $v0, 5
		syscall
		move $s2, $v0
		
		div $s1, $s2
		mflo $s3
	
		#imprime
		li $v0, 4
		la $a0, resposta
		syscall
		#imprime
		li $v0, 1
		move $a0, $s3
		syscall
		
		sw $s3, 0($s0)		#armazena no vetor consumo
		addi $s0, $s0, 4	#consumo ++
		
		j loop
	fim: 
		nop