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