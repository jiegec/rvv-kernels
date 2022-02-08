
#include "riscv_vector.h"
#include <stdlib.h>

extern "C" {

void test_cond(uint64_t n, double *__restrict x) {
#pragma clang loop vectorize(enable)
  for (int i = 0; i < n; i++) {
    if (x[i] > 1.0) {
      x[i] = 0.0;
    }
  }
}

void test_axpy(uint64_t n, double a, const double *__restrict x,
               double *__restrict y) {
  uint64_t vlmax = vsetvlmax_e64m1();
  uint64_t i;
  vfloat64m1_t x_data = vle64_v_f64m1(x, vlmax);
  vfloat64m1_t y_data = vle64_v_f64m1(y, vlmax);
  y_data = vfmacc(y_data, a, x_data, vlmax);

  vse64_v_f64m1(&y[i], y_data, vlmax);
}
}