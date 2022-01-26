#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 1000;
const int M = 10;

void spmv(uint64_t n, const uint64_t *row, const uint64_t *col,
          const double *mat, const double *x, double *y);
void spmv_intrinsics(uint64_t n, const uint64_t *row, const uint64_t *col,
                     const double *mat, const double *x, double *y);

int main() {
  uint64_t row[N + 1];
  uint64_t col[N * M];
  double mat[N * M];
  double x[N];

  double y[N];
  double y1[N];

  // each row has M non zero elements
  for (int i = 0; i < N; i++) {
    row[i] = i * M;
    for (int j = 0; j < M; j++) {
      mat[i * M + j] = (double)rand() / RAND_MAX;
      col[i * M + j] = rand() % N;
    }
    x[i] = (double)rand() / RAND_MAX;
    y[i] = 0.0;
    y1[i] = 0.0;
  }
  row[N] = M * N;

  spmv(N, row, col, mat, x, y);
  spmv_intrinsics(N, row, col, mat, x, y1);

  for (int i = 0; i < N; i++) {
    if (fabs(y[i] - y1[i]) > 1e-6) {
      printf("Mismatch at %d: %lf and %lf\n", i, y[i], y1[i]);
      return 1;
    }
  }
  printf("Test passed!\n");

  return 0;
}