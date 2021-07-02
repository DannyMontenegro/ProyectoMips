.data
	newLine: .asciiz "\n"
	pedirletra: .asciiz "Ingrese el caracter correspondiente al codigo mostrado: \n"
	codigoSeleccionada: .asciiz "El codigo es: "
	mensajeExitoso: .asciiz "Su respuesta es correcta \n"
	mensajeFallido: .asciiz "Su respues es incorrecta, el caracter correcto es: "
	bufferLectura: .space 10
	
	
.text
.globl opcion2

opcion2:
	
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
	
	la $a0, codigoSeleccionada
	jal imprimir
	
	move $a0, $t2
	li $v0, 4
	syscall
	
	la $a0, newLine
	jal imprimir
	
	la $a0, pedirletra
	jal imprimir
	
	la $a0, bufferLectura
	li $a1, 9
	li $v0, 8
	syscall
	
	jal mayusAminus
	
	sb $t1, 4($sp)
	
	
	loopComparacion:
		lb $t3, ($a0)
		 
		
		beq $t3, 10, iguales
		bne $t1, $t3, diferentes
		
		addi $a0, $a0, 1
		j loopComparacion
		
	
iguales:
	la $a0, mensajeExitoso
	jal imprimir
	j salir

diferentes:
	la $a0, mensajeFallido
	jal imprimir
	lb $a0, 4($sp)
	li $v0, 11
	syscall
	
	
	la $a0, newLine
	jal imprimir
	j salir


imprimir: 
	li $v0, 4
	syscall
	jr $ra

mayusAminus:
	lb $t3, ($a0)
	sgt $t4, $t3, 96
	slti $t5, $t3, 123
	and $t4, $t4, $t5
	beq $t4, 1, restar
	jr $ra
	
restar:
	addi $t3, $t3, -32
	sb $t3, ($a0)
	jr $ra

salir:
	lw $ra, ($sp)
	addi $sp, $sp, 8
	jr $ra 	

	
	
