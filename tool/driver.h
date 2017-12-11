#ifndef DRIVER
# define DRIVER
# include <string>
# include "parser.tab.hh"
#define YY_DECL \
  yy::analizador_parser::symbol_type yylex (analizador_driver& driver)
YY_DECL;

class analizador_driver
{
public:
  float resultado;
  void iniciarScanner();
  void terminarScanner();
  
  int parse(const std::string& archivo);
  
  std::string file;
};
#endif