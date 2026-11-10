 // Archivo: parser.y
 // Parser de ProAlg (VERSION REDUCIDA: sin apuntadores, tablas, tuplas, acciones
 // ni funciones). Escribe por pantalla la tabla de simbolos y la de cuadruplas.
 // Autor: Saray Lopez y Diana Manevska
 // Fecha: 10/11/2026
 // Version: 0.1.0 (esqueleto: gramatica + rutinas semanticas vacias)

 // RUTINAS SEMANTICAS VACIAS {} PUESTAS EN TODAS LAS PRODUCCIONES.
 // Las zonas marcadas con TODO(ampliacion) son las que faltan para el lenguaje completo.

 // 1: ZONA DE DECLARACIONES
%{
	#include <stdio.h>
	#include "nombresDeTipos.h"
	#include "literal.h"
	#include "tablaDeConstantes.h"

	int yylex(); // Funcion que crea flex
	void yyerror(char *); // Prototipo de la funcion de errores de bison
	extern FILE* yyin; // Variable de flex con la entrada

	TablaDeConstantes tc; // Aqui guardamos las constantes
	#define YYDEBUG 1 // Permite activar el modo debug de bison
%}

 // PARTE 2.1: Union con los tipos de los valores que envia flex y de las traducciones

%union{
	char* cadena;
	LiteralT literal;
	int entero;
}

 // PARTE 2.2: Tokens del lenguaje

 // Tokens multivaluados (el scanner debe rellenar yylval.<campo>)
%token <literal> literalTK
%token <cadena> nombreCteTK
%token <cadena> identificadorTK

 // Palabras reservadas
%token constTK fconstTK
%token accionTK faccionTK funcionTK ffuncionTK
%token algoritmoTK falgoritmoTK
%token booleanoTK cadenaTK caracterTK enteroTK realTK
%token continuarTK
%token deTK devTK
%token divTK modTK
%token entTK salTK entSalTK
%token fmientrasTK mientrasTK hacerTK
%token fparaTK paraTK hastaTK
%token siTK fsiTK
%token ftipoTK tipoTK
%token ftuplaTK tuplaTK tablaTK refTK
%token fvarTK varTK
%token noTK oTK yTK

 // Operadores y signos
%token igualTK
%token operadorRestaTK operadorSumaTK operadorProductoTK operadorDivisionTK
%token operadorDistintoTK operadorMayorIgualTK operadorMenorIgualTK
%token operadorMenorTK operadorMayorTK
%token asignacionTK entoncesTK siNoTK
%token puntoYComaTK dosPuntosTK puntoTK subrangoTK comaTK
%token corcheteAbiertoTK corcheteCerradoTK parentesisAbiertoTK parentesisCerradoTK

 // Comentarios (los que llegan al parser son la precondicion y la postcondicion;
 // los informativos los debe descartar el scanner)
%token comentarioTK

 // PARTE 2.3: Prioridades y asociatividades (de MENOR a MAYOR prioridad)

%left oTK
%left yTK
%right noTK
%nonassoc igualTK operadorDistintoTK operadorMenorTK operadorMayorTK operadorMenorIgualTK operadorMayorIgualTK
%left operadorSumaTK operadorRestaTK
%left operadorProductoTK operadorDivisionTK divTK modTK

 // PARTE 2.4: Tipos de los simbolos no terminales con traduccion

%%

 // GRAMATICA DEL ALGORITMO

desc_algoritmo: algoritmoTK identificadorTK puntoYComaTK cabecera_alg bloque_alg falgoritmoTK puntoTK { }
	;

cabecera_alg: decl_globales decl_a_f decl_ent_sal comentarioTK  { }
	;

bloque_alg: bloque comentarioTK { }
	;

decl_globales: declaracion_tipo  decl_globales   { }
	| declaracion_const decl_globales   { }
	| { }  
	;

decl_a_f: accion_d decl_a_f { }
	| funcion_d decl_a_f { }
	| { }   
	;

