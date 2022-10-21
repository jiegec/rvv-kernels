# Override these variables to your local path
SPIKE := spike
PK := pk
TARGET := riscv64-unknown-elf

# Default to https://github.com/jiegec/riscv-toolchain
GCC_TOOLCHAIN_DIR := /data/riscv-toolchain/build
# or crosstool-ng
# GCC_TOOLCHAIN_DIR := ~/x-tools/riscv64-unknown-elf

# Default to system clang 15
# You can install it from https://apt.llvm.org/
LLVM := /usr
CXX := $(LLVM)/bin/clang++-15
LD := $(GCC_TOOLCHAIN_DIR)/bin/$(TARGET)-ld

CFLAGS := --target=$(TARGET) -march=rv64gcv1p0 -menable-experimental-extensions -mllvm --riscv-v-vector-bits-min=256 -O2 --gcc-toolchain=$(GCC_TOOLCHAIN_DIR)
LDFLAGS := -fuse-ld=$(LD) $(CFLAGS)

BINS := bin/spmv bin/axpy
ASMS := spmv.S axpy.S gemm.S memcpy.S dot.S nrm2.S asum.S stencil.S test.S widen_narrow.S merge.S spdot.S
IRS := $(patsubst %.S,%.ll,$(ASMS))
INSTS := $(patsubst %.S,%.inst,$(ASMS))

all: $(BINS) $(ASMS) $(IRS) $(INSTS) toolchain-version

toolchain-version: $(CXX)
	$(CXX) --version > $@

spike-%: bin/%
	$(SPIKE) --isa=rv64gcv --varch=vlen:256,elen:64 $(PK) $^

bin/spmv: spmv.o spmv_main.o common.o
	$(CXX) $(LDFLAGS) $^ -o $@

bin/axpy: axpy.o axpy_main.o common.o
	$(CXX) $(LDFLAGS) $^ -o $@

%.o: %.cpp $(CXX)
	$(CXX) -c $(CFLAGS) $< -o $@

%.ll: %.cpp $(CXX)
	$(CXX) -S -emit-llvm $(CFLAGS) $< -o $@

%.S: %.cpp $(CXX)
	$(CXX) -S $(CFLAGS) $< -o $@
	python3 filter.py $@

%.inst: %.o
	riscv64-unknown-elf-objdump -d $^ -M no-aliases | awk '{print $$3}' | sort | uniq | grep -v section | grep -v format > $@
 

%.dump: %
	$(LLVM)/bin/llvm-objdump --mattr=+v -S $^ > $@

clean:
	rm -rf *.o *.S *.ll bin/* toolchain-version
