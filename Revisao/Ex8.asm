# 8. Escreva um programa equivalente ao código C abaixo com o assembly do MIPS.
# Assim como no exemplo em C, utilize duas subrotinas (soma3n e soma). Armazene
# os valores em $t0, $t1, $t2 e $t3, para X, Y, Z e R, respectivamente.
# 	main(){
# 		int X=150;
# 		int Y=230;
# 		int Z=991;
# 		int R=0;
# 		R = soma3n(X, Y, Z);
# 	}
# 	int soma3n(int n1, int n2, int n3){
# 		return( soma(n3, soma(n1, n2)));
# 	}
# 	int soma(int A, int B){
# 		return( A+B );
# 	}

.data	
	intX: .word 150
	intY: .word 230
	intZ: .word 991
	intR: .word 0
	
.text
	lw $s0, intX
	lw $s1, intY
	lw $s2, intZ
	lw $s3, intR
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	
	jal soma3n
	move $t3, $v0
	sw $t3, intR
	
	li $v0, 10
	syscall
	
	
	
	soma3n:
		move $t2, $a2		#Z
		
		#soma Z + soma X+Y
	
		jal soma
		move $t6, $v0		#retorno da funcao pro s0
		add $t6, $t2, $t6	#soma de Z + result de X+Y
		
		move $v0, $t6
		jr $ra
		
	
	soma: 
		move $t0, $a0		#X
		move $t1, $a1		#Y
		
		add $t5, $t0, $t1	#t5 = X+Y
		move $v0, $t5		#v0 = t5
		
		jr $ra