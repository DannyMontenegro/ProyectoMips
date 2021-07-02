.data
	newLine: .asciiz "\n"
	pedircodigo: .asciiz "Ingrese el codigo correspondiente al caracter mostrado: \n"
	letraSeleccionada: .asciiz "El caracter es: "
	mensajeExitoso: .asciiz "Su respuesta es correcta \n"
	mensajeFallido: .asciiz "Su respuesta es incorrecta, el codigo correcto es:"
	bufferLectura: .space 100
	
	
.text
.globl opcion1

opcion1:
	
#Generar un índice aleatorio
	addi $sp, $sp, -8
	sw $ra, ($sp)
	
	li $a1, 36
	li $v0, 42
	syscall 
	
	sll $t0, $a0, 2
	
	add $t1, $t0, $s0     #Arreglo de letra
	add $t2, $t0, $s1     #Arreglo de codigo
	
	lb $t1, ($t1)    #Letra seleccionada
	lw $t2, ($t2)    #Dirección de memoria seleccionada 
	
	la $a0, letraSeleccionada
	jal imprimir
	
	move $a0, $t1	#Se imprime la letra seleccionada
	li $v0, 11
	syscall
	
	la $a0, newLine
	jal imprimir
	
	la $a0, pedircodigo	#Se pide al usuario ingresar el código morse
	jal imprimir
	
	la $a0, bufferLectura
	li $a1, 99
	li $v0, 8
	syscall
	
	sw $t2, 4($sp)
	#Se compara el código ingresado por el usuario con el código de la letra correspondiente
	loopComparacion:
		lb $t1, ($t2)
		lb $t3, ($a0) 
		
		beq $t3, 10, comprobar 		#Si se encuentra con un salto de linea se hace una comprobación adicional
		bne $t1, $t3, diferentes	#Si son diferentes se presenta mensaje de respuesta incorrecta
		beq $t1, $zero, iguales		#Si se llega al final del código de la letra correspondiente se presenta mensaje de éxito
		
		addi $t2, $t2, 1
		addi $a0, $a0, 1
		j loopComparacion
		

comprobar:
	beq $t1, $zero, iguales
	j diferentes
	
iguales:
	la $a0, mensajeExitoso
	jal imprimir
	j salir

diferentes:
	la $a0, mensajeFallido
	jal imprimir
	lw $a0, 4($sp)
	jal imprimir
	la $a0, newLine
	jal imprimir
	j salir


imprimir: 
#Función para imprimir
	li $v0, 4
	syscall
	jr $ra

salir:
#Regresa al main
	lw $ra, ($sp)
	addi $sp, $sp, 8
	jr $ra 	

		
	
	
