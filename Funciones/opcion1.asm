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
	
	move $a0, $t1
	li $v0, 11
	syscall
	
	la $a0, newLine
	jal imprimir
	
	la $a0, pedircodigo
	jal imprimir
	
	la $a0, bufferLectura
	li $a1, 99
	li $v0, 8
	syscall
	
	sw $t2, 4($sp)
	loopComparacion:
		lb $t1, ($t2)
		lb $t3, ($a0) 
		
		beq $t3, 10, comprobar
		bne $t1, $t3, diferentes
		beq $t1, $zero, iguales
		
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
	li $v0, 4
	syscall
	jr $ra

salir:
	lw $ra, ($sp)
	addi $sp, $sp, 8
	jr $ra 	

		
	
	
