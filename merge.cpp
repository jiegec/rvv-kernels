
#include "riscv_vector.h"
#include <math.h>
#include <stdlib.h>

extern "C" {
void merge(uint64_t len1, const double *__restrict in1, uint64_t len2,
           const double *__restrict in2, double *__restrict out) {
  double res = 0;
  uint64_t i = 0, j = 0, k = 0;
  // this part is hard to vectorize
  while (i < len1 && j < len2) {
    if (in1[i] < in2[j]) {
      out[k++] = in1[i++];
    } else {
      out[k++] = in2[j++];
    }
  }

  // the rest
  // this part can be vectorized like memcpy
  while (i < len1) {
    out[k++] = in1[i++];
  }
  while (j < len2) {
    out[k++] = in2[j++];
  }
}
}