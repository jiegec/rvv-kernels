
#include "riscv_vector.h"
#include <stdlib.h>

extern "C" {

double asum(uint64_t n, const double *__restrict x) {
  double res = 0;
#pragma clang loop vectorize(enable)
  for (uint64_t i = 0; i < n; i++) {
    res += abs(x[i]);
  }
  return res;
}
}