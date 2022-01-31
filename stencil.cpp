
#include "riscv_vector.h"
#include <math.h>
#include <stdlib.h>

extern "C" {

void stencil(uint64_t n, uint64_t m, double a0, double a1, double a2, double a3,
             double a4, const double *a, double *b) {
  uint64_t halo = 1;
  uint64_t ldx = m + 2 * halo;
  for (uint64_t x = halo; x < halo + n; x++) {
    for (uint64_t y = halo; y < halo + m; y++) {
      b[x * ldx + y] = a0 * a[x * ldx + y] + a1 * a[(x - 1) * ldx + y] +
                       a2 * a[(x + 1) * ldx + y] + a3 * a[x * ldx + (y + 1)] +
                       a4 * a[x * ldx + (y - 1)];
    }
  }
  return;
}
}