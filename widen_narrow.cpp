
#include "riscv_vector.h"

extern "C" {

void widen_float2double(uint64_t n, double *__restrict dst,
                        const float *__restrict src) {
  for (int i = 0; i < n; i++) {
    dst[i] = src[i];
  }
}

void narrow_double2float(uint64_t n, float *__restrict dst,
                         const double *__restrict src) {
  for (int i = 0; i < n; i++) {
    dst[i] = src[i];
  }
}

void fadd_float2double(uint64_t n, double *__restrict dst,
                       const float *__restrict x, const float *__restrict y) {
  for (int i = 0; i < n; i++) {
    dst[i] = x[i] + y[i];
  }
}

void fadd_mixed2double(uint64_t n, double *__restrict dst,
                       const double *__restrict x, const float *__restrict y) {
  for (int i = 0; i < n; i++) {
    dst[i] = x[i] + y[i];
  }
}

void add_int2long(uint64_t n, long *__restrict dst, const int *__restrict x,
                  const int *__restrict y) {
  for (int i = 0; i < n; i++) {
    dst[i] = x[i] + y[i];
  }
}

void mul_int2long(uint64_t n, long *__restrict dst, const int *__restrict x,
                  const int *__restrict y) {
  for (int i = 0; i < n; i++) {
    dst[i] = x[i] * y[i];
  }
}

void mul_uint2ulong(uint64_t n, unsigned long *__restrict dst,
                    const unsigned int *__restrict x,
                    const unsigned int *__restrict y) {
  for (int i = 0; i < n; i++) {
    dst[i] = x[i] * y[i];
  }
}

double sum_float2double(uint64_t n, const float *__restrict x) {
  double res = 0;
#pragma clang loop vectorize(enable)
  for (int i = 0; i < n; i++) {
    res += x[i];
  }
  return res;
}
}