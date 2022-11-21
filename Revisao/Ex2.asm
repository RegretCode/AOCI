# 2. Escreva um programa que altere uma string para “capitalizar” a primeira letra de cada
# palavra. Por exemplo, a entrada

# .data
# 	string: .asciiz "meu professor é muito bom"
# deve produzir a string
# 	"Meu Professor É Muito Bom"

# Assuma que a entrada possui apenas espaços e letras minúsculas. Pode haver mais de
# um espaço entre as palavras.

# A resposta deve ser a string de entrada modificada, e não uma nova string na
# memória, ou seja, iniciando no endereço de memória 0x10010000.

.data
	string: .asciiz "meu professor é muito bom" 

.text
		la $t0, string		#$t0 endereco incial da string
	
		li $s0, 32 		#s0 recebe o espaco
		li $s1, 0		#s1 recebe flag pra ver se foi espaco
		li $s2, 0 		#s2 recebe null
	
		lb $t1 ($t0)		#pega o primeiro caracter	
		addi $t1, $t1, -32	#capitaliza
		sb $t1 ($t0)		#sobescreve
		addi $t0, $t0, 1
		
	inicio:
		lb $t1 ($t0)		#pega a proxima posicao
		beq $t1, $s2, fim	#verifica se t1 == nulo
		beq $t1, $s0, espaco	#verifica se t1 == espaco
		beq $s1, $zero, pula	#verifica se o sinal se foi espaco ou nao
		addi $t1, $t1, -32	#capitaliza
		sb $t1 ($t0)		#sobescreve
		li $s1, 0		#reseta a flag
		
	pula:
		addi $t0, $t0, 1	#prox posicao de t0
		j inicio
			
	espaco:
		li $s1, 1		#seta flag pois foi espaco
		j pula
	
	
		
	fim:
		nop