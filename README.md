# rvv-kernels

Implements kernels with RISC-V Vector. Requires LLVM 14.

Kernels included:

- asum
- axpy
- dot
- nrm2
- gemm
- spmv
- stencil

Generated assemblies are also provided in this repo for reference.

## How to build

You need:

1. Clang+LLVM 14
2. RISC-V GNU Toolchain

To build with system clang++-14:

```shell
make GCC_TOOLCHAIN_DIR=/path/to/gnu-toolchain CXX=/usr/bin/clang++-14 -j8
```

To build with upstream clang:

```shell
make GCC_TOOLCHAIN_DIR=/path/to/gnu-toolchain LLVM=/path/to/llvm -j8
```

## How to run in spike

To run vectorized kernel in spike:

```shell
make GCC_TOOLCHAIN_DIR=/path/to/gnu-toolchain CXX=/usr/bin/clang++-14 PK=/path/to/spike/bin/pk spike-xxx
```

Some examples:

```shell
$ make spike-axpy
axpy disable vectorize: 8.02 us 0.25 gflops
axpy compiler vectorize: 3.53 us 0.57 gflops
axpy rvv: 6.02 us 0.33 gflops
axpy rvv2: 6.04 us 0.33 gflops
$ make spike-spmv
spmv disable vectorize: 118.03 us 0.17 gflops
spmv compiler vectorize: 85.05 us 0.24 gflops
spmv rvv: 88.02 us 0.23 gflops
spmv rvv2: 97.03 us 0.21 gflops
```