# 5. Declare três vetores do mesmo tamanho:
# .data
# 	tamanho: .word 7
# 	vetor1: .word -30, -23, 56, -43, 72, -18, 71
# 	vetor2: .word 45, 23, 21, -23, -82, 0, 69
# 	soma: .word 0, 0, 0, 0, 0, 0, 0
# Inicialize um ponteiro para cada vetor (pseudo-instrução la) e faça a soma dos
# elementos dos vetores 2 a 2.
# O vetor resultante deve ser armazenado depois dos elementos do segundo vetor.
# Exemplo: soma[i] = vetor1[i]+vetor2[i]

.data
	tamanho: .word 7
	vetor1: .word -30, -23, 56, -43, 72, -18, 71
	vetor2: .word 45, 23, 21, -23, -82, 0, 69
	soma: .word 0, 0, 0, 0, 0, 0, 0
	
.text
	la $s0, vetor1
	la $s1, vetor2
	la $s2, soma	
	lw $s3, tamanho	#possui o tam dos vetores
	li $t0, 0	# i = 1
		
	loop:
		beq $s3, $t0 fim	#tam = i
		lw $s4, 0($s0)		#pega o valor do vetor1[i]
		lw $s5, 0($s1)		#pega o valor do vetor2[i]
		add $s6, $s4, $s5	#soma os dois valores
		sw $s6, 0($s2)		#armazena no vetor soma
		
		addi $s0, $s0, 4	#vetor1 ++
		addi $s1, $s1, 4	#vetor2 ++
		addi $s2, $s2, 4	#soma ++
		addi $t0, $t0, 1	#i++
		
		j loop
		
	fim:
		nop