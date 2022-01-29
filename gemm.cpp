
#include "riscv_vector.h"
#include <stdlib.h>

extern "C" {

void gemm(uint64_t n, uint64_t m, uint64_t k, double alpha, double beta,
          const double *a, const double *b, double *c) {
  for (uint64_t ii = 0; ii < n; ii++) {
    for (uint64_t jj = 0; jj < k; jj++) {
      double s = beta * c[ii * k + jj];
#pragma clang loop vectorize(enable)
      for (uint64_t kk = 0; kk < m; kk++) {
        s += a[ii * m + kk] * b[kk * k + jj];
      }
      c[ii * k + jj] = s;
    }
  }
}
}