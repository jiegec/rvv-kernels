merge:                                  # @merge
	addi	sp, sp, -32
	sd	s0, 24(sp)                      # 8-byte Folded Spill
	sd	s1, 16(sp)                      # 8-byte Folded Spill
	sd	s2, 8(sp)                       # 8-byte Folded Spill
	sd	s3, 0(sp)                       # 8-byte Folded Spill
	seqz	a5, a0
	seqz	s1, a2
	or	a5, a5, s1
	li	t5, 0
	li	a7, 0
	li	t0, 0
	bnez	a5, .LBB0_5
	li	t0, 0
	li	a7, 0
	li	t5, 0
	mv	a5, a4
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	xori	s0, s1, 1
	add	t5, t5, s1
	add	a7, a7, s0
	fsd	ft0, 0(a5)
	addi	t0, t0, 1
	sltu	s1, t5, a0
	sltu	s0, a7, a2
	and	s1, s1, s0
	addi	a5, a5, 8
	beqz	s1, .LBB0_5
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	slli	s1, t5, 3
	add	s1, s1, a1
	fld	ft0, 0(s1)
	slli	s1, a7, 3
	add	s1, s1, a3
	fld	ft1, 0(s1)
	flt.d	s1, ft0, ft1
	bnez	s1, .LBB0_2
	fmv.d	ft0, ft1
	j	.LBB0_2
.LBB0_5:
	mv	a6, t0
	bgeu	t5, a0, .LBB0_13
	add	t1, t0, a0
	sub	t2, a0, t5
	li	a5, 8
	sub	a6, t1, t5
	mv	t3, t0
	mv	t4, t5
	bltu	t2, a5, .LBB0_11
	slli	s2, t0, 3
	add	t3, a4, s2
	slli	a5, a6, 3
	add	s0, a4, a5
	slli	s3, t5, 3
	add	a5, a1, s3
	slli	s1, a0, 3
	add	s1, s1, a1
	sltu	s1, t3, s1
	sltu	a5, a5, s0
	and	a5, a5, s1
	mv	t3, t0
	mv	t4, t5
	bnez	a5, .LBB0_11
	andi	t6, t2, -8
	add	t3, t0, t6
	add	t4, t5, t6
	add	a5, s3, a1
	addi	s3, a5, 32
	add	s0, s2, a4
	addi	s0, s0, 32
	mv	s1, t6
.LBB0_9:                                # =>This Inner Loop Header: Depth=1
	addi	s2, s3, -32
	vsetivli	zero, 8, e64, m2, ta, mu
	vle64.v	v8, (s2)
	addi	a5, s0, -32
	vse64.v	v8, (a5)
	addi	s1, s1, -8
	addi	s3, s3, 64
	addi	s0, s0, 64
	bnez	s1, .LBB0_9
	beq	t2, t6, .LBB0_13
.LBB0_11:
	sub	a5, t1, t3
	sub	a5, a5, t5
	slli	s1, t3, 3
	add	s0, a4, s1
	slli	s1, t4, 3
	add	a1, a1, s1
.LBB0_12:                               # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fsd	ft0, 0(s0)
	addi	a5, a5, -1
	addi	s0, s0, 8
	addi	a1, a1, 8
	bnez	a5, .LBB0_12
.LBB0_13:
	bgeu	a7, a2, .LBB0_23
	sub	t1, a2, a7
	li	a5, 8
	mv	a1, a6
	mv	t2, a7
	bltu	t1, a5, .LBB0_21
	slli	t3, a6, 3
	add	a1, a4, t3
	add	a5, t0, a2
	mv	s1, t5
	bltu	a0, t5, .LBB0_17
	mv	s1, a0
.LBB0_17:
	add	a0, a5, s1
	add	a5, t5, a7
	sub	a0, a0, a5
	slli	a0, a0, 3
	add	a5, a4, a0
	slli	a0, a7, 3
	add	s1, a3, a0
	slli	s0, a2, 3
	add	s0, s0, a3
	sltu	a1, a1, s0
	sltu	a5, s1, a5
	and	a5, a5, a1
	mv	a1, a6
	mv	t2, a7
	bnez	a5, .LBB0_21
	andi	t0, t1, -8
	add	a1, a6, t0
	add	t2, a7, t0
	add	a0, a0, a3
	addi	a5, a0, 32
	add	a0, t3, a4
	addi	s0, a0, 32
	mv	a0, t0
.LBB0_19:                               # =>This Inner Loop Header: Depth=1
	addi	s1, a5, -32
	vsetivli	zero, 8, e64, m2, ta, mu
	vle64.v	v8, (s1)
	addi	s1, s0, -32
	vse64.v	v8, (s1)
	addi	a0, a0, -8
	addi	a5, a5, 64
	addi	s0, s0, 64
	bnez	a0, .LBB0_19
	beq	t1, t0, .LBB0_23
.LBB0_21:
	add	a0, a6, a2
	sub	a0, a0, a1
	sub	a0, a0, a7
	slli	a1, a1, 3
	add	a1, a1, a4
	slli	a2, t2, 3
	add	a2, a2, a3
.LBB0_22:                               # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a2)
	fsd	ft0, 0(a1)
	addi	a0, a0, -1
	addi	a1, a1, 8
	addi	a2, a2, 8
	bnez	a0, .LBB0_22
.LBB0_23:
	ld	s0, 24(sp)                      # 8-byte Folded Reload
	ld	s1, 16(sp)                      # 8-byte Folded Reload
	ld	s2, 8(sp)                       # 8-byte Folded Reload
	ld	s3, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
