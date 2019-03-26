.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		/* Write your solution here */

		movl $0, -4(%ebp)		# initialisation de r à 0
		movl $0, -8(%ebp)		#initialisation de c à 0 
		jmp CONDITION			#aller dans la condition du for

	CONDITION:
		cmp 16(%ebp), -4(%ebp)  #comparaison de r et matorder
		jb FOR_1				#aller dans le premier for si r<matorder 
		jmp end					#fin

	FOR_1:
		cmp 16(%ebp),-8(%ebp)	#comp c avec matorder
		jb FOR_2				#va dans le deuxieme for si c<matorder
		movl $0, -8(%ebp)		#initialisation de c à 0 
		inc -4(%ebp)			#incrementation du r
		jmp CONDITION	        #retourne a la CONDITION du for 1

	FOR_2:
		movl 16(%ebp), %eax		#matorder dans %eax
		mull -4(%ebp), %eax		#r*%eax
		add  -8(%ebp), %eax		#c+r*%eax

		mov  8(%ebp), %edx		#inmatdata dans %edx
		mov 12(%ebp), %ecx		#outmatdata dans %ecx

		mov (%edx,%eax,4), %edx #inmatdata1[c + r * matorder]
		
		cmp  -4(%ebp), -8(%ebp) # comparaison
		je IF					# sauter si ==
		movl $0,(%ecx,%eax,4)	#outmatdata[c + r * matorder]=0
		inc  -8(%ebp)			# incrementation du c
		jmp FOR_1

	IF:	
		movl %edx,(%ecx,%eax,4)	#outmatdata[c + r * matorder]=inmatdata1[c + r * matorder]
		inc  -8(%ebp)			# incrementation du c
		jmp  FOR_1				#retorurne au for 1


	end:
        leave          			#/* Restore ebp and esp */
        ret            			#/* Return to the caller */

