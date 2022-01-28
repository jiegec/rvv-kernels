LLVM := /llvm
SPIKE := spike
PK := pk
GCC_TOOLCHAIN_DIR := /riscv
CFLAGS := --target=riscv64-unknown-elf -march=rv64gcv1p0 -menable-experimental-extensions -O2 --gcc-toolchain=$(GCC_TOOLCHAIN_DIR)

all: bin/spmv bin/spmv.dump

spike-%: bin/%
	$(SPIKE) --isa=rv64gcv $(PK) $^

bin/spmv: spmv.o spmv_main.o common.o
	$(LLVM)/bin/clang++ $(CFLAGS) $^ -o $@

bin/axpy: axpy.o axpy_main.o common.o
	$(LLVM)/bin/clang++ $(CFLAGS) $^ -o $@

%.o: %.cpp
	$(LLVM)/bin/clang++ -c $(CFLAGS) $^ -o $@

%.dump: %
	$(LLVM)/bin/llvm-objdump --mattr=+v -S $^ > $@

clean:
	rm -rf *.o bin/*