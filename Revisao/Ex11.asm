# 11. Leia dois vetores de 5 números inteiros (word) e armazene na memória iniciando na
# posição 0x10010000. Concatene os vetores e imprima o resultado na tela.
# Exemplo
# vetor1: 1 5 4 3 5
# vetor2: 2 3 4 6 8
# saida: 1 5 4 3 5 2 3 4 6 8

.data
	vetor1: 	.word 1 5 4 3 5
	vetor2: 	.word 2 3 4 6 8
	concatenado:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
	la $s0, concatenado
	la $s1, vetor1
	la $s2, vetor2
	li $t0, 0		#i
	li $t1, 5		#tam
	
while:
	beq $t0, $t1, fora
	lw $t2, 0($s1)		#vetor1	
	sw $t2, 0($s0)		#concatenado
		
	addi $s0, $s0, 4	#concatenado ++
	addi $s1, $s1, 4	#vetor 1
	addi $t0, $t0, 1	#i ++
	
	j while
	
fora:
	li $t0, 0		#i
loop:
	beq $t0, $t1, imprime
	lw $t2, 0($s2)		
	sw $t2, 0($s0)		
	
	
	addi $s0, $s0, 4	#concatenado ++
	addi $s2, $s2, 4	#vetor 2
	addi $t0, $t0, 1	#i ++
	
	j loop
	
imprime:
	li $t0, 0	#i
	li $t1, 10	#tam
	
for:
	beq $t0, $t1, fim
	lw $a0, 0($s0)
	li $v0, 1
	syscall
	
	addi $t0, $t0, 1
	addi $s0, $s0, 4
	
	j for
	
fim: 
	li $v0, 10
	syscall	