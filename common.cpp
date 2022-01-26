#include <stdint.h>
#include <stdlib.h>
#include <sys/time.h>

uint64_t get_time_us() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return (tv.tv_sec * 1000000) + tv.tv_usec;
}