# 1. Faça um programa que escreva o valor 0xDECADA70 no registrador
# $t7, incluindo um dígito hexadecimal por vez (isto é, insira letra por
# letra, individualmente) no registrador.

	ori $t1, $zero, 13 # 13 = d
	sll $t1, $t1, 4
	
	ori $t1, $t1, 14
	sll $t1, $t1, 4
	
	ori $t1, $t1, 12
	sll $t1, $t1, 4
	
	ori $t1, $t1, 10
	sll $t1, $t1, 4
	
	ori $t1, $t1, 13
	sll $t1, $t1, 4
	
	ori $t1, $t1, 10
	sll $t1, $t1, 4
	
	ori $t1, $t1, 7
	sll $t1, $t1, 4
	
	ori $t1, $t1, 0


	
