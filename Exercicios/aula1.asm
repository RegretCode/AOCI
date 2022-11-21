#4x - 2y + 3z
#16 - 4 + 9 = 21
#inicializa

ori $t1, $zero, 4  #inicializa x com 4
ori $t2, $zero, 2  #inicializa y com 2
ori $t3, $zero, 3  #inicializa z com 3 

add $t5, $t1, $t1 #soma x com x
add $t5, $t5, $t5 #soma 2x com 2x = 4x

add $t6, $t2, $t2 #soma y com y = 2y

add $t7, $t3, $t3 #soma z com z
add $t7, $t7, $t3 #soma de 2z com z = 3z

add $t7, $t7, $t5 #soma de 4x + 3z

sub $7, $t7, $t6 #soma de 4x + 3z - 2y