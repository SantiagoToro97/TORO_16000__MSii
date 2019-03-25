.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        movl 8(%ebp), %eax		#on met ladresse de lobjet dans eax
		fld 4(%eax)				#mSide[0] dans pile[0]
		fld 8(%eax)				#mSide[1] dans pile[0] et mSide[0] dans pile[1]
		faddp					#mSide[1] + mSide[0]
		fld 12(%eax)			#Side[2] dans pile[0]	
		faddp					#mSide[2] + mSide[1] + mSide[0]

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
