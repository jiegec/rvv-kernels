widen_float2double:                     # @widen_float2double
	beqz	a0, .LBB0_8
	li	a3, 4
	bgeu	a0, a3, .LBB0_3
	li	a6, 0
	j	.LBB0_6
.LBB0_3:
	andi	a6, a0, -4
	addi	a4, a2, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	addi	a7, a4, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (a7)
	vle32.v	v9, (a4)
	vfwcvt.f.f.v	v10, v8
	vfwcvt.f.f.v	v8, v9
	addi	a3, a5, -16
	vse64.v	v10, (a3)
	vse64.v	v8, (a5)
	addi	a4, a4, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB0_4
	beq	a6, a0, .LBB0_8
.LBB0_6:
	slli	a3, a6, 3
	add	a1, a1, a3
	slli	a3, a6, 2
	add	a2, a2, a3
	sub	a0, a0, a6
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
	flw	ft0, 0(a2)
	fcvt.d.s	ft0, ft0
	fsd	ft0, 0(a1)
	addi	a1, a1, 8
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB0_7
.LBB0_8:
	ret
                                        # -- End function
widen_float2long:                       # @widen_float2long
	beqz	a0, .LBB1_8
	li	a3, 4
	bgeu	a0, a3, .LBB1_3
	li	a6, 0
	j	.LBB1_6
.LBB1_3:
	andi	a6, a0, -4
	addi	a4, a2, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
	addi	a7, a4, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (a7)
	vle32.v	v9, (a4)
	vfwcvt.rtz.x.f.v	v10, v8
	vfwcvt.rtz.x.f.v	v8, v9
	addi	a3, a5, -16
	vse64.v	v10, (a3)
	vse64.v	v8, (a5)
	addi	a4, a4, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB1_4
	beq	a6, a0, .LBB1_8
.LBB1_6:
	slli	a3, a6, 3
	add	a1, a1, a3
	slli	a3, a6, 2
	add	a2, a2, a3
	sub	a0, a0, a6
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
	flw	ft0, 0(a2)
	fcvt.l.s	a3, ft0, rtz
	sd	a3, 0(a1)
	addi	a1, a1, 8
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB1_7
.LBB1_8:
	ret
                                        # -- End function
narrow_double2float:                    # @narrow_double2float
	beqz	a0, .LBB2_8
	li	a3, 4
	bgeu	a0, a3, .LBB2_3
	li	a6, 0
	j	.LBB2_6
.LBB2_3:
	andi	a6, a0, -4
	addi	a4, a2, 16
	addi	a5, a1, 8
	mv	t0, a6
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
	addi	a7, a4, -16
	vsetivli	zero, 2, e64, m1, ta, mu
	vle64.v	v8, (a7)
	vle64.v	v9, (a4)
	vsetvli	zero, zero, e32, mf2, ta, mu
	vfncvt.f.f.w	v10, v8
	vfncvt.f.f.w	v8, v9
	addi	a3, a5, -8
	vse32.v	v10, (a3)
	vse32.v	v8, (a5)
	addi	a4, a4, 32
	addi	t0, t0, -4
	addi	a5, a5, 16
	bnez	t0, .LBB2_4
	beq	a6, a0, .LBB2_8
.LBB2_6:
	slli	a3, a6, 2
	add	a1, a1, a3
	slli	a3, a6, 3
	add	a2, a2, a3
	sub	a0, a0, a6
.LBB2_7:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a2)
	fcvt.s.d	ft0, ft0
	fsw	ft0, 0(a1)
	addi	a1, a1, 4
	addi	a0, a0, -1
	addi	a2, a2, 8
	bnez	a0, .LBB2_7
.LBB2_8:
	ret
                                        # -- End function
fadd_float2double:                      # @fadd_float2double
	beqz	a0, .LBB3_8
	li	a4, 4
	bgeu	a0, a4, .LBB3_3
	li	a6, 0
	j	.LBB3_6
