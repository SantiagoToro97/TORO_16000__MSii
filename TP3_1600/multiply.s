.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp						#/* save old base pointer */
        mov %esp, %ebp					# /* set ebp to current esp */
        
		movl $0, -4(%ebp)				# initialisation de r à 0
		movl $0, -8(%ebp)				#initialisation de c à 0 
		movl $0, -12(%ebp)				#initialisation de elem à 0
		movl $0, %esi					#initialisation du i a 0
		jmp CONDITION					#aller dans la condition du for

	CONDITION:
		cmp 20(%ebp), -4(%ebp)			#comparaison de r et matorder
		jb FOR_1						#aller dans le premier for si r<matorder 
		jmp end							#fin

	FOR_1:
		cmp 20(%ebp),-8(%ebp)			#comp c avec matorder
		jb FOR_2						#va dans le deuxieme for si c<matorder

		movl $0, -8(%ebp)				#initialisation de c à 0 
		
		inc -4(%ebp)					#incrementation du r
		
		jmp CONDITION					#retourne a la CONDITION du for 1

	FOR_2:
		cmp 20(%ebp), %esi				#comparaison de i et matorder
		jb FOR_3						#va dans le deuxieme for si i<matorder
		
		movl 16(%ebp), %ebx				#outdate dans %ebx
		movl -12(%ebp), (%ebx,%eax,4)	#outmatdata[c + r * matorder] = elem

		movl $0, -12(%ebp)				#initialisation de elem à 0
		movl $0, %esi					#initialisation du i a 0

		inc -8(%ebp)					#incrementation du c
		jmp FOR_1

	FOR_3:
		movl 20(%ebp), %ebx				#matorder dans %ebx
		movl %ebx, %eax					#matorder dans %ebx
        mull -4(%ebp), %ebx				#r* matorder
		movl %ebx, %ecx					#on copie r* matorder dans une autre variable
		mull %esi, %eax					#i* matorder
		
		add  %esi, %ebx					#i+r* matorder
		add  -8(%ebp), %eax				#c+i* matorder
		add  -8(%ebp),%ecx				#c+r* matorder

		mov  8(%ebp), %edx				#inmatdata1 dans %edx
		mov 12(%ebp), %edi				#inmatdata2 dans %edi

		mov (%edx,%ebx,4), %edx			#inmatdata1[i + r * matorder]
		mov (%edi,%eax,4), %edi			#inmatdata2[c + i * matorder]

		mull %edx, %edi					#inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder]
		add  %edi, -12(%ebp)			# elem += inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder]

		inc %esi						#incrementation du i
		jmp FOR_2

	end:
        leave							#/* restore ebp and esp */
        ret								#/* return to the caller */
