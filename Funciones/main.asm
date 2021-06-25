.data 
	IngresoDato: .asciiz "Elija una opcion:"
	MensajeFin : .asciiz "Gracias por utilizar el software \n"
	MensajeError: .asciiz "Ingrese un valor entre 1 y 4 \n"
	Bienvenida: .asciiz "Bienvenido al entrenamiento morse\n Que acción deseas realizar: \n 1)Practicar de Español a morse \n 2)Practicar de morse a español \n 3)Mostrar diccionario morse \n 4)Salir del entrenamiento \n"
	
	


.text

.globl main

main:
	jal cargarDatos
	move $t4, $v0
	la $a0, Bienvenida
	jal imprimir
	
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	move $s1, $v0
	
validacion: sgt $t0, $s1, 4
            slti $t1, $s1, 1
            or $t0, $t0, $t1
	    beq $t0, $zero, loop
	    la $a0, MensajeError
	    jal imprimir
	    la $a0, IngresoDato
	    jal imprimir
	    li $v0, 5
	    syscall
	    add $s1, $v0, $zero
	    j validacion
	
	
loop:   beq $s1, 4, fin
	
	beq $s1, 3, imprimirdatos
	
	
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	jal validacion
	j loop


fin:	
	la $a0, MensajeFin
	jal imprimir
	li $v0, 10
	syscall


imprimirdatos:
	move $a0, $t4
	jal imprimir
	
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	move $s1, $v0
	j validacion
	
imprimir: 
	
	li $v0, 4
	syscall
	jr $ra
