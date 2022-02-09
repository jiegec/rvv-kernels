LLVM := /llvm
SPIKE := spike
PK := pk
GCC_TOOLCHAIN_DIR := /riscv
CFLAGS := --target=riscv64-unknown-elf -march=rv64gcv1p0 -menable-experimental-extensions -mllvm --riscv-v-vector-bits-min=128 -O2 --gcc-toolchain=$(GCC_TOOLCHAIN_DIR)

BINS := bin/spmv bin/axpy
ASMS := spmv.S axpy.S gemm.S memcpy.S dot.S nrm2.S asum.S stencil.S test.S widen_narrow.S
IRS := $(patsubst %.S,%.ll,$(ASMS))

all: $(BINS) $(ASMS) $(IRS) toolchain-version

toolchain-version: $(LLVM)/bin/clang++
	$(LLVM)/bin/clang++ --version > $@

spike-%: bin/%
	$(SPIKE) --isa=rv64gcv $(PK) $^

bin/spmv: spmv.o spmv_main.o common.o
	$(LLVM)/bin/clang++ $(CFLAGS) $^ -o $@

bin/axpy: axpy.o axpy_main.o common.o
	$(LLVM)/bin/clang++ $(CFLAGS) $^ -o $@

%.o: %.cpp $(LLVM)/bin/clang++
	$(LLVM)/bin/clang++ -c $(CFLAGS) $< -o $@

%.ll: %.cpp $(LLVM)/bin/clang++
	$(LLVM)/bin/clang++ -S -emit-llvm $(CFLAGS) $< -o $@

%.S: %.cpp $(LLVM)/bin/clang++
	$(LLVM)/bin/clang++ -S $(CFLAGS) $< -o $@
	python3 filter.py $@

%.dump: %
	$(LLVM)/bin/llvm-objdump --mattr=+v -S $^ > $@

clean:
	rm -rf *.o *.S *.ll bin/* toolchain-version