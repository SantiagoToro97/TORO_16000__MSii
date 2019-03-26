.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp				#/* Save old base pointer */
        mov %esp, %ebp			#/* Set ebp to current esp */
        
		movl $0, -4(%ebp)		# initialisation de r à 0
		movl $0, -8(%ebp)		#initialisation de c à 0 
		jmp CONDITION			#aller dans la condition du for

	CONDITION:
		cmp 16(%ebp), -4(%ebp)  #comparaison de r et matorder
		jb FOR_1				#aller dans le premier for si r<matorder
		jmp FIN					#rentre pas dans le for 

	FOR_1:
		cmp 16(%ebp),-8(%ebp)	#comp c avec matorder
		jb FOR_2				#va dans le deuxieme for si c<matorder
		movl $0, -8(%ebp)		#initialisation de c à 0 
		inc -4(%ebp)			#incrementation du r
		jmp CONDITION	        #retourne au debut du for

	FOR_2:
		movl 16(%ebp), %eax		#matorder dans %eax
		mull -4(%ebp), %eax		#r*%eax
		add  -8(%ebp), %eax		#c+r*%eax

		mov  8(%ebp), %edx		#inmatdata1 dans %edx
		mov 12(%ebp), %ecx		#inmatdata2 dans %ecx

		mov (%edx,%eax,4), %edx #inmatdata1[c + r * matorder]
		mov (%ecx,%eax,4), %ecx #inmatdata2[c + r * matorder]

		cmp %ecx, %edx			#compare
		jne FIN_NOT_EQUAL		#si c'est pas egal
		inc  -8(%ebp)			#si non incrémente c 
		jmp  FOR_1				#va au premier for

	FIN_NOT_EQUAL:
		movl $0, %edi			# return 0
		jmp end
	FIN
		movl $1, %edi			#return 1
		jmp end
	end:
        leave					#/* Restore ebp and esp */
        ret						#/* Return to the caller */
