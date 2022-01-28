
#include "riscv_vector.h"
#include <stdlib.h>

extern "C" {

void axpy(uint64_t n, double a, const double *x, double *y) {
  for (uint64_t i = 0; i < n; i++) {
    y[i] += a * x[i];
  }
}

void axpy_rvv(uint64_t n, double a, const double *x, double *y) {
  for (uint64_t i = 0; i < n;) {
    uint64_t vl = vsetvl_e64m1(n - i);

    vfloat64m1_t x_data = vle64_v_f64m1(&x[i], vl);
    vfloat64m1_t y_data = vle64_v_f64m1(&y[i], vl);
    y_data = vfmacc(y_data, a, x_data, vl);

    vse64_v_f64m1(&y[i], y_data, vl);

    i += vl;
  }
}

void axpy_rvv2(uint64_t n, double a, const double *x, double *y) {
  uint64_t vlmax = vsetvlmax_e64m1();
  uint64_t i;
  for (i = 0; i + vlmax < n;) {

    vfloat64m1_t x_data = vle64_v_f64m1(&x[i], vlmax);
    vfloat64m1_t y_data = vle64_v_f64m1(&y[i], vlmax);
    y_data = vfmacc(y_data, a, x_data, vlmax);

    vse64_v_f64m1(&y[i], y_data, vlmax);

    i += vlmax;
  }

  for (; i < n; i++) {
    y[i] += a * x[i];
  }
}

}