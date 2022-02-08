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
test_axpy_inner:                        # @test_axpy_inner
	vsetvli	a0, zero, e64, m1, ta, mu
	vle64.v	v8, (a1)
	vle64.v	v9, (a2)
	vsetvli	zero, a0, e64, m1, tu, mu
	vfmacc.vf	v9, fa0, v8
	vse64.v	v9, (a2)
	ret
                                        # -- End function
test_l1dist:                            # @test_l1dist
	beqz	a0, .LBB2_9
	li	a4, 4
	bgeu	a0, a4, .LBB2_3
	li	a6, 0
	j	.LBB2_7
.LBB2_3:
	slli	a4, a0, 3
	add	a5, a1, a4
	add	a6, a2, a4
	add	a7, a3, a4
	sltu	a6, a1, a6
	sltu	a4, a2, a5
	and	a6, a6, a4
	sltu	a4, a1, a7
	sltu	a5, a3, a5
	and	a4, a4, a5
	or	a4, a6, a4
	li	a6, 0
	bnez	a4, .LBB2_7
	andi	a6, a0, -4
	addi	a7, a2, 16
	addi	t2, a3, 16
	addi	a5, a1, 16
	mv	t0, a6
.LBB2_5:                                # =>This Inner Loop Header: Depth=1
	addi	t1, a7, -16
	vsetivli	zero, 2, e64, m1, ta, mu
	vle64.v	v8, (t1)
	vle64.v	v9, (a7)
	addi	a4, t2, -16
	vle64.v	v10, (a4)
	vle64.v	v11, (t2)
	vfsgnjx.vv	v8, v8, v8
	vfsgnjx.vv	v9, v9, v9
	vfsgnjx.vv	v10, v10, v10
	vfsgnjx.vv	v11, v11, v11
	vfadd.vv	v8, v8, v10
	vfadd.vv	v9, v9, v11
	addi	a4, a5, -16
	vse64.v	v8, (a4)
	vse64.v	v9, (a5)
	addi	a7, a7, 32
	addi	t2, t2, 32
	addi	t0, t0, -4
	addi	a5, a5, 32
	bnez	t0, .LBB2_5
	beq	a6, a0, .LBB2_9
.LBB2_7:
	slli	a4, a6, 3
	add	a1, a1, a4
	add	a3, a3, a4
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB2_8:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a2)
	fld	ft1, 0(a3)
	fabs.d	ft0, ft0
	fabs.d	ft1, ft1
	fadd.d	ft0, ft0, ft1
	fsd	ft0, 0(a1)
	addi	a1, a1, 8
	addi	a3, a3, 8
	addi	a0, a0, -1
	addi	a2, a2, 8
	bnez	a0, .LBB2_8
.LBB2_9:
	ret
                                        # -- End function
test_l2dist:                            # @test_l2dist
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	sd	s1, 24(sp)                      # 8-byte Folded Spill
	sd	s2, 16(sp)                      # 8-byte Folded Spill
	sd	s3, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB3_5
	mv	s2, a3
	mv	s3, a2
	mv	s0, a1
	mv	s1, a0
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(s2)
	fld	ft1, 0(s3)
	fmul.d	ft0, ft0, ft0
	fmadd.d	ft0, ft1, ft1, ft0
	fsqrt.d	fa0, ft0
	feq.d	a0, fa0, fa0
	beqz	a0, .LBB3_4
.LBB3_3:                                #   in Loop: Header=BB3_2 Depth=1
	fsd	fa0, 0(s0)
	addi	s0, s0, 8
	addi	s2, s2, 8
	addi	s1, s1, -1
	addi	s3, s3, 8
	bnez	s1, .LBB3_2
	j	.LBB3_5
.LBB3_4:                                #   in Loop: Header=BB3_2 Depth=1
	fmv.d	fa0, ft0
	call	sqrt
	j	.LBB3_3
.LBB3_5:
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	ld	s1, 24(sp)                      # 8-byte Folded Reload
	ld	s2, 16(sp)                      # 8-byte Folded Reload
	ld	s3, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
                                        # -- End function
test_sqrt:                              # @test_sqrt
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	sd	s1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB4_5
	mv	s0, a1
	mv	s1, a0
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(s0)
	fsqrt.d	fa0, ft0
	feq.d	a0, fa0, fa0
	beqz	a0, .LBB4_4