.LBB3_3:
	andi	a6, a0, -4
	addi	a7, a2, 8
	addi	t2, a3, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
	addi	t1, a7, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (t1)
	vle32.v	v9, (a7)
	addi	a4, t2, -8
	vle32.v	v10, (a4)
	vle32.v	v11, (t2)
	vfadd.vv	v8, v8, v10
	vfadd.vv	v9, v9, v11
	vfwcvt.f.f.v	v10, v8
	vfwcvt.f.f.v	v8, v9
	addi	a4, a5, -16
	vse64.v	v10, (a4)
	vse64.v	v8, (a5)
	addi	a7, a7, 16
	addi	t2, t2, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB3_4
	beq	a6, a0, .LBB3_8
.LBB3_6:
	slli	a4, a6, 3
	add	a1, a1, a4
	slli	a4, a6, 2
	add	a3, a3, a4
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB3_7:                                # =>This Inner Loop Header: Depth=1
	flw	ft0, 0(a2)
	flw	ft1, 0(a3)
	fadd.s	ft0, ft0, ft1
	fcvt.d.s	ft0, ft0
	fsd	ft0, 0(a1)
	addi	a1, a1, 8
	addi	a3, a3, 4
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB3_7
.LBB3_8:
	ret
                                        # -- End function
fma_float2double:                       # @fma_float2double
	beqz	a0, .LBB4_8
	li	a5, 4
	bgeu	a0, a5, .LBB4_3
	li	a6, 0
	j	.LBB4_6
.LBB4_3:
	andi	a6, a0, -4
	addi	a7, a2, 8
	addi	t0, a3, 8
	addi	t1, a4, 8
	addi	t4, a1, 16
	mv	t2, a6
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
	addi	t3, a7, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (t3)
	vle32.v	v9, (a7)
	addi	a5, t0, -8
	vle32.v	v10, (a5)
	vle32.v	v11, (t0)
	addi	a5, t1, -8
	vle32.v	v12, (a5)
	vle32.v	v13, (t1)
	vfmacc.vv	v12, v8, v10
	vfmacc.vv	v13, v9, v11
	vfwcvt.f.f.v	v8, v12
	vfwcvt.f.f.v	v9, v13
	addi	a5, t4, -16
	vse64.v	v8, (a5)
	vse64.v	v9, (t4)
	addi	a7, a7, 16
	addi	t0, t0, 16
	addi	t1, t1, 16
	addi	t2, t2, -4
	addi	t4, t4, 32
	bnez	t2, .LBB4_4
	beq	a6, a0, .LBB4_8
.LBB4_6:
	slli	a5, a6, 3
	add	a1, a1, a5
	slli	a5, a6, 2
	add	a4, a4, a5
	add	a3, a3, a5
	add	a2, a2, a5
	sub	a0, a0, a6
.LBB4_7:                                # =>This Inner Loop Header: Depth=1
	flw	ft0, 0(a2)
	flw	ft1, 0(a3)
	flw	ft2, 0(a4)
	fmadd.s	ft0, ft0, ft1, ft2
	fcvt.d.s	ft0, ft0
	fsd	ft0, 0(a1)
	addi	a1, a1, 8
	addi	a4, a4, 4
	addi	a3, a3, 4
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB4_7
.LBB4_8:
	ret
                                        # -- End function
fadd_mixed2double:                      # @fadd_mixed2double
	beqz	a0, .LBB5_8
	li	a4, 4
	bgeu	a0, a4, .LBB5_3
	li	a6, 0
	j	.LBB5_6
