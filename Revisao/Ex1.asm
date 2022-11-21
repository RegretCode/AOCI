# 1.Escreva um programa que remova os espaços de uma string. Por exemplo, a entrada
# .data
# 	string: .asciiz “Gosto muito do meu professor de AOC-I."
# deve produzir a string
# 	" GostomuitodomeuprofessordeAOC-I.“
# Use apenas uma string (não use uma string de saída ou uma string auxiliar no seu
# programa). Não esqueça de terminar sua string com nulo (ver tabela ASCII para
# código do espaço e do \0 (null)).

# A resposta deve ser a string de entrada modificada, e não uma nova string na
# memória, ou seja, iniciando no endereço de memória 0x10010000.

.data
	string: .asciiz "Gosto muito do meu professor de AOC-I.\0"
	
.text
	la $s1,  string			#$s1 = primeiro endereco da string
	ori $t0, $t0, 32		# valor de espaco na tabela ascii eh '32'
	ori $t1, $t1, 0			# valor de null na tabela ascii eh '0'

loop:
	lbu $t3, 0($s1) 		#carrega char na posicao atual da string
	beq $t3, $t0, tiraEspaco	#verifica se o caracter atual eh um espaco
	beq $t3, $t1, fim		#verifica se o caracter atual eh \0
	
	addi $s1, $s1, 1		#atualiza para o proximo char 
	j loop
	
tiraEspaco:
	la $s2, 0($s1)			#$s2 recebe endereco atual da tring (char =  espaco), utilizando uma variavel aux para n perder a posicao de s1
tiraEspaco2:
	lbu $t3, 0($s2)			#carrega char na posicao atual da string
	beq $t3, $t1, loop		#verifica se o caracter atual eh \0
	
	lbu $t3, 1($s2)			#carrega o proximo char
	sb $t3, 0($s2)			#armazena valor da posicao n+1 na posicao n
	
	addi $s2, $s2, 1		#atualiza para o proximo char 
	j tiraEspaco2			#volta ao loop que retira o atual espaco
	
fim:	
	nop				#fim
	