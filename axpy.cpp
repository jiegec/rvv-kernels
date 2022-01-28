
#include "riscv_vector.h"
#include <stdlib.h>

void axpy(uint64_t n, double a, const double *x, double *y) {
  for (uint64_t i = 0; i < n; i++) {
    y[i] += a * x[i];
  }
}

void axpy_rvv(uint64_t n, double a, const double *x, double *y) {
  for (uint64_t i = 0; i < n;) {
    uint64_t vl = vsetvl_e64m1(n - i);

    vfloat64m1_t x_data = vle64_v_f64m1(&x[i], vl);
    vfloat64m1_t y_data = vfmul(x_data, a, vl);

    vse64_v_f64m1(&y[i], y_data, vl);

    i += vl;
  }
}