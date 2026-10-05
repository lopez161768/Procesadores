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
 // Caracteres especiales / () [] {}   <> ^
 // espacio en blanco, tabuladores y salto de línea

 // CUIDADO CON EL = TENEMOS QUE TENER UNO DE CREACIÓN DE TIPO

falsoDR	(?i:falso)
constDR (?i:const)
fconstDR (?i:fconst)
accionDR (?i:accion)
algoritmoDR (?i:algoritmo)
booleanoDR (?i:booleano)
cadenaDR (?i:cadena)
caracterDR (?i:caracter)
continuarDR (?i:continuar)
deDR (?i:de)
devDR (?i:dev)
divDR (?i:div)
entDR (?i:ent)
enteroDR (?i:entero)
entSalDR (?i:e\/s)
faccionDR (?i:faccion)
falgoritmoDR (?i:falgoritmo)
ffuncionDR (?i:ffuncion)
fmientrasDR (?i:fmientras)
fparaDR (?i:fpara)
fsiDR (?i:fsi)
ftipoDR (?i:ftipo)
ftuplaDR (?i:ftupla)
funcionDR (?i:funcion)
fvarDR (?i:fvar)
hacerDR (?i:hacer)
hastaDR (?i:hasta)
mientrasDR (?i:mientras)
modDR (?i:mod)
noDR (?i:no)
oDR (?i:o)
paraDR (?i:para)
realDR (?i:real)
refDR (?i:ref)
salDR (?i:sal)
siDR (?i:si)
tablaDR (?i:tabla)
tipoDR (?i:tipo)
tuplaDR (?i:tupla)
varDR (?i:var)
verdaderoDR	(?i:verdadero)
yDR (?i:y)


literalCaracterDR	\".\"
literalEnteroDR	[+-]?[0-9]+
literalRealDR	{literalEnteroDR}[rR]
puntoYComaDR	;
dosPuntosDR :


%%

{constDR}	{
	printf("(constTK, )\n");
}
{falsoDR}	{
	printf("(literalBooleanoTK, falso)\n");
}
{verdaderoDR}	{
	printf("(literalBooleanoTK, verdadero)\n");
}
{fconstDR}	{
	printf("(fconstTK, )\n");
}
{accionDR}	{
	printf("(accionTK, )\n");
}
{algoritmoDR}	{
	printf("(algoritmoTK, )\n");
}
{booleanoDR}	{
	printf("(booleanoTK, )\n");
}
{cadenaDR}	{
	printf("(cadenaTK, )\n");
}
{caracterDR}	{
	printf("(caracterTK, )\n");
}
{continuarDR}	{
	printf("(continuarTK, )\n");
}
{deDR}	{
	printf("(deTK, )\n");
}
{devDR}	{
	printf("(devTK, )\n");
}
{divDR}	{
	printf("(divTK, )\n");
}
{entDR}	{
	printf("(entTK, )\n");
}
{enteroDR}	{
	printf("(enteroTK, )\n");
}
{entSalDR}	{
	printf("(entSalTK, )\n");
}
{faccionDR}	{
	printf("(faccionTK, )\n");
}
{falgoritmoDR}	{
	printf("(falgoritmoTK, )\n");
}
{ffuncionDR}	{
	printf("(ffuncionTK, )\n");
}
{fmientrasDR}	{
	printf("(fmientrasTK, )\n");
}
{fparaDR}	{
	printf("(fparaTK, )\n");
}
{fsiDR}	{
	printf("(fsiTK, )\n");
}
{ftipoDR}	{
	printf("(ftipoTK, )\n");
}
{ftuplaDR}	{
	printf("(ftuplaTK, )\n");
}
{funcionDR}	{
	printf("(funcionTK, )\n");
}
{fvarDR}	{
	printf("(fvarTK, )\n");
}
{hacerDR}	{
	printf("(hacerTK, )\n");
}
{hastaDR}	{
	printf("(hastaTK, )\n");
}
{mientrasDR}	{
	printf("(mientrasTK, )\n");
}
{modDR}	{
	printf("(modTK, )\n");
}
{noDR}	{
	printf("(noTK, )\n");
}
{oDR}	{
	printf("(oTK, )\n");
}
{paraDR}	{
	printf("(paraTK, )\n");
}
{realDR}	{
	printf("(realTK, )\n");
}
{refDR}	{
	printf("(refTK, )\n");
}
{salDR}	{
	printf("(salTK, )\n");
}
{siDR}	{
	printf("(siTK, )\n");
}
{tablaDR}	{
	printf("(tablaTK, )\n");
}
{tipoDR}	{
	printf("(tipoTK, )\n");
}
{tuplaDR}	{
	printf("(tuplaTK, )\n");
}
{varDR}	{
	printf("(varTK, )\n");
}
{yDR}	{
	printf("(yTK, )\n");
}


=	{
	printf("(igualTK, )\n");
}
'	{	printf("(comillaSimpleTK, ) \n");	}
\".\"	{	printf("(comillaDobleTK, ) \n");	}

{literalCaracterDR}	{
	printf("(literalCaracterTK, %c)\n", yytext[1]);
}
{literalEnteroDR}	{
	printf("(literalEnteroTK, %d)\n", atoi(yytext));
}
-	{
	printf("(guionTK, )\n");
}
+	{
	printf("(operadorSumaTK, )\n");
}
"*"	{
	printf("(operadorProductoTK, )\n");
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
    printf("(dosPuntosTK, )\n");
}
\.   {
    printf("(puntoTK, )\n");
}
\,	{
	printf("(comaTK, )\n");
}
\/	{
	printf("(barraTK, )\n");
}


.	{ //Permite que el resto de caracteres no hagan echo
}

%%


void errorEnScanner(char* definicionDelError, char * variable){
	printf("\n\n\n\t%s %s \n", definicionDelError, variable);
	exit(EXIT_FAILURE);
}
