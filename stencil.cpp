
#include "riscv_vector.h"
#include <math.h>
#include <stdlib.h>

extern "C" {

void stencil_2d_5p(uint64_t n, uint64_t m, double a0, double a1, double a2,
                   double a3, double a4, const double *__restrict a,
                   double *__restrict b) {
  uint64_t halo = 1;
  uint64_t ldx = m + 2 * halo;
  for (uint64_t x = halo; x < halo + n; x++) {
    for (uint64_t y = halo; y < halo + m; y++) {
      b[x * ldx + y] = a0 * a[(x - 1) * ldx + y] + a1 * a[x * ldx + (y - 1)] +
                       a2 * a[x * ldx + y] + a3 * a[x * ldx + (y + 1)] +
                       a4 * a[(x + 1) * ldx + y];
    }
  }
  return;
}

void stencil_2d_9p(uint64_t n, uint64_t m, double a0, double a1, double a2,
                   double a3, double a4, double a5, double a6, double a7,
                   double a8, const double *__restrict a,
                   double *__restrict b) {
  uint64_t halo = 1;
  uint64_t ldx = m + 2 * halo;
  for (uint64_t x = halo; x < halo + n; x++) {
    for (uint64_t y = halo; y < halo + m; y++) {
      b[x * ldx + y] =
          a0 * a[(x - 1) * ldx + (y - 1)] + a1 * a[(x - 1) * ldx + y] +
          a2 * a[(x - 1) * ldx + (y + 1)] + a3 * a[x * ldx + (y - 1)] +
          a4 * a[x * ldx + y] + a5 * a[x * ldx + (y + 1)] +
          a6 * a[(x + 1) * ldx + (y - 1)] + a7 * a[(x + 1) * ldx + y] +
          a8 * a[(x + 1) * ldx + (y + 1)];
    }
  }
  return;
}
}