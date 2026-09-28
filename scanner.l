 //Archivo: scanner.l
 //Scanner que reconoce todos los tokens de un archivo con texto.
 // Si es token multivaluado muestra su valor
 //Autor: Saray Lopez y Diana Manevska
 //Fecha: 28/9/2026
 //Version: 0.0.1



%{
	// Headers standard necesarios
	#include <stdio.h> //Para poder escribir en el terminal
	#include <stdlib.h> //Para usar exit()
	#include <strings.h> //Para trabajar con cadenas de caracteres

	void errorEnScanner(char*, char*); //prototipo necesario para compilar

%}


 // COSAS QUE HAY QUE AÑADIR
 // para enteros y reales modificaarlo para que no pete cuando metes un numero muy grande --> que aparezca e
 // Letras minúsculas
 // Caracteres especiales "" ' / () = [] + * {} , ; . : - _ <> ^
 // espacio en blanco, tabuladores y salto de línea



falsoDR	(?i:falso)
fconstDR (?i:fconst)
literalCaracterDR	\".\"
literalEnteroDR	[+-]?[0-9]+
literalRealDR	{literalEnteroDR}[rR]
puntoYComaDR	;
dosPuntosDR :
verdaderoDR	(?i:verdadero)

%%

(?i:const)	{
	printf("(constTK, )\n");
}
{falsoDR}	{
	printf("(literalBooleanoTK, falso)\n");
}
{fconstDR}	{
	printf("(fconstTK, )\n");
}
=	{
	printf("(igualTK, )\n");
}
'([^']|\/')*'	{
	printf("(literalCadenaTK, %s)\n", yytext);
}
{literalCaracterDR}	{
	printf("(literalCaracterTK, %c)\n", yytext[1]);
}
{literalEnteroDR}	{
	printf("(literalEnteroTK, %d)\n", atoi(yytext));
}
[+-]?[0-9]*(\.[0-9]+)?([eE][+-]?[0-9]+)?	{
	printf("(literalRealTK, %f)\n", atof(yytext));
}
{literalRealDR}	{
	char * cadena;
	if ((cadena = strndup(yytext, strlen(yytext)-1)) == NULL)
		errorEnScanner("No hay memoria para strndup() al leer %s\n", yytext);
	else {
		printf("(literalRealTK, %f)\n", atof(cadena));
		free(cadena); //Para no sobrecargar la memoria
	}
}
[A-Z][A-Z_]*	{
	printf("(nombreConstanteTK, %s)\n", yytext);
}
{puntoYComaDR}	{
	printf("(puntoYComaTK, )\n");
}
{dosPuntosDR}   {
    printf("(dosPuntosDR, )\n");
}
\.   {
    printf("(puntoDR, )\n");
}
{verdaderoDR}	{
	printf("(literalBooleanoTK, verdadero)\n");
}
.	{ //Permite que el resto de caracteres no hagan echo
}

%%


void errorEnScanner(char* definicionDelError, char * variable){
	printf("\n\n\n\t%s %s \n", definicionDelError, variable);
	exit(EXIT_FAILURE);
}
