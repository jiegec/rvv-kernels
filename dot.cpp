
#include "riscv_vector.h"
#include <stdlib.h>

extern "C" {

double dot(uint64_t n, const double *__restrict x, const double *__restrict y) {
  double res = 0;
#pragma clang loop vectorize(enable)
  for (uint64_t i = 0; i < n; i++) {
    res += x[i] * y[i];
  }
  return res;
}
}