.LBB5_3:
	andi	a6, a0, -4
	addi	a7, a2, 16
	addi	t2, a3, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB5_4:                                # =>This Inner Loop Header: Depth=1
	addi	t1, a7, -16
	vsetivli	zero, 2, e64, m1, ta, mu
	vle64.v	v8, (t1)
	addi	a4, t2, -8
	vle32.v	v9, (a4)
	vle32.v	v10, (t2)
	vle64.v	v11, (a7)
	vsetvli	zero, zero, e32, mf2, ta, mu
	vfwcvt.f.f.v	v12, v9
	vfwcvt.f.f.v	v9, v10
	vsetvli	zero, zero, e64, m1, ta, mu
	vfadd.vv	v8, v8, v12
	vfadd.vv	v9, v11, v9
	addi	a4, a5, -16
	vse64.v	v8, (a4)
	vse64.v	v9, (a5)
	addi	a7, a7, 32
	addi	t2, t2, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB5_4
	beq	a6, a0, .LBB5_8
.LBB5_6:
	slli	a4, a6, 3
	add	a1, a1, a4
	slli	a5, a6, 2
	add	a3, a3, a5
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB5_7:                                # =>This Inner Loop Header: Depth=1
	flw	ft0, 0(a3)
	fld	ft1, 0(a2)
	fcvt.d.s	ft0, ft0
	fadd.d	ft0, ft1, ft0
	fsd	ft0, 0(a1)
	addi	a1, a1, 8
	addi	a3, a3, 4
	addi	a0, a0, -1
	addi	a2, a2, 8
	bnez	a0, .LBB5_7
.LBB5_8:
	ret
                                        # -- End function
add_int2long:                           # @add_int2long
	beqz	a0, .LBB6_8
	li	a4, 4
	bgeu	a0, a4, .LBB6_3
	li	a6, 0
	j	.LBB6_6
.LBB6_3:
	andi	a6, a0, -4
	addi	a7, a2, 8
	addi	t2, a3, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
	addi	t1, a7, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (t1)
	vle32.v	v9, (a7)
	addi	a4, t2, -8
	vle32.v	v10, (a4)
	vle32.v	v11, (t2)
	vadd.vv	v8, v10, v8
	vadd.vv	v9, v11, v9
	vsetvli	zero, zero, e64, m1, ta, mu
	vsext.vf2	v10, v8
	vsext.vf2	v8, v9
	addi	a4, a5, -16
	vse64.v	v10, (a4)
	vse64.v	v8, (a5)
	addi	a7, a7, 16
	addi	t2, t2, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB6_4
	beq	a6, a0, .LBB6_8
.LBB6_6:
	slli	a4, a6, 3
	add	a1, a1, a4
	slli	a4, a6, 2
	add	a3, a3, a4
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
	lw	a4, 0(a2)
	lw	a5, 0(a3)
	addw	a4, a4, a5
	sd	a4, 0(a1)
	addi	a1, a1, 8
	addi	a3, a3, 4
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB6_7
.LBB6_8:
	ret
                                        # -- End function
mul_int2long:                           # @mul_int2long
	beqz	a0, .LBB7_8
	li	a4, 4
	bgeu	a0, a4, .LBB7_3
	li	a6, 0
	j	.LBB7_6
.LBB7_3:
	andi	a6, a0, -4
	addi	a7, a2, 8
	addi	t2, a3, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
	addi	t1, a7, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (t1)
	vle32.v	v9, (a7)
	addi	a4, t2, -8
	vle32.v	v10, (a4)
	vle32.v	v11, (t2)
	vmul.vv	v8, v10, v8
	vmul.vv	v9, v11, v9
	vsetvli	zero, zero, e64, m1, ta, mu
	vsext.vf2	v10, v8
	vsext.vf2	v8, v9
	addi	a4, a5, -16
	vse64.v	v10, (a4)
	vse64.v	v8, (a5)
	addi	a7, a7, 16
	addi	t2, t2, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB7_4
	beq	a6, a0, .LBB7_8
.LBB7_6:
	slli	a4, a6, 3
	add	a1, a1, a4
	slli	a4, a6, 2
	add	a3, a3, a4
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB7_7:                                # =>This Inner Loop Header: Depth=1
	lw	a4, 0(a2)
	lw	a5, 0(a3)
	mulw	a4, a5, a4
	sd	a4, 0(a1)
	addi	a1, a1, 8
	addi	a3, a3, 4
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB7_7
.LBB7_8:
	ret
                                        # -- End function
