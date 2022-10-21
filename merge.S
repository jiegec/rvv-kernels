merge:                                  # @merge
	seqz	a6, a0
	seqz	a5, a2
	or	a5, a6, a5
	li	t1, 0
	li	a7, 0
	li	a6, 0
	bnez	a5, .LBB0_5
	li	a6, 0
	li	a7, 0
	li	t1, 0
	mv	t0, a4
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	xori	t2, a5, 1
	add	t1, t1, a5
	add	a7, a7, t2
	fsd	ft0, 0(t0)
	addi	a6, a6, 1
	sltu	t2, t1, a0
	sltu	a5, a7, a2
	and	a5, t2, a5
	addi	t0, t0, 8
	beqz	a5, .LBB0_5
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	slli	a5, t1, 3
	add	a5, a5, a1
	fld	ft0, 0(a5)
	slli	a5, a7, 3
	add	a5, a5, a3
	fld	ft1, 0(a5)
	flt.d	a5, ft0, ft1
	bnez	a5, .LBB0_2
	fmv.d	ft0, ft1
	j	.LBB0_2
.LBB0_5:
	bgeu	t1, a0, .LBB0_12
	add	t0, a6, a0
	sub	t4, a0, t1
	li	a0, 8
	sub	t2, t0, t1
	bltu	t4, a0, .LBB0_8
	slli	a0, a6, 3
	add	t6, a0, a4
	slli	a0, t1, 3
	add	a5, a0, a1
	sub	t3, t6, a5
	li	a0, 64
	bgeu	t3, a0, .LBB0_21
.LBB0_8:
	mv	t3, t1
.LBB0_9:
	sub	a0, t0, a6
	sub	t0, a0, t1
	slli	a5, a6, 3
	add	a5, a5, a4
	slli	a0, t3, 3
	add	a1, a1, a0
.LBB0_10:                               # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fsd	ft0, 0(a5)
	addi	t0, t0, -1
	addi	a5, a5, 8
	addi	a1, a1, 8
	bnez	t0, .LBB0_10
.LBB0_11:
	mv	a6, t2
.LBB0_12:
	bgeu	a7, a2, .LBB0_20
	sub	t0, a2, a7
	li	a0, 8
	mv	t3, a6
	mv	t1, a7
	bltu	t0, a0, .LBB0_18
	slli	a0, a6, 3
	add	a0, a0, a4
	slli	a1, a7, 3
	add	a5, a1, a3
	sub	a1, a0, a5
	li	t2, 64
	mv	t3, a6
	mv	t1, a7
	bltu	a1, t2, .LBB0_18
	andi	t2, t0, -8
	add	t3, a6, t2
	add	t1, a7, t2
	vsetivli	zero, 8, e64, m2, ta, mu
	mv	a1, t2
.LBB0_16:                               # =>This Inner Loop Header: Depth=1
	vle64.v	v8, (a5)
	vse64.v	v8, (a0)
	addi	a1, a1, -8
	addi	a0, a0, 64
	addi	a5, a5, 64
	bnez	a1, .LBB0_16
	beq	t0, t2, .LBB0_20
.LBB0_18:
	add	a0, a6, a2
	sub	a0, a0, t3
	sub	a0, a0, a7
	slli	a1, t3, 3
	add	a1, a1, a4
	slli	a2, t1, 3
	add	a2, a2, a3
.LBB0_19:                               # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a2)
	fsd	ft0, 0(a1)
	addi	a0, a0, -1
	addi	a1, a1, 8
	addi	a2, a2, 8
	bnez	a0, .LBB0_19
.LBB0_20:
	ret
.LBB0_21:
	andi	t5, t4, -8
	add	a6, a6, t5
	add	t3, t1, t5
	vsetivli	zero, 8, e64, m2, ta, mu
	mv	a0, t5
.LBB0_22:                               # =>This Inner Loop Header: Depth=1
	vle64.v	v8, (a5)
	vse64.v	v8, (t6)
	addi	a0, a0, -8
	addi	t6, t6, 64
	addi	a5, a5, 64
	bnez	a0, .LBB0_22
	bne	t4, t5, .LBB0_9
	j	.LBB0_11
                                        # -- End function
