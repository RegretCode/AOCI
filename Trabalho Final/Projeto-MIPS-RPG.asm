#==============Jogo RPG - PROJETO FINAL - AOC=================
#
# Alec Gonçalves
# Marcelo Rezende
# Ricardo Cordeiro
#
#=================REGISTRADORES-UTILIZADOS====================
#
# $t0 - Controlador de opção
# $t1 - Contador de 0 à 10
# $t2 - Número de ações por dia
# $t3 - Valor de força do jogador
# $t4 - Valor de energia do jogador
# $t5 - Valor de vida do boss
# $t6 - Número de dias restantes
#
# $s0 - Endereço do vetor "dias"
# $s1 - Endereço do vetor "atributosP1"
# $s2 - Endereço do vetor "atributosBoss"
# $s3 - Número máximo de dias
#
#=============================================================
.data
	objetivo:		.asciiz "Olá forasteiro, vejo grande potencial em você!\nAcredito que com um bom treino poderá nos protejer de Thazras, O DESTRUIDOR!\nHá uma profecia, em 10 DIAS ele irá destruir a terra, e acredito que se você se preparar será capaz de vence-lo!"
	opening:		.asciiz "\nBem vindo ao RPG! Digite uma opção:\n0 - Sair\n1 - Jogar\n2 - Créditos\n"
	daysNum:		.asciiz "\nNúmero de dias restantes: "
	actionsNum:		.asciiz "\nNúmero de ações restantes do dia: "
	actions:		.asciiz "\n\nO que deseja fazer hoje?\n1 - Treinar.\n2 - Descansar.\n3 - Enfrentar Thazras.\n4 - Verificar seus atributos.\n"
	treino:			.asciiz "\nVocê se sente mais capaz de derrotar Thazras! "
	exausto:		.asciiz "\nVocê está cansado demais para treinar, vá descansar! "
	noAction:		.asciiz "Entretanto, você esgotou o número de ações diárias, hora de descansar!"
	descanso:		.asciiz "\nVocê se sente cheio de energia! "
	força:			.asciiz "\nForça: "
	energia:		.asciiz "\nEnergia: "
	credito:		.asciiz "\nProjeto final para a disciplina de Arquitetura e Organização de Computadores I \nDesenvolvido por Alec Gonçalves, Marcelo Rezende e Ricardo Cordeiro.\n"
	win:			.asciiz "\nCom muito esforço e treino você conseguiu destruir Thazras antes que ele destruísse o mundo, você é o meu HERÓI!\n\n\nWINNER!\n"
	lose:			.asciiz "\nVocê não se preparou o suficiente e, em pouco tempo, a Terra será destruída!\n\nGAME OVER!\n"
	sleep:			.asciiz "\nVocê, O HERÓI, destinado a derrotar Thazras, O DESTRUIDOR, decide enfrenta-lo em um duelo decisivo mas, por não ter descansado antes do embate, desmaiou por exaustão!\n\nGAME OVER!\n"
	timesUp:		.asciiz "\nSeus dias para enfrentar Thazras acabaram e você não foi capaz de derrota-lo, agora a Terra será destruída por sua culpa!\n\nGAME OVER!\n"
	systemPause: 	.asciiz "\nPressione ENTER para continuar..."
	agradecimento:	.asciiz "\nObrigado por jogar o nosso RPG!"
	invalido:		.asciiz "\nErro! Opção inválida!\n\n"

	dias:			.word 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 
	atributosP1:	.word 50, 30 	# força | stamina
	atributosBoss:	.word 100 		# vida

.text
jal intro # introduz o objetivo do jogo
jal leEnter

#=========================MENU================================
menu:
	li $v0, 4
	la $a0, opening # título do jogo
	syscall

	li $v0, 5 # lê imput do usuário
	syscall 

	beq $v0, $zero, sair # encerra o jogo

	li $t0, 1
	beq $v0, $t0, inicio # caso o usuário queira jogar

	li $t0, 2
	beq $v0, $t0, creditos # mostra os créditos

	li $v0, 4
	la $a0, invalido # opção inválida
	syscall

	jal leEnter
	j menu

#=========================INTRO===============================
intro:
	li $v0, 4
	la $a0, objetivo # introduz o objetivo do jogo
	syscall

	jr $ra

#=========================JOGAR===============================
inicio:
	la $s0, dias			# primeiro elemento do vetor "dias"
	la $s1, atributosP1		# primeiro elemento do vetor "atributosP1"
	la $s2, atributosBoss	# primeiro elemento do vetor "atributosBoss"
	li $s3, 10				# número máximo de dias
	li $t1, 0				# contador
	li $t2, 3				# número de ações por dia
	lw $t3, 0 ( $s1 )		# força do jogador
	lw $t4, 4 ( $s1 )		# energia do jogador
	lw $t5, 0 ( $s2 )		# vida do boss