bloque: declaraciones instrucciones { }
	;

declaraciones: declaracion_tipo  declaraciones   { }
	| declaracion_const declaraciones   { }
	| declaracion_var   declaraciones   { }
	| { }  
	;

 // DECLARACIONES

declaracion_tipo: tipoTK lista_d_tipo ftipoTK { }
	;

declaracion_const: constTK lista_d_cte fconstTK { }
	;

declaracion_var: varTK lista_d_var fvarTK { }
	;


 // DECLARACIONES DE TIPOS

lista_d_tipo: identificadorTK igualTK d_tipo puntoYComaTK lista_d_tipo   { }
	| { }
	;

// ?? hay dos d_tipo en el pdf cual tenemos que poner? 
d_tipo: { }
	;

expresion_t: expresion { }
	| literalTK { }
	;

tipo_base: enteroTK { }
	| booleanoTK { }
	| caracterTK { }
	| realTK { }
	| cadenaTK { }
	;

lista_d_cte: identificadorTK igualTK literalTK puntoYComaTK lista_d_cte { }
	| { }
	;

lista_d_var: lista_id dosPuntosTK d_tipo puntoYComaTK lista_d_var   { }
	| { }
	;

lista_id: identificadorTK comaTK lista_id { }
	| identificadorTK { }
	;

decl_ent_sal: decl_ent { }
	| decl_ent decl_sal { }
	| decl_sal { }
	;

decl_ent: entTK lista_d_var { }
	;

decl_sal: salTK lista_d_var { }
	;

 // EXPRESIONES (una sola regla; aritmeticas y logicas se distinguen

expresion: exp_a { }
	| exp_b { }
	| funcion_ll { }
	;

// hay dos --> lo juntamos ??
exp_a: exp_a operadorSumaTK exp_a { }
	| exp_a operadorRestaTK exp_a { }
	| exp_a operadorProductoTK exp_a { }
	| exp_a operadorDivisionTK exp_a { }
	| exp_a divTK exp_a { }
	| exp_a modTK exp_a { }
	;

exp_b: exp_b yTK exp_b { }
	| exp_b oTK exp_b { }
	| noTK exp_b  { }
	| operando { }
	| literalTK { } 
	;

operando: identificadorTK { }
	| operando puntoTK operando { }
	| operando corcheteAbiertoTK expresion corcheteCerradoTK { }
	| operando refTK { }
	;


 // INSTRUCCIONES


instrucciones: instrucciones puntoYComaTK instruccion    { }
	| instruccion { }
	;

instruccion: continuarTK { }
	| asignacion { }
	| alternativa { }
	| iteracion { }
	| accion_ll { }
	;

asignacion: operando asignacionTK expresion { }
	;

alternativa: siTK expresion entoncesTK instrucciones lista_opciones fsiTK   { }
	;

lista_opciones: siNoTK expresion entoncesTK instrucciones lista_opciones       { }
	| { } 
	;

iteracion: it_cota_fija { }
	| it_cota_exo                     { }
	;

it_cota_exp
	: mientrasTK expresion hacerTK instrucciones fmientrasTK         { }
	;

it_cota_fija
	: paraTK identificadorTK asignacionTK expresion hastaTK expresion hacerTK instrucciones fparaTK   { }
	;

%%
int main(int argc, char **argv){
	/* Para ver la traza del parser, poner yydebug = 1; */
	yydebug = 0;
	++argv, --argc;
	if (argc > 0){
		if ((yyin = fopen(argv[0], "r")) == NULL){
			fprintf(stderr, "No se puede abrir el fichero %s\n", argv[0]);
			return 1;
		}
	} else
		yyin = stdin;
	tc = nuevaTablaDeConstantes();
	if (yyparse() == 0)
		printf("COMPILADOR: Sintaxis correcta\n");
	imprimeTablaDeConstantes(tc);
	return 0;
}

void yyerror(char * s){
	printf("\tBISON: ERROR, %s\n", s);
}
