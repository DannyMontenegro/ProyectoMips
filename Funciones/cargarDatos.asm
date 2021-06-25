.data
fout: .asciiz "C:\\Users\\XTRATECH-PC\\Desktop\\PAO 1 2021\\Organización de Computadores\\Proyecto\\ProyectoMips\\MORSE.txt"
buffer: .space 300




.text
.globl cargarDatos



cargarDatos:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	jal abrirArchivo
	move $s1,$v0 #fd
	jal leerArchivo
	
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	


abrirArchivo:

	li $v0,13
	la $a0,fout
	la $a1,0
	syscall


	jr $ra

leerArchivo:
	li $v0, 14
	move $a0, $s1
	la $a1, buffer
	li $a2, 300
	syscall
	
	la $v0, buffer #Se retorna el buffer con los datos al main
	
	jr $ra
	
	