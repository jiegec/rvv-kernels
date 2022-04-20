spdot:                                  # @spdot
	seqz	a6, a0
	seqz	a7, a3
	or	a6, a6, a7
	bnez	a6, .LBB0_8
	li	a6, 0
	li	a7, 0
	fmv.d.x	fa0, zero
	j	.LBB0_4
.LBB0_2:                                #   in Loop: Header=BB0_4 Depth=1
	add	t0, t0, a2
	fld	ft0, 0(t0)
	add	t0, a5, t1
	fld	ft1, 0(t0)
	addi	a7, a7, 1
	addi	a6, a6, 1
	fmadd.d	fa0, ft0, ft1, fa0
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=1
	sltu	t0, a7, a0
	sltu	t1, a6, a3
	and	t0, t0, t1
	beqz	t0, .LBB0_9
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	slli	t0, a7, 3
	add	t1, a1, t0
	ld	t2, 0(t1)
	slli	t1, a6, 3
	add	t3, a4, t1
	ld	t3, 0(t3)
	beq	t2, t3, .LBB0_2
	bgeu	t2, t3, .LBB0_7
	addi	a7, a7, 1
	j	.LBB0_3
.LBB0_7:                                #   in Loop: Header=BB0_4 Depth=1
	addi	a6, a6, 1
	j	.LBB0_3
.LBB0_8:
	fmv.d.x	fa0, zero
.LBB0_9:
	ret
                                        # -- End function
