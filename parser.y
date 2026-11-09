 // Archivo: Escribe por pantalla la tabla de símbolos que genera durante
 // la compilación y la de cuadruplas que se genera
 // Autor: Saray Lopez y Diana Manevska
 // Fecha: 09/11/2026
 // Version: 0.0.1


 // RUTINAS SEMÁNTICAS VACÍAS {} PONER EN TODAS LAS PRODUCCIONES !!!!!

 //  1: ZONA DE DECLARACIONES
%{
	#include <stdio.h>
	int yylex(); // Usamos la funcion que se crea gracias a flex
	void yyerror(char *); // Prototipo de una funcion necesaria
	extern FILE* yyin; // Usamos la varible de Flex en la que viene la entrada
	TablaDeConstantes tc; //Es donde guardaremos las constantes
	#define YYDEBUG 1 //Permite activar el modo Debugg de Bison
%}

 //PARTE 2.2: Declaracion de los tokens del lenguaje y declaracion de los tipos del
 // union en los que flex nos enviara el valor asociado a los tokens multivaluados

%token <literal> literalTK
%token <cadena> nombreCteTK

%token constTK
%token fconstTK
%token accionTK
%token algoritmoTK
%token booleanoTK
%token cadenaTK
%token caracterTK
%token continuarTK
%token deTK
%token devTK
%token divTK
%token entTK
%token enteroTK
%token entSalTK
%token faccionTK
%token falgoritmoTK
%token ffuncionTK
%token fmientrasTK
%token fparaTK
%token fsiTK
%token ftipoTK
%token ftuplaTK
%token funcionTK
%token fvarTK
%token hacerTK
%token hastaTK
%token mientrasTK
%token modTK
%token noTK
%token oTK
%token paraTK
%token realTK
%token refTK
%token salTK
%token siTK
%token tablaTK
%token tipoTK
%token tuplaTK
%token varTK
%token yTK

%token igualTK
%token operadorRestaTK
%token operadorSumaTK
%token operadorProductoTK
%token operadorDivisionTK

%token comentarioTK

%token identificadorTK

%token puntoYComaTK
%token dosPuntosTK
%token asignacionTK
%token puntoTK
%token subrangoTK
%token comaTK
%token operadorDistintoTK
%token siNoTK
%token operadorMayorIgualTK
%token operadorMenorIgualTK
%token operadorMenorTK
%token operadorMayorTK
%token entoncesTK
%token corcheteAbiertoTK
%token corcheteCerradoTK
%token parentesisAbiertoTK
%token parentesisCerradoTK


 //PARTE 2.3: Definiciones (algunas innecesarias) de prioridades

%nonassoc constTK //hago no asociativo y de baja prioridad a constTK
%right fconstTK //hago fcosntTK es mas prioritario que constTK y asociativo a derecha
%left puntoYComaTK //Hago muy prioritario y asociativo a izquierdas al ;

 //PARTE 2.3: Creamos el union necesario para valores de flex y traducciones de bison

%union{
	char* cadena;
	LiteralT literal;
	int entero;
}

 //PARTE 2.4: Asignacion de traducciones a las variables

%type <entero> listaDeclConstantesV  //para contar las que se definen

%%


declaracionConstantesV: constTK listaDeclConstantesV fconstTK{
			printf("COMPILADOR: Se ha creado la tabla de constantes con %d constantes\n", $2);
			}
	;
listaDeclConstantesV :  declaracionDeConstanteV {
			$$= 1;
		}
	| listaDeclConstantesV puntoYComaTK listaDeclConstantesV {
			$$= $1 + $3;
		}
	;
declaracionDeConstanteV : nombreCteTK igualTK literalTK {
			insertaConstante(&tc, $1, $3);
		}
	;

%%
int main(int argc, char **argv){
	#if defined YYDEBUG
	yydebug=1;
	#endif
	++argv, --argc;
	if (argc > 0)
		yyin = fopen(argv[0], "r");
	else
		yyin = stdin;
	tc = nuevaTablaDeConstantes();
	yyparse();
	imprimeTablaDeConstantes(tc);
}


void yyerror(char * s){
	printf("\tBISON: ERROR, %s\n", s);
}
