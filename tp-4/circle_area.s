.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */

		movl 8(%ebp), %eax		#on met ladresse de lobjet dans eax
		fld 4(%eax)				#on met le rayon dans pile[0]
        fld 4(%eax)				#on met le rayon dans pile[0] et pile[1]
		fmulp					#pile[0] = pile[1] = rayon*rayon
		fldpi					#pile[0] = pi et pile[1] = rayon*rayon
		fmulp					#pile[0]=pi*rayon*rayon


        leave          /* restore ebp and esp */
        ret            /* return to the caller */