jogar:	
	jal timeOver # testa se já passaram 10 dias

	lw $t6, 0 ( $s0 ) # número restante de dias

	li $v0, 4
	la $a0, daysNum # apresenta o número de dias restantes
	syscall

	li $v0, 1
	move $a0, $t6
	syscall

	li $v0, 4
	la $a0, actionsNum # apresenta o número de ações restantes no dia
	syscall	

	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 4
	la $a0, actions # apresenta as ações
	syscall

	li $v0, 5 # recebe imput do jogador
	syscall

	li $t0, 1
	beq $v0, $t0, if # treina o personagem do jogador

	li $t0, 2
	beq $v0, $t0, else1 # descança o personagem do jogador

	li $t0, 3
	beq $v0, $t0, else2 # enfrenta o boss

	li $t0, 4
	beq $v0, $t0, else3 # analisa os dados do personagem

	li $v0, 4
	la $a0, invalido # opção inválida
	syscall

	jal leEnter
	j jogar

if:
	jal treinar
	jal leEnter
	j jogar

else1:
	jal descansar
	jal leEnter
	j jogar

else2:
	jal enfrentar
	jal leEnter
	j menu

else3:
	jal status
	jal leEnter
	j jogar

#========================TREINAR==============================
treinar:
	beqz $t4, cansado # testa se o nível de energia do jogador é 0

	addi $t3, $t3, 15 # incrementa o valor de força do jogador
	addi $t4, $t4, -15 # decrementa o valor de energia do jogador
	addi $t2, $t2, -1 # diminui em 1 o número de ações diárias

	li $v0, 4
	la $a0, treino # confirma a execução do treino
	syscall

	beq $t2, $zero, zeroDay # testa se o jogador usou todas as ações diárias

	jr $ra # retorna à função chamadora ( label "if" )

cansado:
	li $v0, 4
	la $a0, exausto # caso o jogador tente treinar com 0 de energia
	syscall
	
	jr $ra # retorna à função chamadora ( label "if" )

zeroDay:
	li $v0, 4
	la $a0, noAction # caso o jogador esgote o número de ações no dia
	syscall

	addi $t1, $t1, 1	# i++
	addi $s0, $s0, 4	# vetor dias++

	li $t2, 3 # reseta o valor de ações diárias

	jr $ra # retorna à função chamadora ( label "if" )

#=======================DESCANSAR=============================
descansar:
	addi $t4, $t4, 15 # incrementa atributos do jogador

	addi $t1, $t1, 1	# i++
	addi $s0, $s0, 4	# vetor dias++

	li $t2, 3 # reseta o valor de ações diárias

	li $v0, 4
	la $a0, descanso # confirma a execução do descanso
	syscall

	jr $ra # retorna à função chamadora ( label "else1" )

#=======================ENFRENTAR=============================
enfrentar:	
	beqz $t4, dormiu # jogador perde se stamina = 0	

	bge $t3, $t5, venceu # jogador vence se força >= 200	

	blt $t3, $t5, perdeu #jogador perde se força < 200

venceu:
	li $v0, 4
	la $a0, win # se o jogador vencer, o jogo encerra e volta para o menu
	syscall

	jr $ra # retorna à função chamadora ( label "else2" )

perdeu:
	li $v0, 4
	la $a0, lose # se o jogador perder, o jogo encerra e volta para o menu
	syscall

	jr $ra # retorna à função chamadora ( label "else2" )

dormiu: 
	li $v0, 4
	la $a0, sleep # se o jogador tentar enfrentar o boss com 0 de energia, o jogo encerra e volta para o menu
	syscall

	jr $ra # retorna à função chamadora ( label "else2" )

#========================STATUS===============================
status:
	li $v0, 4
	la $a0, força # mostra para o usuário o seu nível de força
	syscall

	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 4
	la $a0, energia # mostra para o usuário o seu nível de energia
	syscall

	li $v0, 1
	move $a0, $t4
	syscall

	jr $ra # retorna à função chamadora ( label "else3" )

#=======================TIMEOVER==============================
timeOver:
	bne $t1, $s3, retorno # caso não tenham passado de 10 dias, retorna para o jogo

	li $v0, 4
	la $a0, timesUp # caso tenham passado de 10 dias, encerra o jogo
	syscall

	j menu

retorno:
	jr $ra

#=====================SYSTEM-PAUSE============================	
leEnter:
	li $v0, 4
	la $a0, systemPause # solicita ao usuário que aperte a tecla enter para continuar execução do programa
	syscall

	li $v0, 12 # sys code for readchar
  	syscall

  	bne $v0, 10, leEnter

  	jr $ra

#=======================CRÉDITOS==============================	
creditos:
	li $v0, 4
	la $a0, credito # informações do trabalho e dos integrantes do grupo
	syscall	

	jal leEnter
	j menu

#=========================SAIR================================
sair:
	li $v0, 4
	la $a0, agradecimento # mensagem final de agradecimento
	syscall 

	li $v0, 10 # encerra o rograma
	syscall

	



	

	

