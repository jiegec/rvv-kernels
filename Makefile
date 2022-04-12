LLVM := /llvm
SPIKE := spike
PK := pk
GCC_TOOLCHAIN_DIR := /riscv

LD := $(GCC_TOOLCHAIN_DIR)/bin/riscv64-unknown-elf-ld
CXX := $(LLVM)/bin/clang++
CFLAGS := -fuse-ld=$(LD) --target=riscv64-unknown-elf -march=rv64gcv1p0 -menable-experimental-extensions -mllvm --riscv-v-vector-bits-min=128 -O2 --gcc-toolchain=$(GCC_TOOLCHAIN_DIR)

BINS := bin/spmv bin/axpy
ASMS := spmv.S axpy.S gemm.S memcpy.S dot.S nrm2.S asum.S stencil.S test.S widen_narrow.S
IRS := $(patsubst %.S,%.ll,$(ASMS))

all: $(BINS) $(ASMS) $(IRS) toolchain-version

toolchain-version: $(CXX)
	$(CXX) --version > $@

spike-%: bin/%
	$(SPIKE) --isa=rv64gcv $(PK) $^

bin/spmv: spmv.o spmv_main.o common.o
	$(CXX) $(CFLAGS) $^ -o $@

bin/axpy: axpy.o axpy_main.o common.o
	$(CXX) $(CFLAGS) $^ -o $@

%.o: %.cpp $(CXX)
	$(CXX) -c $(CFLAGS) $< -o $@

%.ll: %.cpp $(CXX)
	$(CXX) -S -emit-llvm $(CFLAGS) $< -o $@

%.S: %.cpp $(CXX)
	$(CXX) -S $(CFLAGS) $< -o $@
	python3 filter.py $@

%.dump: %
	$(LLVM)/bin/llvm-objdump --mattr=+v -S $^ > $@

clean:
	rm -rf *.o *.S *.ll bin/* toolchain-version
