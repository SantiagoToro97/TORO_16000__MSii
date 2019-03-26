
#include <stdio.h>

unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be;

	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible
	 
	 be = (le & 0xff000000) | (le & 0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
	 */
	
	asm volatile (
		"rol $8,%0;"       //rotation vers la gauche
		"bswap %0"		   //on swap les bits
		
		: "=r"(be) 		   //la variable de sortie est be
		: "r"(le)		   //la variable d'entree est le
		:                  //pas besoin de modifier un registre

	);

	return be;
}

int main()
{
	unsigned int data = 0xeeaabbff;

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}
