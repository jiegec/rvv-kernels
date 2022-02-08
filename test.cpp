
#include "riscv_vector.h"
#include <math.h>
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

void test_axpy_inner(uint64_t n, double a, const double *__restrict x,
                     double *__restrict y) {
  uint64_t vlmax = vsetvlmax_e64m1();
  uint64_t i;
  vfloat64m1_t x_data = vle64_v_f64m1(x, vlmax);
  vfloat64m1_t y_data = vle64_v_f64m1(y, vlmax);
  y_data = vfmacc(y_data, a, x_data, vlmax);

  vse64_v_f64m1(&y[i], y_data, vlmax);
}

void test_l1dist(uint64_t n, double *__restrict res, const double *__restrict x,
                 const double *__restrict y) {
  for (int i = 0; i < n; i++) {
    res[i] = abs(x[i]) + abs(y[i]);
  }
}

void test_l2dist(uint64_t n, double *__restrict res, const double *__restrict x,
                 const double *__restrict y) {
  for (int i = 0; i < n; i++) {
    res[i] = sqrt(x[i] * x[i] + y[i] * y[i]);
  }
}

void test_sqrt(uint64_t n, double *__restrict x) {
  for (int i = 0; i < n; i++) {
    x[i] = sqrt(x[i]);
  }
}

void test_exp(uint64_t n, double *__restrict x) {
  for (int i = 0; i < n; i++) {
    x[i] = exp(x[i]);
  }
}

void test_round(uint64_t n, double *__restrict x) {
  for (int i = 0; i < n; i++) {
    x[i] = round(x[i]);
  }
}

void test_fpclassify(uint64_t n, int *__restrict c,
                     const double *__restrict x) {
  for (int i = 0; i < n; i++) {
    c[i] = fpclassify(x[i]);
  }
}
}