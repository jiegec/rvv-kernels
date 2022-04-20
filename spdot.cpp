
#include "riscv_vector.h"
#include <math.h>
#include <stdlib.h>

extern "C" {
// dot product of two sparse vectors
double spdot(uint64_t len1, const uint64_t *__restrict idx1,
             const double *__restrict val1, uint64_t len2,
             const uint64_t *__restrict idx2, const double *__restrict val2) {
  double res = 0;
  uint64_t i = 0, j = 0;
  // hard to vectorize
  while (i < len1 && j < len2) {
    if (idx1[i] == idx2[j]) {
      res += val1[i++] * val2[j++];
    } else if (idx1[i] < idx2[j]) {
      i++;
    } else {
      j++;
    }
  }

  return res;
}
}