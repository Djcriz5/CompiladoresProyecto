#include "driver.h"
#include "parser.tab.hh"

int analizador_driver::parse(const std::string& archivo)
{
  file = archivo;
  iniciarScanner();
  yy::analizador_parser parser(*this);
  parser.set_debug_level(false);
  float resultado = parser.parse();
  terminarScanner();
  return resultado;
}
  