.data
	newLine: .asciiz "\n"
	pedirletra: .asciiz "Ingrese el caracter correspondiente al codigo mostrado: \n"
	codigoSeleccionada: .asciiz "El codigo es: "
	mensajeExitoso: .asciiz "Su respuesta es correcta \n"
	mensajeFallido: .asciiz "Su respuesta es incorrecta, el caracter correcto es: "
	bufferLectura: .space 10
	
	
.text
.globl opcion2

opcion2:
	

	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $t4, 8($sp)
	#Generar un índice aleatorio
	li $a1, 36
	li $v0, 42
	syscall 
	
	sll $t0, $a0, 2
	
	add $t1, $t0, $s0     #Arreglo de letra
	add $t2, $t0, $s1     #Arreglo de códigos
	
	lb $t1, ($t1)    #Letra seleccionada
	lw $t2, ($t2)    #Dirección de memoria seleccionada 
	
	la $a0, codigoSeleccionada
	jal imprimir
	
	move $a0, $t2	#Se imprime el código
	li $v0, 4
	syscall
	
	la $a0, newLine
	jal imprimir
	
	la $a0, pedirletra	#Se pide al usuario ingresar una letra
	jal imprimir
	
	la $a0, bufferLectura
	li $a1, 9
	li $v0, 8
	syscall
	
	jal minusAmayus
	
	sb $t1, 4($sp)
	
	#Se compara el resultado del arreglo con la letra ingresada por el usuario
	loopComparacion:
		lb $t3, ($a0)
		 
		bne $t1, $t3, diferentes
		beq $t3, 10, iguales
		
		
		addi $a0, $a0, 1
		j loopComparacion
		
	
iguales:
#Si son iguales se presenta mensaje de éxito
	la $a0, mensajeExitoso
	jal imprimir
	j salir

diferentes:
#Si son diferentes se presenta mensaje de respuesta incorrecta
	la $a0, mensajeFallido
	jal imprimir
	lb $a0, 4($sp)
	li $v0, 11
	syscall
	
	
	la $a0, newLine
	jal imprimir
	j salir


imprimir: 
#Función para imprimir
	li $v0, 4
	syscall
	jr $ra

minusAmayus:
	#Si la letra ingresada es minúscula se lleva a mayúscula
	lb $t3, ($a0)
	sgt $t4, $t3, 96
	slti $t5, $t3, 123
	and $t4, $t4, $t5
	beq $t4, 1, restar
	jr $ra
	
restar:
	#Resta para llevar una letra de minúscula a mayúscula en ascii
	addi $t3, $t3, -32
	sb $t3, ($a0)
	jr $ra

salir:
	#Regresa al main
	lw $ra, ($sp)
	lw $t4, 8($sp)
	addi $sp, $sp, 12
	jr $ra 	

	
	
