asum:                                   # @asum
	beqz	a0, .LBB0_3
	li	a2, 8
	bgeu	a0, a2, .LBB0_4
	li	a2, 0
	fmv.d.x	fa0, zero
	j	.LBB0_7
.LBB0_3:
	fmv.d.x	fa0, zero
	ret
.LBB0_4:
	andi	a2, a0, -8
	fmv.d.x	ft0, zero
	fneg.d	ft0, ft0
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, ft0
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv.v.v	v9, v8
	vmv.s.x	v9, zero
	mv	a3, a2
	mv	a4, a1
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	addi	a5, a4, 32
	vsetvli	zero, zero, e64, m1, ta, mu
	vle64.v	v10, (a4)
	vle64.v	v11, (a5)
	vfabs.v	v10, v10
	vfabs.v	v11, v11
	vfadd.vv	v9, v9, v10
	vfadd.vv	v8, v8, v11
	addi	a3, a3, -8
	addi	a4, a4, 64
	bnez	a3, .LBB0_5
	vfadd.vv	v8, v8, v9
	vfmv.s.f	v9, ft0
	vfredosum.vs	v8, v8, v9
	vfmv.f.s	fa0, v8
	beq	a2, a0, .LBB0_9
.LBB0_7:
	sub	a0, a0, a2
	slli	a2, a2, 3
	add	a1, a1, a2
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fabs.d	ft0, ft0
	fadd.d	fa0, fa0, ft0
	addi	a0, a0, -1
	addi	a1, a1, 8
	bnez	a0, .LBB0_8
.LBB0_9:
	ret
                                        # -- End function
