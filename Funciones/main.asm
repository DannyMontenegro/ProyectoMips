.data 
	IngresoDato: .asciiz "Elija una opcion:"
	MensajeFin : .asciiz "Gracias por utilizar el software \n"
	MensajeError: .asciiz "Ingrese un valor entre 1 y 4 \n"
	Bienvenida: .asciiz "Bienvenido al entrenamiento morse\n" 
	Menu: .asciiz "Que acción deseas realizar: \n 1)Practicar de Español a morse \n 2)Practicar de morse a español \n 3)Mostrar diccionario morse \n 4)Salir del entrenamiento \n"
	bufferLectura: .space 10
	


.text

.globl main

main:
	jal cargarDatos
	move $s0, $v0             
	move $s1, $v1
	
	jal opcion3
	move $t4, $v0
	
	
	la $a0, Bienvenida
	jal imprimir
	la $a0, Menu
	jal imprimir
	
	j pedirDatos
	
	
validacion: 
	
	sgt $t0, $t1, 52
        slti $t2, $t1, 49
        or $t0, $t0, $t2
	beq $t0, $zero, loop
	la $a0, MensajeError
	jal imprimir

pedirDatos:
	li $t0, 0
	li $t1, 0
	li $t2, 0
	la $a0, IngresoDato
	jal imprimir
	la $a0, bufferLectura
	la $a1, 9
	li $v0, 8
	syscall
	move $s2, $a0

sumarAscii:
	beq $t2, 10, validacion
	lb $t0, ($s2)
	beq $t0, 10, validacion
	add $t1, $t1, $t0
	addi $s2, $s2, 1
	addi $t2, $t2, 1
	j sumarAscii
	
	
loop:   
	beq $t1, '1', opcion1m
	
	beq $t1, '2', opcion2m
	
	beq $t1, '3', imprimirdatos

	beq $t1, '4', fin
	
	j loop


opcion1m:
	jal opcion1
	la $a0, Menu
	jal imprimir
	j pedirDatos

opcion2m:
	jal opcion2
	la $a0, Menu
	jal imprimir
	j pedirDatos

fin:	
	la $a0, MensajeFin
	jal imprimir
	li $v0, 10
	syscall


imprimirdatos:
	move $a0, $t4
	jal imprimir
	la $a0, Menu
	jal imprimir
	
	j pedirDatos
	
imprimir: 
	
	li $v0, 4
	syscall
	jr $ra
