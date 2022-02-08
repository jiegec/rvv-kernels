.LCPI0_0:
test_cond:                              # @test_cond
	beqz	a0, .LBB0_6
	li	a2, 4
	bgeu	a0, a2, .LBB0_3
	li	a2, 0
	j	.LBB0_7
.LBB0_3:
	andi	a2, a0, -4
	lui	a3, %hi(.LCPI0_0)
	fld	ft0, %lo(.LCPI0_0)(a3)
	addi	a3, a1, 16
	vsetivli	zero, 2, e64, m1, ta, mu
	vmv.v.i	v9, 0
	mv	a4, a2
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	addi	a5, a3, -16
	vle64.v	v8, (a5)
	vle64.v	v10, (a3)
	vmfgt.vf	v0, v8, ft0
	vmfgt.vf	v8, v10, ft0
	vse64.v	v9, (a5), v0.t
	vmv1r.v	v0, v8
	vse64.v	v9, (a3), v0.t
	addi	a4, a4, -4
	addi	a3, a3, 32
	bnez	a4, .LBB0_4
	bne	a2, a0, .LBB0_7
.LBB0_6:
	ret
.LBB0_7:
	lui	a3, %hi(.LCPI0_0)
	fld	ft0, %lo(.LCPI0_0)(a3)
	slli	a3, a2, 3
	add	a1, a1, a3
	sub	a0, a0, a2
	j	.LBB0_9
.LBB0_8:                                #   in Loop: Header=BB0_9 Depth=1
	addi	a0, a0, -1
	addi	a1, a1, 8
	beqz	a0, .LBB0_6
.LBB0_9:                                # =>This Inner Loop Header: Depth=1
	fld	ft1, 0(a1)
	flt.d	a2, ft0, ft1
	beqz	a2, .LBB0_8
	sd	zero, 0(a1)
	j	.LBB0_8
                                        # -- End function
test_axpy:                              # @test_axpy
	vsetvli	a0, zero, e64, m1, ta, mu
	vle64.v	v8, (a1)
	vle64.v	v9, (a2)
	vsetvli	zero, a0, e64, m1, tu, mu
	vfmacc.vf	v9, fa0, v8
	vse64.v	v9, (a2)
	ret
                                        # -- End function
