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

igualDR	=

literalCaracterDR	\".\"
literalCadenaDR	'([^']|\/')*'

comentarioDR	\{([^\}]|\/\})*\}

literalEnteroDR	[+-]?[0-9]+
literalRealDR	{literalEnteroDR}[rR]|[+-]?[0-9]+\.[0-9]+([eE][+-]?[0-9]+)?

letraDR             [a-zA-Z]
cifraDR             [0-9]
letra_o_cifraDR     [a-zA-Z0-9_]
identificadorDR     {letraDR}{letra_o_cifraDR}*

puntoYComaDR	;
dosPuntosDR :
asignacionDR	:=
puntoDR	\.
subrangoDR	\.\.
comaDR \,
barraDR	\/
operadorDistintoDR	<>
siNoDR	\[\]
operadorMayorIgualDR	>=
operadorMenorIgualDR	<=
operadorMenorDR	<
operadorMayorDR	>
entoncesDR	->
corcheteAbiertoDR	\[
corcheteCerradoDR	\]
parentesisAbiertoDR	\(
parentesisCerradoDR	\)

%%

{constDR}	{	printf("(constTK, )\n");	}
{falsoDR}	{	printf("(literalBooleanoTK, falso)\n");	}
{verdaderoDR}	{	printf("(literalBooleanoTK, verdadero)\n");	}
{fconstDR}	{	printf("(fconstTK, )\n");	}
{accionDR}	{	printf("(accionTK, )\n");	}
{algoritmoDR}	{	printf("(algoritmoTK, )\n");	}
{booleanoDR}	{	printf("(booleanoTK, )\n");	}
{cadenaDR}	{	printf("(cadenaTK, )\n");	}
{caracterDR}	{	printf("(caracterTK, )\n");	}
{continuarDR}	{	printf("(continuarTK, )\n");	}
{deDR}	{	printf("(deTK, )\n");	}
{devDR}	{	printf("(devTK, )\n");	}
{divDR}	{	printf("(divTK, )\n");	}
{entDR}	{	printf("(entTK, )\n");	}
{enteroDR}	{	printf("(enteroTK, )\n");	}
{entSalDR}	{	printf("(entSalTK, )\n");	}
{faccionDR}	{	printf("(faccionTK, )\n");	}
{falgoritmoDR}	{	printf("(falgoritmoTK, )\n");	}
{ffuncionDR}	{	printf("(ffuncionTK, )\n");	}
{fmientrasDR}	{	printf("(fmientrasTK, )\n");	}
{fparaDR}	{	printf("(fparaTK, )\n");	}
{fsiDR}	{	printf("(fsiTK, )\n");	}
{ftipoDR}	{	printf("(ftipoTK, )\n");	}
{ftuplaDR}	{	printf("(ftuplaTK, )\n");	}
{funcionDR}	{	printf("(funcionTK, )\n");	}
{fvarDR}	{	printf("(fvarTK, )\n");	}
{hacerDR}	{	printf("(hacerTK, )\n");	}
{hastaDR}	{	printf("(hastaTK, )\n");	}
{mientrasDR}	{	printf("(mientrasTK, )\n");	}
{modDR}	{	printf("(modTK, )\n");	}
{noDR}	{	printf("(noTK, )\n");	}
{oDR}	{	printf("(oTK, )\n");	}
{paraDR}	{	printf("(paraTK, )\n");	}
{realDR}	{	printf("(realTK, )\n");	}
{refDR}	{	printf("(refTK, )\n");	}
{salDR}	{	printf("(salTK, )\n");	}
{siDR}	{	printf("(siTK, )\n");	}
{tablaDR}	{	printf("(tablaTK, )\n");	}
{tipoDR}	{	printf("(tipoTK, )\n");	}
{tuplaDR}	{	printf("(tuplaTK, )\n");	}
{varDR}	{	printf("(varTK, )\n");	}
{yDR}	{	printf("(yTK, )\n");	}


{igualDR}	{
	printf("(igualTK, )\n");
}

-	{	printf("(guionTK, )\n");	}
\+	{	printf("(operadorSumaTK, )\n");	}
"*"	{	printf("(operadorProductoTK, )\n");	}

{literalCadenaDR}	{
	printf("(literalCadenaTK, %.*s)\n", yyleng - 2, yytext + 1);
}

{literalCaracterDR}	{
	printf("(literalCaracterTK, %c)\n", yytext[1]);
}
{literalEnteroDR}	{
	printf("(literalEnteroTK, %lld)\n", atoll(yytext));
}
{literalRealDR}	{
	if (yytext[yyleng-1] == 'r' || yytext[yyleng-1] == 'R') {
        char * cadena;
        if ((cadena = strndup(yytext, yyleng - 1)) == NULL)
            errorEnScanner("No hay memoria para strndup() al leer %s\n", yytext);
        else {
            printf("(literalRealTK, %f)\n", atof(cadena));
            free(cadena);
        }
    } else {
        printf("(literalRealTK, %f)\n", atof(yytext));
    }
}

[A-Z][A-Z_]*	{
	printf("(nombreConstanteTK, %s)\n", yytext);
}

{comentarioDR}	{
	printf("(comentarioTK, %.*s)\n", yyleng - 2, yytext + 1);
}


{identificadorDR} { printf("(identificadorTK, %s)\n", yytext); }


{puntoYComaDR}	{	printf("(puntoYComaTK, )\n");	}
{dosPuntosDR}   {    printf("(dosPuntosTK, )\n");	}
{asignacionDR}	{	printf("(asignacionTK, )\n");	}
{puntoDR}   {    printf("(puntoTK, )\n");	}
{subrangoDR}	{	printf("(subrangoTK, )\n");	}
{comaDR}	{	printf("(comaTK, )\n");	}
{barraDR}	{	printf("(barraTK, )\n");	}

{operadorDistintoDR}	{ printf("(operadorDistintoTK, )\n"); }
{siNoDR}    { printf("(siNoTK, )\n"); }
{operadorMayorIgualDR}    { printf("(operadorMayorIgualTK, )\n"); }
{operadorMenorIgualDR}    { printf("(operadorMenorIgualTK, )\n"); }
{entoncesDR}	{	printf("(entoncesTK, )\n");	}

{operadorMenorDR}     { printf("(operadorMenorTK, )\n"); }
{operadorMayorDR}     { printf("(operadorMayorTK, )\n"); }
{corcheteAbiertoDR}     { printf("(corcheteAbiertoTK, )\n"); }
{corcheteCerradoDR}     { printf("(corcheteCerradoTK, )\n"); }
{parentesisAbiertoDR}     { printf("(parentesisAbiertoTK, )\n"); }
{parentesisCerradoDR}     { printf("(parentesisCerradoTK, )\n"); }

[ \t\n\r]+            //Ignorar espacios en blanco, tabuladores y saltos de línea

.	{ //Permite que el resto de caracteres no hagan echo
}

%%

void errorEnScanner(char* definicionDelError, char * variable){
	printf("\n\n\n\t%s %s \n", definicionDelError, variable);
	exit(EXIT_FAILURE);
}


int main(int argc, char *argv[]){
	if (argc > 1){
		FILE *archivo = fopen(argv[1], "r");

		if (!archivo) {
            perror("Error al abrir el archivo de entrada");
            return 1;
        }

        yyin = archivo;
	}

	yylex();

	if (argc > 1) {
		fclose(yyin);
	}
	return 0;
}
