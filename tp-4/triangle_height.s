.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp               /* save old base pointer */
        mov %esp, %ebp          /* set ebp to current esp */

        movl	8(%ebp), %eax   #on met ladresse de lobjet dans eax
        pushl	%eax            #lobjet au debut de la pile              
	    call	_ZNK9CTriangle7AreaAsmEv    #on fait la fonction AreaCpp avec lobjet

		fld factor				#pile[0] = 2 et pile[1] = A
		fmulp					#A*2
		fld 12(%eax)			#pile[0] = mSide[2] et pile[1] =A*2
		fdivrp					#pile[0]= A*2/mSide[2]

        leave                   /* restore ebp and esp */
        ret                     /* return to the caller */