mul_uint2ulong:                         # @mul_uint2ulong
	beqz	a0, .LBB8_8
	li	a4, 4
	bgeu	a0, a4, .LBB8_3
	li	a6, 0
	j	.LBB8_6
.LBB8_3:
	andi	a6, a0, -4
	addi	a7, a2, 8
	addi	t2, a3, 8
	addi	a5, a1, 16
	mv	t0, a6
.LBB8_4:                                # =>This Inner Loop Header: Depth=1
	addi	t1, a7, -8
	vsetivli	zero, 2, e32, mf2, ta, mu
	vle32.v	v8, (t1)
	vle32.v	v9, (a7)
	addi	a4, t2, -8
	vle32.v	v10, (a4)
	vle32.v	v11, (t2)
	vmul.vv	v8, v10, v8
	vmul.vv	v9, v11, v9
	vsetvli	zero, zero, e64, m1, ta, mu
	vzext.vf2	v10, v8
	vzext.vf2	v8, v9
	addi	a4, a5, -16
	vse64.v	v10, (a4)
	vse64.v	v8, (a5)
	addi	a7, a7, 16
	addi	t2, t2, 16
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB8_4
	beq	a6, a0, .LBB8_8
.LBB8_6:
	slli	a4, a6, 3
	add	a1, a1, a4
	slli	a4, a6, 2
	add	a3, a3, a4
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB8_7:                                # =>This Inner Loop Header: Depth=1
	lw	a4, 0(a2)
	lw	a5, 0(a3)
	mulw	a4, a5, a4
	slli	a4, a4, 32
	srli	a4, a4, 32
	sd	a4, 0(a1)
	addi	a1, a1, 8
	addi	a3, a3, 4
	addi	a0, a0, -1
	addi	a2, a2, 4
	bnez	a0, .LBB8_7
.LBB8_8:
	ret
                                        # -- End function
sum_float2double:                       # @sum_float2double
	beqz	a0, .LBB9_3
	li	a2, 4
	bgeu	a0, a2, .LBB9_4
	li	a2, 0
	fmv.d.x	fa0, zero
	j	.LBB9_7
.LBB9_3:
	fmv.d.x	fa0, zero
	ret
.LBB9_4:
	andi	a2, a0, -4
	addi	a3, a1, 8
	fmv.d.x	ft0, zero
	fneg.d	ft0, ft0
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, ft0
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv.v.v	v9, v8
	vmv.s.x	v9, zero
	mv	a4, a2
.LBB9_5:                                # =>This Inner Loop Header: Depth=1
	addi	a5, a3, -8
	vsetvli	zero, zero, e32, mf2, ta, mu
	vle32.v	v10, (a5)
	vle32.v	v11, (a3)
	vfwcvt.f.f.v	v12, v10
	vfwcvt.f.f.v	v10, v11
	vsetvli	zero, zero, e64, m1, ta, mu
	vfadd.vv	v9, v9, v12
	vfadd.vv	v8, v8, v10
	addi	a4, a4, -4
	addi	a3, a3, 16
	bnez	a4, .LBB9_5
	vfadd.vv	v8, v8, v9
	vfmv.s.f	v9, ft0
	vfredosum.vs	v8, v8, v9
	vfmv.f.s	fa0, v8
	beq	a2, a0, .LBB9_9
.LBB9_7:
	slli	a3, a2, 2
	add	a1, a1, a3
	sub	a0, a0, a2
.LBB9_8:                                # =>This Inner Loop Header: Depth=1
	flw	ft0, 0(a1)
	fcvt.d.s	ft0, ft0
	fadd.d	fa0, fa0, ft0
	addi	a0, a0, -1
	addi	a1, a1, 4
	bnez	a0, .LBB9_8
.LBB9_9:
	ret
                                        # -- End function
