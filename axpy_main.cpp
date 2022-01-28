#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "common.h"

const int N = 1000;
const int REPEAT = 100;

void axpy(uint64_t n, double a, const double *x, double *y);
void axpy_rvv(uint64_t n, double a, const double *x, double *y);
void axpy_rvv2(uint64_t n, double a, const double *x, double *y);

int main() {
  double x[N];
  double y[N];
  double y1[N];
  double y2[N];

  // each row has M non zero elements
  for (int i = 0; i < N; i++) {
    x[i] = (double)rand() / RAND_MAX;
    y[i] = 0.0;
    y1[i] = 0.0;
    y2[i] = 0.0;
  }
  double a = (double)rand() / RAND_MAX;

  axpy(N, a, x, y);
  axpy_rvv(N, a, x, y1);
  axpy_rvv2(N, a, x, y2);

  for (int i = 0; i < N; i++) {
    if (fabs(y[i] - y1[i]) > 1e-6) {
      printf("Mismatch at %d: %lf and %lf\n", i, y[i], y1[i]);
      return 1;
    }
  }

  for (int i = 0; i < N; i++) {
    if (fabs(y[i] - y2[i]) > 1e-6) {
      printf("Mismatch at %d: %lf and %lf\n", i, y[i], y1[i]);
      return 1;
    }
  }

  printf("Test passed!\n");

  uint64_t begin = get_time_us();
  for (int i = 0; i < REPEAT; i++) {
    axpy(N, a, x, y);
  }
  uint64_t elapsed = get_time_us() - begin;
  double gflops = 2e-3 * N * REPEAT / elapsed;
  printf("axpy scalar: %.2f us %.2f gflops\n", (double)elapsed / REPEAT,
         gflops);

  begin = get_time_us();
  for (int i = 0; i < REPEAT; i++) {
    axpy_rvv(N, a, x, y);
  }
  elapsed = get_time_us() - begin;
  gflops = 2e-3 * N * REPEAT / elapsed;
  printf("spmv vector: %.2f us %.2f gflops\n", (double)elapsed / REPEAT,
         gflops);

  begin = get_time_us();
  for (int i = 0; i < REPEAT; i++) {
    axpy_rvv2(N, a, x, y);
  }
  elapsed = get_time_us() - begin;
  gflops = 2e-3 * N * REPEAT / elapsed;
  printf("spmv vector2: %.2f us %.2f gflops\n", (double)elapsed / REPEAT,
         gflops);

  return 0;
}