memcpy_simple:                          # @memcpy_simple
	beqz	a2, .LBB0_15
	li	a3, 16
	bgeu	a2, a3, .LBB0_3
	li	a7, 0
	j	.LBB0_13
.LBB0_3:
	add	a3, a0, a2
	add	a4, a1, a2
	sltu	a4, a0, a4
	sltu	a3, a1, a3
	and	a3, a3, a4
	li	a7, 0
	bnez	a3, .LBB0_13
	li	a6, 64
	bgeu	a2, a6, .LBB0_6
	li	a7, 0
	j	.LBB0_10
.LBB0_6:
	andi	a7, a2, -64
	addi	t1, a1, 32
	addi	a4, a0, 32
	mv	a3, a7
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
	addi	t0, t1, -32
	vsetvli	zero, a6, e8, m2, ta, mu
	vle8.v	v8, (t0)
	addi	a5, a4, -32
	vse8.v	v8, (a5)
	addi	t1, t1, 64
	addi	a3, a3, -64
	addi	a4, a4, 64
	bnez	a3, .LBB0_7
	beq	a7, a2, .LBB0_15
	andi	a3, a2, 48
	beqz	a3, .LBB0_13
.LBB0_10:
	mv	a5, a7
	andi	a7, a2, -16
	add	a4, a1, a5
	add	a3, a0, a5
	sub	a5, a5, a7
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
	vsetivli	zero, 16, e8, mf2, ta, mu
	vle8.v	v8, (a4)
	vse8.v	v8, (a3)
	addi	a4, a4, 16
	addi	a5, a5, 16
	addi	a3, a3, 16
	bnez	a5, .LBB0_11
	beq	a7, a2, .LBB0_15
.LBB0_13:
	sub	a2, a2, a7
	add	a3, a0, a7
	add	a1, a1, a7
.LBB0_14:                               # =>This Inner Loop Header: Depth=1
	lb	a4, 0(a1)
	sb	a4, 0(a3)
	addi	a2, a2, -1
	addi	a3, a3, 1
	addi	a1, a1, 1
	bnez	a2, .LBB0_14
.LBB0_15:
	ret
                                        # -- End function
memcpy_libc:                            # @memcpy_libc
	tail	memcpy@plt
                                        # -- End function
