
#include "riscv_vector.h"
#include <math.h>
#include <stdlib.h>

extern "C" {

double nrm2(uint64_t n, const double *__restrict x) {
  double res = 0;
#pragma clang loop vectorize(enable)
  for (uint64_t i = 0; i < n; i++) {
    res += x[i] * x[i];
  }
  return sqrt(res);
}
}