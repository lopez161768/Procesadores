 //Archivo: scanner.l
 //Scanner que reconoce todos los tokens de un archivo con texto.
 // Si es token multivaluado muestra su valor
 //Autor: Saray Lopez y Diana Manevska
 //Fecha: 28/9/2026
 //Version: 0.0.4



%{
	// Headers standard necesarios
	#include <stdio.h> //Para poder escribir en el terminal
	#include <stdlib.h> //Para usar exit()
	#include <strings.h> //Para trabajar con cadenas de caracteres

	void errorEnScanner(char*, char*); //prototipo necesario para compilar

%}




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

exponenteDR	[eE][+-]?[0-9]+
literalEnteroDR	[+-]?[0-9]+({exponenteDR})?
literalRealDR	({literalEnteroDR}[rR])|([+-]?[0-9]+\.[0-9]+({exponenteDR})?)

letraDR             [a-zA-Z]
cifraDR             [0-9]
letra_o_cifraDR     [a-zA-Z0-9]
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

{constDR}	{	return constTK;	}
{falsoDR}	{
	//Para programar de modo mas claro el parser, se ha optado por unir todos
	//los tokens de literales en un token unico. Hace necesario el modulo cuyo
	//header es literal.h
	//Esta eleccion permite ejemplificar el uso del %union y los union de C
	yylval.literal.tipoDelValor = BOOLEANO;
	yylval.literal.valor.valorBooleano = FALSO;
	return literalTK;
}
{verdaderoDR}	{
	yylval.literal.tipoDelValor = BOOLEANO;
	yylval.literal.valor.valorBooleano = VERDADERO;
	return literalTK;
}
{fconstDR}	{	return fconstTK;	}
{accionDR}	{	return accionTK;	}
{algoritmoDR}	{	return algoritmoTK;	}
{booleanoDR}	{	return booleanoTK;	}
{cadenaDR}	{
	yylval.literal.tipoDelValor = CADENA;
	//Es necesario reservar memoria para la cadena. No puedo usar la de yytext.
	//En partes posteriores se tendra en cuenta que esta cadena tiene memoria
	//propia. Para usar strdup es necesario importar etring.h
	if ((yylval.literal.valor.valorCadena = strdup(yytext)) == NULL )
		errorEnScanner("No hay memoria para strdup() al leer %s\n", yytext);
	else
		return literalTK;
}
{caracterDR}	{
	yylval.literal.tipoDelValor = CARACTER;
	yylval.literal.valor.valorCaracter = yytext[1];
	return literalTK;
}
{continuarDR}	{	return continuarTK;	}
{deDR}	{	return deTK;	}
{devDR}	{	return devTK;	}
{divDR}	{	return divTK;	}
{entDR}	{	return entTK;	}
{enteroDR}	{	return enteroTK;	}
{entSalDR}	{	return entSalTK;	}
{faccionDR}	{	return faccionTK;	}
{falgoritmoDR}	{	return falgoritmoTK;	}
{ffuncionDR}	{	return ffuncionTK;	}
{fmientrasDR}	{	return fmientrasTK;	}
{fparaDR}	{	return fparaTK;	}
{fsiDR}	{	return fsiTK;	}
{ftipoDR}	{	return ftipoTK;	}
{ftuplaDR}	{	return ftuplaTK;	}
{funcionDR}	{	return funcionTK;	}
{fvarDR}	{	return fvarTK;	}
{hacerDR}	{	return hacerTK;	}
{hastaDR}	{	return hastaTK;	}
{mientrasDR}	{	return mientrasTK;	}
{modDR}	{	return modTK;	}
{noDR}	{	return noTK;	}
{oDR}	{	return oTK;	}
{paraDR}	{	return paraTK;	}
{realDR}	{	return realTK;	}
{refDR}	{	return refTK;	}
{salDR}	{	return salTK;	}
{siDR}	{	return siTK;	}
{tablaDR}	{	return tablaTK;	}
{tipoDR}	{	return tipoTK;	}
{tuplaDR}	{	return tuplaTK;	}
{varDR}	{	return varTK;	}
{yDR}	{	return yTK;	}


{igualDR}	{	return igualTK;	}

-	{	printf("(guionTK, )\n");	}
\+	{	printf("(operadorSumaTK, )\n");	}
"*"	{	printf("(operadorProductoTK, )\n");	}


{literalCadenaDR}	{
	printf("(literalCadenaTK, %.*s)\n", yyleng - 2, yytext + 1);
}

{literalCaracterDR}	{
	printf("(literalCaracterTK, %c)\n", yytext[1]);
}

{literalEnteroDR} {
	if (strchr(yytext, 'e') != NULL || strchr(yytext, 'E') != NULL) {
		printf("(literalEnteroTK, %.8g)\n", strtod(yytext, NULL));
    }
	else {
		printf("(literalEnteroTK, %lld)\n", atoll(yytext));
    }
}

{literalRealDR}	{
	if (yytext[yyleng-1] == 'r' || yytext[yyleng-1] == 'R') {
        char * cadena;
        if ((cadena = strndup(yytext, yyleng - 1)) == NULL) {
            errorEnScanner("No hay memoria para strndup() al leer %s\n", yytext);
		}

        else {
            printf("(literalRealTK, %f)\n", atof(cadena));
            free(cadena);
        }
    }
    else {
        printf("(literalRealTK, %f)\n", atof(yytext));
    }
}

[A-Z]+	{
	printf("(nombreConstanteTK, %s)\n", yytext);
}

{comentarioDR}	{	printf("(comentarioTK, %.*s)\n", yyleng - 2, yytext + 1);	}


{identificadorDR} { printf("(identificadorTK, %s)\n", yytext); }


{puntoYComaDR}	{	return puntoYComaTK;	}
{dosPuntosDR}   {    return dosPuntosTK;	}
{asignacionDR}	{	return asignacionTK;	}
{puntoDR}   {    return puntoTK;	}
{subrangoDR}	{	return subrangoTK;	}
{comaDR}	{	return comaTK;	}
{barraDR}	{	return barraTK;	}

{operadorDistintoDR}	{ return operadorDistintoTK; }
{siNoDR}    { return siNoTK; }
{operadorMayorIgualDR}    { return operadorMayorIgualTK; }
{operadorMenorIgualDR}    { return operadorMenorIgualTK; }
{entoncesDR}	{	printf("(entoncesTK;	}

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


// main para leer ficheros .alg
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

