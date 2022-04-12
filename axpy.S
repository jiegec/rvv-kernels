axpy:                                   # @axpy
	beqz	a0, .LBB0_2
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fld	ft1, 0(a2)
	fmadd.d	ft0, fa0, ft0, ft1
	fsd	ft0, 0(a2)
	addi	a0, a0, -1
	addi	a2, a2, 8
	addi	a1, a1, 8
	bnez	a0, .LBB0_1
.LBB0_2:
	ret
                                        # -- End function
axpy_compiler_vectorize:                # @axpy_compiler_vectorize
	beqz	a0, .LBB1_9
	li	a3, 4
	bgeu	a0, a3, .LBB1_3
	li	a6, 0
	j	.LBB1_7
.LBB1_3:
	slli	a3, a0, 3
	add	a4, a2, a3
	add	a3, a3, a1
	sltu	a3, a2, a3
	sltu	a4, a1, a4
	and	a3, a3, a4
	li	a6, 0
	bnez	a3, .LBB1_7
	andi	a6, a0, -4
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	addi	a4, a1, 16
	addi	a5, a2, 16
	mv	a7, a6
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
	addi	a3, a4, -16
	vle64.v	v9, (a3)
	vle64.v	v10, (a4)
	addi	a3, a5, -16
	vle64.v	v11, (a3)
	vle64.v	v12, (a5)
	vfmacc.vv	v11, v8, v9
	vfmacc.vv	v12, v8, v10
	vse64.v	v11, (a3)
	vse64.v	v12, (a5)
	addi	a4, a4, 32
	addi	a7, a7, -4
	addi	a5, a5, 32
	bnez	a7, .LBB1_5
	beq	a6, a0, .LBB1_9
.LBB1_7:
	sub	a0, a0, a6
	slli	a3, a6, 3
	add	a2, a2, a3
	add	a1, a1, a3
.LBB1_8:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fld	ft1, 0(a2)
	fmadd.d	ft0, fa0, ft0, ft1
	fsd	ft0, 0(a2)
	addi	a0, a0, -1
	addi	a2, a2, 8
	addi	a1, a1, 8
	bnez	a0, .LBB1_8
.LBB1_9:
	ret
                                        # -- End function
axpy_rvv:                               # @axpy_rvv
	beqz	a0, .LBB2_3
	li	a3, 0
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	sub	a4, a0, a3
	vsetvli	a6, a4, e64, m1, ta, mu
	slli	a5, a3, 3
	add	a4, a1, a5
	vle64.v	v8, (a4)
	add	a4, a2, a5
	vle64.v	v9, (a4)
	vsetvli	zero, a6, e64, m1, tu, mu
	vfmacc.vf	v9, fa0, v8
	add	a3, a3, a6
	vse64.v	v9, (a4)
	bltu	a3, a0, .LBB2_2
.LBB2_3:
	ret
                                        # -- End function
axpy_rvv2:                              # @axpy_rvv2
	vsetvli	a7, zero, e64, m1, ta, mu
	bgeu	a7, a0, .LBB3_4
	li	a5, 0
	li	a3, 0
	slli	a6, a7, 3
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	add	a4, a1, a5
	vsetvli	zero, a7, e64, m1, ta, mu
	vle64.v	v8, (a4)
	add	a4, a2, a5
	vle64.v	v9, (a4)
	vsetvli	zero, zero, e64, m1, tu, mu
	vfmacc.vf	v9, fa0, v8
	vse64.v	v9, (a4)
	add	a3, a3, a7
	add	a4, a7, a3
	add	a5, a5, a6
	bltu	a4, a0, .LBB3_2
	bltu	a3, a0, .LBB3_5
	j	.LBB3_12
.LBB3_4:
	li	a3, 0
	bgeu	a3, a0, .LBB3_12
.LBB3_5:
	sub	a7, a0, a3
	li	a4, 4
	bltu	a7, a4, .LBB3_10
	slli	a4, a3, 3
	add	a6, a2, a4
	slli	a5, a0, 3
	add	t0, a2, a5
	add	t1, a1, a4
	add	a5, a5, a1
	sltu	a6, a6, a5
	sltu	a5, t1, t0
	and	a5, a6, a5
	bnez	a5, .LBB3_10
	andi	a6, a7, -4
	add	a3, a3, a6
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	addi	a4, a4, 16
	add	t1, a1, a4
	add	a4, a4, a2
	mv	t0, a6
.LBB3_8:                                # =>This Inner Loop Header: Depth=1
	addi	a5, t1, -16
	vle64.v	v9, (a5)
	vle64.v	v10, (t1)
	addi	a5, a4, -16
	vle64.v	v11, (a5)
	vle64.v	v12, (a4)
	vfmacc.vv	v11, v8, v9
	vfmacc.vv	v12, v8, v10
	vse64.v	v11, (a5)
	vse64.v	v12, (a4)
	addi	t0, t0, -4
	addi	t1, t1, 32
	addi	a4, a4, 32
	bnez	t0, .LBB3_8
	beq	a7, a6, .LBB3_12
.LBB3_10:
	sub	a0, a0, a3
	slli	a3, a3, 3
	add	a2, a2, a3
	add	a1, a1, a3
.LBB3_11:                               # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a1)
	fld	ft1, 0(a2)
	fmadd.d	ft0, fa0, ft0, ft1
	fsd	ft0, 0(a2)
	addi	a0, a0, -1
	addi	a2, a2, 8
	addi	a1, a1, 8
	bnez	a0, .LBB3_11
.LBB3_12:
	ret
                                        # -- End function
