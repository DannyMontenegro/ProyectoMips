.data 
	IngresoDato: .asciiz "Elija una opcion:"
	MensajeFin : .asciiz "Gracias por utilizar el software \n"
	MensajeError: .asciiz "Ingrese un valor entre 1 y 4 \n"
	Bienvenida: .asciiz "Bienvenido al entrenamiento morse\n" 
	Menu: .asciiz "Que acción deseas realizar: \n 1)Practicar de Español a morse \n 2)Practicar de morse a español \n 3)Mostrar diccionario morse \n 4)Salir del entrenamiento \n"
	
	


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
	
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	move $s2, $v0
	
validacion: sgt $t0, $s2, 4
            slti $t1, $s2, 1
            or $t0, $t0, $t1
	    beq $t0, $zero, loop
	    la $a0, MensajeError
	    jal imprimir
	    la $a0, IngresoDato
	    jal imprimir
	    li $v0, 5
	    syscall
	    move $s2, $v0
	    j validacion
	
	
loop:   beq $s2, 1, opcion1m
	
	beq $s2, 2, opcion2m
	
	beq $s2, 3, imprimirdatos

	beq $s2, 4, fin
	
	j loop


opcion1m:
	jal opcion1
	la $a0, Menu
	jal imprimir
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	move $s2, $v0
	j validacion

opcion2m:
	jal opcion2
	la $a0, Menu
	jal imprimir
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	move $s2, $v0
	j validacion

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
	
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	move $s2, $v0
	j validacion
	
imprimir: 
	
	li $v0, 4
	syscall
	jr $ra
