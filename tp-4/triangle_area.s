.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        movl 8(%ebp), %eax		#on met ladresse de lobjet dans eax
		addl $12, %eax			#pour PerimeterAsm
		movl (%eax), %eax		#ladresse de PerimeterAsm dans eax
		push 8(%ebp)			#lobjet au debut de la pile
		call *%eax				#call la fonction PerimeterAsm sur lobjet

		fld factor				#pile[0] = 2 et pile[1] = P
		fdivrp					#P/2
		fstp -4(%ebp)			#P/2 dans -4(%ebp)

		fld -4(%ebp)			#pile[0] = p/2 et pile[1] = P
		fld 4(%eax)				#pile[0] = mSide[0] et pile[1] = p/2
		fsubrp					#pile[0] = pile[1] = p/2 - mSide[0]

		fstp -8(%ebp)			#p/2 - mSide[0] dans -8(%ebp)

		fld -4(%ebp)			#pile[0] = p/2 
		fld 8(%eax)				#pile[0] = mSide[1] et pile[1] = p/2
		fsubrp					#pile[0] = pile[1] = p/2 - mSide[1]
		fld -8(%ebp)			#pile[0] = p/2 - mSide[0] et pile[1] = p/2 - mSide[1]
		fmulp					#(p/2 - mSide[0])*(p/2 - mSide[1])
		
		fstp -8(%ebp)			#(p/2 - mSide[0])*(p/2 - mSide[1]) dans -8(%ebp)

		fld -4(%ebp)			#pile[0] = p/2 
		fld 12(%eax)			#pile[0] = mSide[2] et pile[1] = p/2
		fsubrp					#pile[0] = pile[1] = p/2 - mSide[2]
		fld -8(%ebp)			#pile[0] = (p/2 - mSide[0])*(p/2 - mSide[1]) et pile[1] = p/2 - mSide[2]
		fmulp					#(p/2 - mSide[0])*(p/2 - mSide[1])*(p/2 - mSide[2])

		fld -4(%ebp)			#pile[0] = p/2 et pile[1]=(p/2 - mSide[0])*(p/2 - mSide[1])*(p/2 - mSide[2])
		fmulp					#(p/2)*(p/2 - mSide[0])*(p/2 - mSide[1])*(p/2 - mSide[2])
		fsqrt					#pour racine de (p/2)*(p/2 - mSide[0])*(p/2 - mSide[1])*(p/2 - mSide[2])


        leave          /* restore ebp and esp */
        ret            /* return to the caller */
