#include "symtab.h"
#include<string.h>
#include<stdio.h>

int make_symtab(Symtab *symtab)
{

	symtab->offset = 0;
	memset(symtab->symbols, 0, SYMBOLSN*sizeof(Symtabkey));
	
	return 0;
	
}

Symtabkey *add_pair(Symtab *symtab, Symtabkey *symtabkey)
{
	memcpy(symtab->symbols+symtab->offset, symtabkey, sizeof(Symtabkey)); 
	symtab->offset ++;
	return symtabkey;
}

Symtabkey search_pair(Symtab *symtab, char *name)
{
	int i = (symtab->offset == 0 ? -1 : symtab->offset-1);
	for ( ; i >= 0 ; i-- ) {

		int l = (strlen(name) > strlen(symtab->symbols[i].name))?strlen(name):strlen(symtab->symbols[i].name);

		if (strncmp(symtab->symbols[i].name, name, l) == 0) {
				return symtab->symbols[i];//Integer
		}
	}

	//return nonexisting type
	Symtabkey key;
	key.type = -1;
	return key; 
}

void print_symtab(Symtab *symtab)
{
	int i = 0;
	for ( i = 0; i < SYMBOLSN; i++) {
		fprintf(stdout, "%d ", symtab->symbols[i]);
	}

}


