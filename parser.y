 // Archivo: Escribe por pantalla la tabla de símbolos que genera durante
 // la compilación y la de cuadruplas que se genera
 // Autor: Saray Lopez y Diana Manevska
 // Fecha: 09/11/2026
 // Version: 0.0.1


 // RUTINAS SEMÁNTICAS VACÍAS {} PONER EN TODAS LAS PRODUCCIONES !!!!!

 //  1: ZONA DE DECLARACIONES
%{
	#include <stdio.h>
	#include "nombresDeTipos.h"
	#include "literal.h"
	#include "tablaDeConstantes.h"

	int yylex(); // Usamos la funcion que se crea gracias a flex
	void yyerror(char *); // Prototipo de una funcion necesaria
	extern FILE* yyin; // Usamos la varible de Flex en la que viene la entrada

	TablaDeConstantes tc; //Es donde guardaremos las constantes
	#define YYDEBUG 1 //Permite activar el modo Debugg de Bison
%}

 //PARTE 2.2: Declaracion de los tokens del lenguaje y declaracion de los tipos del
 // union en los que flex nos enviara el valor asociado a los tokens multivaluados

 // Tokens multivaluados (el scanner debe rellenar yylval.<campo>)
%token <literal> literalTK
//%token <cadena> nombreCteTK
%token <cadena> identificadorTK

// palabras reservadas
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

// operadores y signos
%token igualTK
%token operadorRestaTK
%token operadorSumaTK
%token operadorProductoTK
%token operadorDivisionTK
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

// comentarios
%token comentarioTK


 //PARTE 2.3: Definiciones (algunas innecesarias) de prioridades --> de MNEOR a MAYOR
/*
%nonassoc constTK //hago no asociativo y de baja prioridad a constTK
%right fconstTK //hago fcosntTK es mas prioritario que constTK y asociativo a derecha
%left puntoYComaTK //Hago muy prioritario y asociativo a izquierdas al ;
*/
// ponemos las que ya conocemos
%left operadorSumaTK
%left operadorRestaTK
%left operadorProductoTK
%left operadorDivisionTK
%left parentesisAbiertoTK
%left parentesisCerradoTK
%left puntoYComaTK
%left comaTK
%left puntoTK
%right igualTK

 //PARTE 2.3: Creamos el union necesario para valores de flex y traducciones de bison


 //PARTE 2.4: Asignacion de traducciones a las variables



// GRAMÁTICA DEL ALGORITMO

%%


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

d_tipo: tuplaTK lista_campos ftuplaTK { }
	| tablaTK corcheteAbiertoTK expresion_t subrangoTK expresion_t corcheteCerradoTK deTK d_tipo { }
	| identificadorTK { }
	| expresion_t puntoTK puntoTK expresion_t { }
	| refTK d_tipo { }
	| tipo_base { }
	;

tipo_base: enteroTK { }
	| booleanoTK { }
	| caracterTK { }
	| realTK { }
	| cadenaTK { }
	;

expresion_t: expresion { }
	| literalTK { }
	;

lista_campos: identificadorTK dosPuntosTK d_tipo puntoYComaTK lista_campos { }
	| { }
	;

// CONSTANTES Y VARIABLES
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

// EXPRESIONES
expresion: exp_a { }
	| exp_b { }
	| funcion_ll { }
	;

exp_a: exp_a operadorSumaTK exp_a { }
	| exp_a operadorRestaTK exp_a { }
	| exp_a operadorProductoTK exp_a { }
	| exp_a operadorDivisionTK exp_a { }
	| exp_a modTK exp_a { }
	| exp_a divTK exp_a { }
	| parentesisAbiertoTK exp_a parentesisCerradoTK { }
	| operando { }
	| realTK { }
	| operadorRestaTK exp_a { }
	| operadorSumaTK exp_a { }
	;

exp_b: exp_b yTK exp_b { }
	| exp_b oTK exp_b { }
	| noTK exp_b  { }
	| operando { }
	| literalTK { }
	| expresion oprel expresion { }
	| parentesisAbiertoTK exp_b  parentesisCerradoTK { }
	;

oprel: operadorMenorTK { }
	| operadorMayorTK { }
	| igualTK { }
	| operadorDistintoTK { }
	| operadorMayorIgualTK { }
	| operadorMenorIgualTK { }
	;

operando: identificadorTK { }
	| operando puntoTK operando { }
	| operando corcheteAbiertoTK expresion corcheteCerradoTK { }
	| operando refTK { }
	;

// INTRUCCIONES
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

lista_opciones: siNoTK expresion entoncesTK instrucciones lista_opciones { }
	| { }
	;

iteracion: it_cota_fija { }
	| it_cota_exp { }
	;

it_cota_exp: mientrasTK expresion hacerTK instrucciones fmientrasTK { }
	;

it_cota_fija: paraTK identificadorTK asignacionTK expresion hastaTK expresion hacerTK instrucciones fparaTK   { }
	;

// ACCIONES Y FUNCIONES
accion_d: accionTK a_cabecera bloque faccionTK { }
	;

funcion_d: funcionTK f_cabecera bloque devTK expresion ffuncionTK { }
	;

a_cabecera: identificadorTK parentesisAbiertoTK d_par_form parentesisCerradoTK puntoYComaTK { }
	;

f_cabecera: identificadorTK parentesisAbiertoTK lista_d_var parentesisCerradoTK devTK d_tipo puntoYComaTK { }
	;

d_par_form: d_p_form puntoYComaTK d_par_form { }
	| { }
	;

d_p_form: entTK lista_id dosPuntosTK d_tipo { }
	| salTK lista_id dosPuntosTK d_tipo { }
	| entSalTK lista_id dosPuntosTK d_tipo { }
	;

accion_ll: identificadorTK parentesisAbiertoTK l_ll parentesisCerradoTK { }
	;

funcion_ll: identificadorTK parentesisAbiertoTK l_ll parentesisCerradoTK { }
	;

l_ll: expresion comaTK l_ll { }
	| expresion { }
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
