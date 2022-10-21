dot:                                    # @dot
	beqz	a0, .LBB0_3
	li	a3, 8
	bgeu	a0, a3, .LBB0_4
	li	a6, 0
	fmv.d.x	fa0, zero
	j	.LBB0_7
.LBB0_3:
	fmv.d.x	fa0, zero
	ret
.LBB0_4:
	andi	a6, a0, -8
	fmv.d.x	ft0, zero
	fneg.d	ft0, ft0
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, ft0
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv.v.v	v9, v8
	vmv.s.x	v9, zero
	mv	a4, a6
	mv	a5, a2
	mv	a3, a1
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	addi	a7, a5, 32
	addi	t0, a3, 32
	vsetvli	zero, zero, e64, m1, ta, mu
	vle64.v	v10, (a3)
	vle64.v	v11, (t0)
	vle64.v	v12, (a5)
	vle64.v	v13, (a7)
	vfmacc.vv	v9, v10, v12
	vfmacc.vv	v8, v11, v13
	addi	a3, a3, 64
	addi	a4, a4, -8
	addi	a5, a5, 64
	bnez	a4, .LBB0_5
	vfadd.vv	v8, v8, v9
	vfmv.s.f	v9, ft0
	vfredosum.vs	v8, v8, v9
	vfmv.f.s	fa0, v8
	beq	a6, a0, .LBB0_9
.LBB0_7:
	sub	a0, a0, a6
	slli	a3, a6, 3
	add	a2, a2, a3
	add	a1, a1, a3
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fld	ft1, 0(a2)
	fmadd.d	fa0, ft0, ft1, fa0
	addi	a0, a0, -1
	addi	a2, a2, 8
	addi	a1, a1, 8
	bnez	a0, .LBB0_8
.LBB0_9:
	ret
                                        # -- End function
