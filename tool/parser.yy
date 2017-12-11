%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.0.2"
%defines
%define parser_class_name {analizador_parser}
%define api.token.constructor
%define api.namespace {yy}
%define api.value.type variant
%define parse.assert
%code requires
{
#include <string>
#include <stdio.h>
class analizador_driver;
}
%param { analizador_driver& driver }
%locations
%define parse.trace
%define parse.error verbose
%code
{
#include "driver.h"
#include <iostream>
}

//Listadode Terminales
%token BracketDer "}"
%token BracketIz "{"
%token DPunto ":"
%token Coma ","
%token TKN_Random 
%token TKN_Enemy 
%token <std::string> TKN_Identificador 
%token <std::string> TKN_palabraReservada 
%token <int> TKN_Integer 
%token <float> TKN_Decimal
%token FIN  0 "eof"

//Listado de No Terminales

%printer { yyoutput << $$; } <*>;
%%
%start definicion;

definicion: listaDefinicion definicion;

listaDefinicion :definicion;

definicion : TKN_Enemy TKN_Identificador cuerpo;

cuerpo : "{" expresion "}";

expresion :  listaExpresion expresion;

listaExpresion : expresion;

expresion : TKN_palabraReservada ":" valor ",";

valor : TKN_Random
      |TKN_Integer
      |TKN_Decimal;
%%
void yy::analizador_parser::error(const location_type& lugar, const std::string& lexema)
{
  std::cout << "Error Sintactico " << lexema << std::endl;
}