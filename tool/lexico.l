%{
# include <cerrno>
#include <stdio.h>
#include <string>
#include "driver.h"
#include "parser.tab.hh"
#undef yywrap
#define yywrap() 1
static yy::location loc;
%}
%option noyywrap nounput batch debug noinput
%option outfile="scanner.cpp"

TKN_Identificador	\"[^\n"]+\"
ws	[ \t]+
TKN_Enemy Enemy
TKN_Random random
TKN_palabraReservada attackspeed|movementspeed|maxhealt|attackdamage
TKN_Integer [0-9]+
TKN_Decimal [0-9]+"."[0-9]+

%%

"{"		{return yy::analizador_parser::make_BracketIz(loc);}
"}"		{return yy::analizador_parser::make_BracketDer(loc);}
":"		{return yy::analizador_parser::make_DPunto(loc);}
","		{return yy::analizador_parser::make_Coma(loc);}
{TKN_Identificador}	{return yy::analizador_parser::make_TKN_Identificador(yytext,loc);}
{TKN_Enemy}	{return yy::analizador_parser::make_TKN_Enemy(loc);}
{TKN_Random}	{return yy::analizador_parser::make_TKN_Random(loc);}
{TKN_palabraReservada}	{return yy::analizador_parser::make_TKN_palabraReservada(yytext,loc);}
{TKN_Integer}	{return yy::analizador_parser::make_TKN_Integer((int)strtol (yytext, NULL, 10),loc);}
{TKN_Decimal}	{return yy::analizador_parser::make_TKN_Decimal(strtol (yytext, NULL, 10),loc);}
.               {printf("ERROR LEXICO: %s\n",yytext);}
{ws}  {}
<<EOF>>		{return yy::analizador_parser::make_FIN(loc);}

%%
void analizador_driver::iniciarScanner()
{
  yy_flex_debug = false;
  if(file.empty() || file == "-"){
    printf("No se encuentra el archivo de entrada");
    exit(1);
  }else{
    yyin = fopen (file.c_str (), "r");
  }
}
void analizador_driver::terminarScanner()
{
  fclose(yyin);
}