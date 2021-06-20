.data 
	IngresoDato: .asciiz "Elija una opcion:"
	MensajeFin : .asciiz "Gracias por utilizar el software \n"
	MensajePrueba: .asciiz "Mensaje de ejemplo \n"
	MensajeError: .asciiz "Ingrese un valor entre 1 y 4 \n"
	


.text

.globl main

main:
	li $s0, 4  #variable de control
	
	la $a0, IngresoDato
	jal imprimir
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	
validacion: sgt $t0, $s1, $s0
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
	
	
loop:   beq $s1, $s0, fin
	la $a0, MensajePrueba
	jal imprimir
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
	
imprimir: 
	li $v0, 4
	syscall
	jr $ra
