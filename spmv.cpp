#include "riscv_vector.h"
#include <stdlib.h>

extern "C" {
void spmv(uint64_t n, const uint64_t *__restrict row,
          const uint64_t *__restrict col, const double *__restrict mat,
          const double *__restrict x, double *__restrict y) {
  for (uint64_t i = 0; i < n; i++) {
    double s = 0;
#pragma clang loop vectorize(enable)
    for (uint64_t p = row[i]; p < row[i + 1]; p++) {
      s += mat[p] * x[col[p]];
    }
    y[i] = s;
  }
}

void spmv_rvv(uint64_t n, const uint64_t *__restrict row,
              const uint64_t *__restrict col, const double *__restrict mat,
              const double *__restrict x, double *__restrict y) {

  for (uint64_t i = 0; i < n; i++) {
    uint64_t vlmax = vsetvlmax_e64m1();
    vfloat64m1_t s = vfmv_v_f_f64m1(0.0, vlmax);

    uint64_t vl;
    for (uint64_t p = row[i]; p < row[i + 1]; p += vl) {
      vl = vsetvl_e64m1(row[i + 1] - p);
      // load mat[p]
      vfloat64m1_t mat_p = vle64_v_f64m1(&mat[p], vl);

      // compute byte offset
      vuint64m1_t col_p = vle64_v_u64m1(&col[p], vl);
      vuint64m1_t col_p_mul = vmul(col_p, 8, vl);

      // load x[col[p]]
      vfloat64m1_t x_col_p = vluxei64(x, col_p_mul, vl);

      // s += mat[p] * x[col[p]];
      s = vfmacc(s, mat_p, x_col_p, vl);
    }

    vfloat64m1_t sum = vfmv_v_f_f64m1(0.0, vlmax);
    sum = vfredusum(sum, s, sum, vlmax);
    y[i] = vfmv_f_s_f64m1_f64(sum);
  }
}

void spmv_rvv2(uint64_t n, const uint64_t *__restrict row,
               const uint64_t *__restrict col, const double *__restrict mat,
               const double *__restrict x, double *__restrict y) {

  uint64_t vlmax = vsetvlmax_e64m1();
  for (uint64_t i = 0; i < n; i++) {
    vfloat64m1_t s = vfmv_v_f_f64m1(0.0, vlmax);

    uint64_t p;
    for (p = row[i]; p + vlmax < row[i + 1]; p += vlmax) {
      // load mat[p]
      vfloat64m1_t mat_p = vle64_v_f64m1(&mat[p], vlmax);

      // compute byte offset
      vuint64m1_t col_p = vle64_v_u64m1(&col[p], vlmax);
      vuint64m1_t col_p_mul = vmul(col_p, 8, vlmax);

      // load x[col[p]]
      vfloat64m1_t x_col_p = vluxei64(x, col_p_mul, vlmax);

      // s += mat[p] * x[col[p]];
      s = vfmacc(s, mat_p, x_col_p, vlmax);
    }

    vfloat64m1_t sum = vfmv_v_f_f64m1(0.0, vlmax);
    sum = vfredusum(sum, s, sum, vlmax);

    // the res part
    double res = vfmv_f_s_f64m1_f64(sum);
    for (; p < row[i + 1]; p++) {
      res += mat[p] * x[col[p]];
    }
    y[i] = res;
  }
}
}