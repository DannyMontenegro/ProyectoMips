.data
fout: .asciiz "C:\\Users\\XTRATECH-PC\\Desktop\\PAO 1 2021\\Organización de Computadores\\Proyecto\\ProyectoMips\\DiccionarioMorse.txt"
buffer: .space 1220




.text
.globl opcion3



opcion3:
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	jal abrirArchivo
	move $s1,$v0 #fd
	jal leerArchivo
	
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
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
	li $a2,1220
	syscall
	li $v0, 16
	syscall
	
	
	la $v0, buffer #Se retorna el buffer con los datos al main
	jr $ra
	

	
	
	
