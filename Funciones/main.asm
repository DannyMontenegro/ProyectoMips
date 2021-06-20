.data 
	IngresoDato: .asciiz "Elija una opcion:"
	MensajeFin : .asciiz "Gracias por utilizar el software"
	MensajePrueba: .asciiz "Mensaje de ejemplo"
	


.text

.globl main

main:
	li $s0, 4  #variable de control
	
	la $a0, IngresoDato
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	
loop:   beq $s1, $s0, fin
	li $v0, 4
	la $a0, MensajePrueba
	syscall
	la $a0, IngresoDato
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	j loop

fin:	
	la $a0, MensajeFin
	li $v0, 4
	syscall
	li $v0, 10
	syscall