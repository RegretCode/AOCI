# 3. Escreva um programa que leia um vetor de 10 posições (.word) da memória
# (começando na posição 0x10010000) e verifique se o vetor está ou não ordenado.
# Use o registrador $t0 como flag.
# Faça $t0 = 1 se o vetor estiver ordenado e $t0 = 0 caso contrário.

.data
	vetor:		.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text
	li $t0, 1	#flag verificacao se o vetor esta ordenado ou n
	la $s0, vetor	#s0 recebe primeira posicao do vetor
	li $s1, 9	#tam. vet. - 1
	li $s2, 1	#i
	
	while:
		beq $s1, $s2, fim
		lw $s3, 0($s0)
		lw $s4, 4($s0)
		
		slt $s5, $s3, $s4	#if s3 < s4 = 1 else 0
		beq $s5, $zero, naoOrdenado
		addi $s0, $s0, 4	#anda uma posicao no vetor
		addi $s2, $s2, 1	#i++
		j while
		
	naoOrdenado: 
		li $t0, 0
				
	fim:
		li $v0, 10
		syscall
