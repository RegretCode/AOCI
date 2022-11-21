# 4. Escreva um programa que inverta a ordem dos elementos de um vetor (.word) com 5
# posições. Por exemplo, a entrada: 1, 2, 3, 4, 5 deve produzir 5, 4, 3, 2, 1.
# A resposta deve ser o vetor de entrada modificado, e não um novo vetor na memória,
# ou seja, iniciando no endereço de memória 0x10010000.

.data
	vetor: .word 1, 2, 3, 4, 5
		     

.text
	la $s0, vetor	#s0 recebe endereco do primeiro byte do vetor
	
	lw $s1, 0($s0)
	lw $s2, 16($s0)
	#swap
	sw $s1, 16($s0)
	sw $s2, 0($s0)
	
	lw $s1, 4($s0)
	lw $s2, 12($s0)
	#swap	
	sw $s1, 12($s0)
	sw $s2, 4($s0)
	
	nop
	