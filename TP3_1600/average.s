.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

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
		
		movl -12(%ebp), %eax	# elem dans %eax
		movl  16(%ebp), %ebx	# matorder dans %ebx
		idiv %ebx  				# %eax= %eax / %ebx = elem/matorder
		movl -4(%ebp), %esi		#r dans %esi
		mov %eax,(%ecx,%esi,4)	#outmatdata[r] = elem/matorder

		movl $0, -8(%ebp)		#initialisation de c à 0 
		movl $0, -12(%ebp)		#initialisation de elem à 0
		
		inc -4(%ebp)			#incrementation du r
		
		jmp CONDITION	        #retourne a la CONDITION du for 1

	FOR_2:
		movl 16(%ebp), %eax		#matorder dans %eax
		mull -4(%ebp), %eax		#r*%eax
		add  -8(%ebp), %eax		#c+r*%eax

		mov  8(%ebp), %edx		#inmatdata dans %edx
		mov 12(%ebp), %ecx		#outmatdata dans %ecx

		mov (%edx,%eax,4), %edx #inmatdata1[c + r * matorder]
		
		add  %edx, -12(%ebp)	#elem+ = inmatdata[c + r * matorder]
		
		jmp FOR_1

	end:
        leave          			#/* Restore ebp and esp */
        ret            			#/* Return to the caller */