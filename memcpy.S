memcpy_simple:                          # @memcpy_simple
	beqz	a2, .LBB0_13
	sltiu	a3, a2, 16
	sub	a4, a0, a1
	sltiu	a4, a4, 64
	or	a3, a3, a4
	li	a6, 0
	bnez	a3, .LBB0_11
	li	a7, 64
	bgeu	a2, a7, .LBB0_4
	li	a6, 0
	j	.LBB0_8
.LBB0_4:
	andi	a6, a2, -64
	mv	a3, a6
	mv	a5, a0
	mv	a4, a1
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	vsetvli	zero, a7, e8, m2, ta, mu
	vle8.v	v8, (a4)
	vse8.v	v8, (a5)
	addi	a4, a4, 64
	addi	a3, a3, -64
	addi	a5, a5, 64
	bnez	a3, .LBB0_5
	beq	a6, a2, .LBB0_13
	andi	a3, a2, 48
	beqz	a3, .LBB0_11
.LBB0_8:
	mv	a3, a6
	andi	a6, a2, -16
	add	a4, a1, a3
	add	a5, a0, a3
	sub	a3, a3, a6
	vsetivli	zero, 16, e8, mf2, ta, mu
.LBB0_9:                                # =>This Inner Loop Header: Depth=1
	vle8.v	v8, (a4)
	vse8.v	v8, (a5)
	addi	a4, a4, 16
	addi	a3, a3, 16
	addi	a5, a5, 16
	bnez	a3, .LBB0_9
	beq	a6, a2, .LBB0_13
.LBB0_11:
	sub	a2, a2, a6
	add	a4, a0, a6
	add	a1, a1, a6
.LBB0_12:                               # =>This Inner Loop Header: Depth=1
	lb	a3, 0(a1)
	sb	a3, 0(a4)
	addi	a2, a2, -1
	addi	a4, a4, 1
	addi	a1, a1, 1
	bnez	a2, .LBB0_12
.LBB0_13:
	ret
                                        # -- End function
memcpy_libc:                            # @memcpy_libc
	tail	memcpy@plt
                                        # -- End function