.LBB4_3:                                #   in Loop: Header=BB4_2 Depth=1
	fsd	fa0, 0(s0)
	addi	s1, s1, -1
	addi	s0, s0, 8
	bnez	s1, .LBB4_2
	j	.LBB4_5
.LBB4_4:                                #   in Loop: Header=BB4_2 Depth=1
	fmv.d	fa0, ft0
	call	sqrt
	j	.LBB4_3
.LBB4_5:
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
test_exp:                               # @test_exp
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	sd	s1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB5_3
	mv	s0, a1
	mv	s1, a0
.LBB5_2:                                # =>This Inner Loop Header: Depth=1
	fld	fa0, 0(s0)
	call	exp
	fsd	fa0, 0(s0)
	addi	s1, s1, -1
	addi	s0, s0, 8
	bnez	s1, .LBB5_2
.LBB5_3:
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
.LCPI6_0:
.LCPI6_1:
test_round:                             # @test_round
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	sd	s1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB6_8
	li	a2, 4
	bgeu	a0, a2, .LBB6_3
	li	a2, 0
	j	.LBB6_6
.LBB6_3:
	lui	a2, %hi(.LCPI6_0)
	fld	ft0, %lo(.LCPI6_0)(a2)
	lui	a2, %hi(.LCPI6_1)
	fld	ft1, %lo(.LCPI6_1)(a2)
	andi	a2, a0, -4
	addi	a3, a1, 16
	mv	a4, a2
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
	addi	a5, a3, -16
	vsetivli	zero, 2, e64, m1, ta, mu
	vle64.v	v8, (a5)
	vle64.v	v9, (a3)
	vfsgnjx.vv	v10, v8, v8
	vmflt.vf	v0, v10, ft0
	vfadd.vf	v10, v10, ft1
	vfcvt.rtz.x.f.v	v10, v10
	vfcvt.f.x.v	v10, v10
	vfsgnj.vv	v10, v10, v8
	vmerge.vvm	v8, v8, v10, v0
	vfsgnjx.vv	v10, v9, v9
	vmflt.vf	v0, v10, ft0
	vfadd.vf	v10, v10, ft1
	vfcvt.rtz.x.f.v	v10, v10
	vfcvt.f.x.v	v10, v10
	vfsgnj.vv	v10, v10, v9
	vmerge.vvm	v9, v9, v10, v0
	vse64.v	v8, (a5)
	vse64.v	v9, (a3)
	addi	a4, a4, -4
	addi	a3, a3, 32
	bnez	a4, .LBB6_4
	beq	a2, a0, .LBB6_8
.LBB6_6:
	slli	a3, a2, 3
	add	s0, a1, a3
	sub	s1, a0, a2
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
	fld	fa0, 0(s0)
	call	round@plt
	fsd	fa0, 0(s0)
	addi	s1, s1, -1
	addi	s0, s0, 8
	bnez	s1, .LBB6_7
.LBB6_8:
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
.LCPI7_0:
.LCPI7_1:
test_fpclassify:                        # @test_fpclassify
	beqz	a0, .LBB7_7
	lui	a3, %hi(.LCPI7_0)
	fld	ft0, %lo(.LCPI7_0)(a3)
	lui	a3, %hi(.LCPI7_1)
	fld	ft1, %lo(.LCPI7_1)(a3)
	fmv.d.x	ft2, zero
	j	.LBB7_3
.LBB7_2:                                #   in Loop: Header=BB7_3 Depth=1
	sw	a3, 0(a1)
	addi	a1, a1, 4
	addi	a0, a0, -1
	addi	a2, a2, 8
	beqz	a0, .LBB7_7
.LBB7_3:                                # =>This Inner Loop Header: Depth=1
	fld	ft3, 0(a2)
	feq.d	a4, ft3, ft2
	li	a3, 2
	bnez	a4, .LBB7_2
	feq.d	a3, ft3, ft3
	beqz	a3, .LBB7_2
	fabs.d	ft3, ft3
	feq.d	a4, ft3, ft0
	li	a3, 1
	bnez	a4, .LBB7_2
	flt.d	a3, ft3, ft1
	xori	a3, a3, 1
	addi	a3, a3, 3
	j	.LBB7_2
.LBB7_7:
	ret
                                        # -- End function
