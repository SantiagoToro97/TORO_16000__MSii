.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        /* Write your solution here */
		
		movl 8(%ebp), %eax	#on met ladresse de lobjet dans eax
		fld 4(%eax)			#met le rayon dans a pile[0]
		fldpi				#met pi=pile[0] et rayon dans pile[1]
		fmulp				#pile[0] = pile[1] = pi*rayon
        fld factor			#pile[0] = 2 et pile[1] = pi*rayon
		fmulp				#pile[0]=pile[1] = 2*pi*rayon

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
