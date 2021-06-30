.data 
	letras: .space 36   #[A, B, C, ...]
	tamanios: .word 2,4,4,3,1,4,3,4,2,4,3,4,2,2,3,4,4,3,3,1,3,4,3,4,4,4,5,5,5,5,5,5,5,5,5,5
	memorias: .space 144
	fout: .asciiz "C:\\Users\\XTRATECH-PC\\Desktop\\PAO 1 2021\\Organización de Computadores\\prueba.txt"
	bufferLectura: .space 1
.text

.globl cargarDatos
cargarDatos:
	addi $sp, $sp, -4
	sw $ra, ($sp)           #Guardamos el registro para regresar al main
	
	li $t0,10 #\n
	li $t1,44 #,
	jal abrirArchivo
	
	move $s0, $v0 #mover FD a $s0
	
	
	la $s1, tamanios #arreglo de tamaño de codigos
	la $s2, letras #arreglo de letras
	la $s3, memorias #arreglo de memorias
	
	li $t2, 0   #iterador i=0,1,..., Para controlar el indice del arreglo
	j leer
	
abrirArchivo:	
	li $v0, 13
	la $a0, fout
	la $a1, 0
	syscall
	
	jr $ra
		
	
leer:	
	move $a0, $s0
	li $v0, 14
	la $a1, bufferLectura
	li $a2, 1
	syscall
	
	beq $v0, 0, salir  #para saber cuando terminar de leer

	sll $t4, $t2, 2
	add $t6, $t4, $s2 #direccion de memoria del arreglo letras
	
	
	lb $t3, ($a1)  #t3 almacena la letra leida
	beq $t3, 10, leer
	beq $t3, 13, leer
	
	beq $t3, $t1, leerMorse #comparamos si lo leído es una coma
	sb $t3, ($t6)# almacena la letra leida en el arreglo de letras
	j leer
	
	

leerMorse:

	addi $sp, $sp, -8
	sw $a0, ($sp)
	add $t5, $t4, $s1 #dirección de arreglo de tamaño
	
	lw $a0, ($t5)
	sw $a0, 4($sp)
	beq $a0, 4, sumar1
terminarReserva:
	li $v0, 9
	syscall
	
	
	lw $a2, 4($sp)
	lw $a0, ($sp)
	move $a1, $v0
	li $v0, 14
	syscall
	
	
	add $t7, $t4, $s3 #dirección de memoria del arreglo de memorias
	sw $a1, ($t7) #Almacenamos el código morse en el arreglo
	
	

	addi $t2, $t2, 1
	
	addi $sp, $sp, 8
	j leer
		
	
salir:	
	li $v0, 16
	syscall
	lw $ra, ($sp)
	addi $sp, $sp, 4
	move $v0, $s2           #Retornamos arreglo de letras
	move $v1, $s3           #Retornamos arreglo de direcciones de memoria
	jr $ra

sumar1:
	addi $a0,$a0, 1
	j terminarReserva
	
	
	
	
	
	 
	  
	
	
	
	
