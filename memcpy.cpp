
#include "riscv_vector.h"
#include <stdlib.h>
#include <string.h>

extern "C" {
void *memcpy_simple(void *__restrict dest, const void *__restrict src,
                    size_t n) {
  char *__restrict cdest = (char *)dest;
  const char *__restrict csrc = (const char *)src;

  for (size_t i = 0; i < n; i++) {
    cdest[i] = csrc[i];
  }
  return dest;
}

void *memcpy_libc(void *__restrict dest, const void *__restrict src,
                    size_t n) {
  return memcpy(dest, src, n);
}
}