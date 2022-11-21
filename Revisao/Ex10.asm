# 10. Escreva um programa que conte com três subrotinas capazes de calcular a área da
# circunferência (π*r^2), do triângulo (b*a/2) e do retângulo (b*a). Inicialmente,
# pergunte ao usuário (use syscall) qual forma geométrica ele deseja (armazenando no
# registrador $t0) e depois solicite as medidas necessárias para calcular a área de cada
# forma (armazenar para circunferência o valor r em $t0, triângulo e retângulo
# armazenar valor de a e b em $t0 e $t1, respectivamente). Ao final, imprima a área
# desejada. Respeite as convenções de uso dos registradores.
# Considere π=3.

.data
	pergunta: 	.asciiz "\nDigite qual forma geometrica deseja calcular?\n0-Sair\n1-Circuferencia\n2-Triangulo\n3-Retangulo\n"
	raio:		.asciiz "Digite o raio: \n"
	base: 		.asciiz "Digite o base: \n"
	altura:		.asciiz "Digite o altura: \n"
	area: 		.asciiz "Area: \n"
	
.text
	li $v0, 4
	la $a0, pergunta
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $s0, 1	#Circuferencia
	beq $t0, $s0, circunferencia
	li $s0, 2	#Triangulo
	beq $t0, $s0, triangulo
	li $s0, 3	#Retangulo
	beq $t0, $s0, retangulo	
	beq $t0, $zero, fim 

circunferencia:
	jal calculaCirc
	j fim
		
triangulo:	
	jal calculaTri
	j fim
	
retangulo:
	jal calculaRet
	j fim
	
fim:	#sair
	li $v0, 10
	syscall
	
calculaCirc:
	#imprime
	li $v0, 4
	la $a0, raio
	syscall
	#le
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t3, 3
	mult $t0, $t0
	mflo $10
	
	mult $t0, $t3
	mflo $v0
	
	jr $ra
	
calculaTri:
	#imprime
	li $v0, 4
	la $a0, altura
	syscall
	#le
	li $v0, 5
	syscall
	move $t0, $v0
	#imprime
	li $v0, 4
	la $a0, base
	syscall
	#le
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $t3, 2
	mult $t0, $t1
	mflo $t0
	
	div $t0, $t3
	mflo $v0
	jr $ra
	
calculaRet:
	#imprime
	li $v0, 4
	la $a0, altura
	syscall
	#le
	li $v0, 5
	syscall
	move $t0, $v0
	#imprime
	li $v0, 4
	la $a0, base
	syscall
	#le
	li $v0, 5
	syscall
	move $t1, $v0
	
	mult $t0, $t1
	mflo $v0
	
	jr $ra