# 6. Inicialize o registrador $t7 com 0x1. Com apenas uma instrução,
# multiplique o conteúdo do registrador $t7 por 32. Utilize apenas instruções
# já vistas em aula até agora. O programa deve funcionar para qualquer valor,
# não apenas para 0x1.

	ori $t7, $zero, 0x1
	sll $t7, $t7, 5