.LCPI0_0:
.LCPI0_1:
test_clampf:                            # @test_clampf
	beqz	a0, .LBB0_6
	li	a2, 4
	bgeu	a0, a2, .LBB0_3
	li	a2, 0
	j	.LBB0_7
.LBB0_3:
	lui	a2, %hi(.LCPI0_0)
	fld	ft0, %lo(.LCPI0_0)(a2)
	lui	a2, %hi(.LCPI0_1)
	fld	ft1, %lo(.LCPI0_1)(a2)
	andi	a2, a0, -4
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v9, ft0
	mv	a3, a2
	mv	a4, a1
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	vle64.v	v8, (a4)
	vmfgt.vf	v10, v8, ft0
	vmflt.vf	v8, v8, ft1
	vmandn.mm	v0, v8, v10
	vmor.mm	v8, v8, v10
	vfmerge.vfm	v10, v9, ft1, v0
	vmv1r.v	v0, v8
	vse64.v	v10, (a4), v0.t
	addi	a3, a3, -4
	addi	a4, a4, 32
	bnez	a3, .LBB0_4
	bne	a2, a0, .LBB0_7
.LBB0_6:
	ret
.LBB0_7:
	lui	a3, %hi(.LCPI0_0)
	fld	ft0, %lo(.LCPI0_0)(a3)
	lui	a3, %hi(.LCPI0_1)
	fld	ft1, %lo(.LCPI0_1)(a3)
	slli	a3, a2, 3
	add	a1, a1, a3
	sub	a0, a0, a2
	j	.LBB0_10
.LBB0_8:                                #   in Loop: Header=BB0_10 Depth=1
	fsd	ft2, 0(a1)
.LBB0_9:                                #   in Loop: Header=BB0_10 Depth=1
	addi	a0, a0, -1
	addi	a1, a1, 8
	beqz	a0, .LBB0_6
.LBB0_10:                               # =>This Inner Loop Header: Depth=1
	fld	ft3, 0(a1)
	flt.d	a2, ft0, ft3
	fmv.d	ft2, ft0
	bnez	a2, .LBB0_8
	flt.d	a2, ft3, ft1
	fmv.d	ft2, ft1
	bnez	a2, .LBB0_8
	j	.LBB0_9
                                        # -- End function
test_clamp:                             # @test_clamp
	beqz	a0, .LBB1_6
	li	a2, 8
	bgeu	a0, a2, .LBB1_3
	li	a2, 0
	j	.LBB1_7
.LBB1_3:
	andi	a2, a0, -8
	vsetivli	zero, 8, e32, m1, ta, mu
	vmv.v.i	v9, 1
	mv	a3, a2
	mv	a4, a1
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
	vle32.v	v8, (a4)
	vmsle.vi	v0, v8, -2
	vadd.vi	v8, v8, -2
	vmsleu.vi	v8, v8, -4
	vmerge.vim	v10, v9, -1, v0
	vmv1r.v	v0, v8
	vse32.v	v10, (a4), v0.t
	addi	a3, a3, -8
	addi	a4, a4, 32
	bnez	a3, .LBB1_4
	bne	a2, a0, .LBB1_7
.LBB1_6:
	ret
.LBB1_7:
	slli	a3, a2, 2
	add	a1, a1, a3
	sub	a0, a0, a2
	li	a2, -2
	j	.LBB1_10
.LBB1_8:                                #   in Loop: Header=BB1_10 Depth=1
	sw	a3, 0(a1)
.LBB1_9:                                #   in Loop: Header=BB1_10 Depth=1
	addi	a0, a0, -1
	addi	a1, a1, 4
	beqz	a0, .LBB1_6
.LBB1_10:                               # =>This Inner Loop Header: Depth=1
	lw	a4, 0(a1)
	li	a3, 1
	blt	a3, a4, .LBB1_8
	li	a3, -1
	bge	a2, a4, .LBB1_8
	j	.LBB1_9
                                        # -- End function
test_axpy_inner:                        # @test_axpy_inner
	vsetvli	a0, zero, e64, m1, ta, mu
	vle64.v	v8, (a1)
	vle64.v	v9, (a2)
	vsetvli	zero, zero, e64, m1, tu, mu
	vfmacc.vf	v9, fa0, v8
	vse64.v	v9, (a2)
	ret
                                        # -- End function
test_l1dist:                            # @test_l1dist
	beqz	a0, .LBB3_9
	li	a4, 8
	bgeu	a0, a4, .LBB3_3
	li	a6, 0
	j	.LBB3_7
.LBB3_3:
	sub	a4, a1, a2
	sltiu	a4, a4, 64
	sub	a5, a1, a3
	sltiu	a5, a5, 64
	or	a4, a4, a5
	li	a6, 0
	bnez	a4, .LBB3_7
	andi	a6, a0, -8
	vsetivli	zero, 4, e64, m1, ta, mu
	mv	a7, a6
	mv	t0, a1
	mv	a5, a3
	mv	a4, a2
.LBB3_5:                                # =>This Inner Loop Header: Depth=1
	addi	t1, t0, 32
	addi	t2, a5, 32
	addi	t3, a4, 32
	vle64.v	v8, (a4)
	vle64.v	v9, (t3)
	vle64.v	v10, (a5)
	vle64.v	v11, (t2)
	vfabs.v	v8, v8
	vfabs.v	v9, v9
	vfabs.v	v10, v10
	vfabs.v	v11, v11
	vfadd.vv	v8, v8, v10
	vfadd.vv	v9, v9, v11
	vse64.v	v8, (t0)
	vse64.v	v9, (t1)
	addi	a4, a4, 64
	addi	a5, a5, 64
	addi	a7, a7, -8
	addi	t0, t0, 64
	bnez	a7, .LBB3_5
	beq	a6, a0, .LBB3_9
.LBB3_7:
	slli	a4, a6, 3
	add	a1, a1, a4
	add	a3, a3, a4
	add	a2, a2, a4
	sub	a0, a0, a6
.LBB3_8:                                # =>This Inner Loop Header: Depth=1
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
	bnez	a0, .LBB3_8
.LBB3_9:
	ret
                                        # -- End function
test_l2dist:                            # @test_l2dist
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	sd	s1, 24(sp)                      # 8-byte Folded Spill
	sd	s2, 16(sp)                      # 8-byte Folded Spill
	sd	s3, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB4_5
	mv	s2, a3
	mv	s3, a2
	mv	s0, a1
	mv	s1, a0
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(s2)
	fld	ft1, 0(s3)
	fmul.d	ft0, ft0, ft0
	fmadd.d	ft0, ft1, ft1, ft0
	fsqrt.d	fa0, ft0
	feq.d	a0, fa0, fa0
	beqz	a0, .LBB4_4
.LBB4_3:                                #   in Loop: Header=BB4_2 Depth=1
	fsd	fa0, 0(s0)
	addi	s0, s0, 8
	addi	s2, s2, 8
	addi	s1, s1, -1
	addi	s3, s3, 8
	bnez	s1, .LBB4_2
	j	.LBB4_5
.LBB4_4:                                #   in Loop: Header=BB4_2 Depth=1
	fmv.d	fa0, ft0
	call	sqrt
	j	.LBB4_3
.LBB4_5:
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
	beqz	a0, .LBB5_5
	mv	s0, a1
	mv	s1, a0
.LBB5_2:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(s0)
	fsqrt.d	fa0, ft0
	feq.d	a0, fa0, fa0
	beqz	a0, .LBB5_4
.LBB5_3:                                #   in Loop: Header=BB5_2 Depth=1
	fsd	fa0, 0(s0)
	addi	s1, s1, -1
	addi	s0, s0, 8
	bnez	s1, .LBB5_2
	j	.LBB5_5
.LBB5_4:                                #   in Loop: Header=BB5_2 Depth=1
	fmv.d	fa0, ft0
	call	sqrt
	j	.LBB5_3
.LBB5_5:
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
	beqz	a0, .LBB6_3
	mv	s0, a1
	mv	s1, a0
.LBB6_2:                                # =>This Inner Loop Header: Depth=1
	fld	fa0, 0(s0)
	call	exp
	fsd	fa0, 0(s0)
	addi	s1, s1, -1
	addi	s0, s0, 8
	bnez	s1, .LBB6_2
.LBB6_3:
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
.LCPI7_0:
.LCPI7_1:
test_round:                             # @test_round
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	sd	s1, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB7_8
	li	a2, 8
	bgeu	a0, a2, .LBB7_3
	li	a2, 0
	j	.LBB7_6
.LBB7_3:
	lui	a2, %hi(.LCPI7_0)
	fld	ft0, %lo(.LCPI7_0)(a2)
	lui	a2, %hi(.LCPI7_1)
	fld	ft1, %lo(.LCPI7_1)(a2)
	andi	a2, a0, -8
	vsetivli	zero, 4, e64, m1, ta, mu
	mv	a3, a2
	mv	a4, a1
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
	vle64.v	v8, (a4)
	addi	a5, a4, 32
	vle64.v	v9, (a5)
	vfabs.v	v10, v8
	vmflt.vf	v0, v10, ft0
	vfadd.vf	v10, v10, ft1
	vfcvt.rtz.x.f.v	v10, v10
	vfcvt.f.x.v	v10, v10
	vfsgnj.vv	v10, v10, v8
	vmerge.vvm	v8, v8, v10, v0
	vfabs.v	v10, v9
	vmflt.vf	v0, v10, ft0
	vfadd.vf	v10, v10, ft1
	vfcvt.rtz.x.f.v	v10, v10
	vfcvt.f.x.v	v10, v10
	vfsgnj.vv	v10, v10, v9
	vmerge.vvm	v9, v9, v10, v0
	vse64.v	v8, (a4)
	vse64.v	v9, (a5)
	addi	a3, a3, -8
	addi	a4, a4, 64
	bnez	a3, .LBB7_4
	beq	a2, a0, .LBB7_8
.LBB7_6:
	slli	a3, a2, 3
	add	s0, a1, a3
	sub	s1, a0, a2
.LBB7_7:                                # =>This Inner Loop Header: Depth=1
	fld	fa0, 0(s0)
	call	round@plt
	fsd	fa0, 0(s0)
	addi	s1, s1, -1
	addi	s0, s0, 8
	bnez	s1, .LBB7_7
.LBB7_8:
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
.LCPI8_0:
.LCPI8_1:
test_fpclassify:                        # @test_fpclassify
	beqz	a0, .LBB8_6
	li	a3, 4
	bgeu	a0, a3, .LBB8_3
	li	a6, 0
	j	.LBB8_7
.LBB8_3:
	andi	a6, a0, -4
	lui	a3, %hi(.LCPI8_0)
	fld	ft0, %lo(.LCPI8_0)(a3)
	lui	a3, %hi(.LCPI8_1)
	fld	ft1, %lo(.LCPI8_1)(a3)
	vsetivli	zero, 4, e32, mf2, ta, mu
	vmv.v.i	v10, 0
	fmv.d.x	ft2, zero
	vmv.v.i	v11, 2
	mv	a4, a6
	mv	a5, a1
	mv	a3, a2
.LBB8_4:                                # =>This Inner Loop Header: Depth=1
	vle64.v	v8, (a3)
	vsetvli	zero, zero, e64, m1, ta, mu
	vfabs.v	v9, v8
	vmfne.vf	v12, v9, ft0
	vmfeq.vf	v13, v9, ft0
	vmflt.vf	v9, v9, ft1
	vmnot.m	v0, v9
	vsetvli	zero, zero, e32, mf2, ta, mu
	vmerge.vim	v9, v10, 1, v0
	vadd.vi	v14, v9, 3
	vsetvli	zero, zero, e64, m1, ta, mu
	vmfne.vv	v0, v8, v8
	vmflt.vf	v9, v8, ft2
	vmfgt.vf	v8, v8, ft2
	vmor.mm	v9, v8, v9
	vmand.mm	v8, v9, v13
	vmand.mm	v9, v9, v12
	vsetvli	zero, zero, e32, mf2, ta, mu
	vmerge.vim	v12, v11, 0, v0
	vmv1r.v	v0, v8
	vmerge.vim	v8, v12, 1, v0
	vmv1r.v	v0, v9
	vmerge.vvm	v8, v8, v14, v0
	vse32.v	v8, (a5)
	addi	a3, a3, 32
	addi	a4, a4, -4
	addi	a5, a5, 16
	bnez	a4, .LBB8_4
	bne	a6, a0, .LBB8_7
.LBB8_6:
	ret
.LBB8_7:
	slli	a3, a6, 2
	add	a1, a1, a3
	lui	a3, %hi(.LCPI8_0)
	fld	ft0, %lo(.LCPI8_0)(a3)
	lui	a3, %hi(.LCPI8_1)
	fld	ft1, %lo(.LCPI8_1)(a3)
	slli	a3, a6, 3
	add	a2, a2, a3
	sub	a0, a0, a6
	fmv.d.x	ft2, zero
	j	.LBB8_9
.LBB8_8:                                #   in Loop: Header=BB8_9 Depth=1
	sw	a3, 0(a1)
	addi	a1, a1, 4
	addi	a0, a0, -1
	addi	a2, a2, 8
	beqz	a0, .LBB8_6
.LBB8_9:                                # =>This Inner Loop Header: Depth=1
	fld	ft3, 0(a2)
	feq.d	a4, ft3, ft2
	li	a3, 2
	bnez	a4, .LBB8_8
	feq.d	a3, ft3, ft3
	beqz	a3, .LBB8_8
	fabs.d	ft3, ft3
	feq.d	a4, ft3, ft0
	li	a3, 1
	bnez	a4, .LBB8_8
	flt.d	a3, ft3, ft1
	xori	a3, a3, 1
	addi	a3, a3, 3
	j	.LBB8_8
                                        # -- End function
test_axpy_valarray:                     # @test_axpy_valarray
	ld	t0, 0(a1)
	beqz	t0, .LBB9_6
	ld	a3, 8(a1)
	ld	a6, 8(a0)
	li	a0, 8
	bltu	t0, a0, .LBB9_3
	slli	a0, t0, 3
	add	a1, a3, a0
	add	a0, a0, a6
	sltu	a0, a3, a0
	sltu	a1, a6, a1
	and	a0, a0, a1
	beqz	a0, .LBB9_7
.LBB9_3:
	li	a7, 0
	mv	a1, a3
.LBB9_4:
	sub	a0, t0, a7
	slli	a2, a7, 3
	add	a2, a2, a6
.LBB9_5:                                # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a2)
	fld	ft1, 0(a1)
	fmul.d	ft0, ft0, fa0
	fadd.d	ft0, ft1, ft0
	fsd	ft0, 0(a1)
	addi	a1, a1, 8
	addi	a0, a0, -1
	addi	a2, a2, 8
	bnez	a0, .LBB9_5
.LBB9_6:
	ret
.LBB9_7:
	andi	a7, t0, -8
	slli	a0, a7, 3
	add	a1, a3, a0
	vsetivli	zero, 4, e64, m1, ta, mu
	mv	a5, a7
	mv	a0, a6
.LBB9_8:                                # =>This Inner Loop Header: Depth=1
	addi	a4, a3, 32
	addi	a2, a0, 32
	vle64.v	v8, (a0)
	vle64.v	v9, (a2)
	vle64.v	v10, (a3)
	vle64.v	v11, (a4)
	vfmul.vf	v8, v8, fa0
	vfmul.vf	v9, v9, fa0
	vfadd.vv	v8, v10, v8
	vfadd.vv	v9, v11, v9
	vse64.v	v8, (a3)
	vse64.v	v9, (a4)
	addi	a0, a0, 64
	addi	a5, a5, -8
	addi	a3, a3, 64
	bnez	a5, .LBB9_8
	bne	t0, a7, .LBB9_4
	j	.LBB9_6
                                        # -- End function
test_axpy_valarray2:                    # @test_axpy_valarray2
	ld	a2, 0(a0)
	beqz	a2, .LBB10_9
	ld	a6, 8(a0)
	ld	a7, 8(a1)
	li	a0, 8
	bgeu	a2, a0, .LBB10_3
	li	t0, 0
	j	.LBB10_7
.LBB10_3:
	slli	a0, a2, 3
	add	a3, a7, a0
	add	a0, a0, a6
	sltu	a0, a7, a0
	sltu	a3, a6, a3
	and	a0, a0, a3
	li	t0, 0
	bnez	a0, .LBB10_7
	andi	t0, a2, -8
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	mv	a4, t0
	mv	a5, a7
	mv	a0, a6
.LBB10_5:                               # =>This Inner Loop Header: Depth=1
	addi	a1, a5, 32
	addi	a3, a0, 32
	vle64.v	v9, (a0)
	vle64.v	v10, (a3)
	vle64.v	v11, (a5)
	vle64.v	v12, (a1)
	vfmacc.vv	v11, v8, v9
	vfmacc.vv	v12, v8, v10
	vse64.v	v11, (a5)
	vse64.v	v12, (a1)
	addi	a0, a0, 64
	addi	a4, a4, -8
	addi	a5, a5, 64
	bnez	a4, .LBB10_5
	beq	a2, t0, .LBB10_9
.LBB10_7:
	sub	a0, a2, t0
	slli	a1, t0, 3
	add	a2, a6, a1
	add	a1, a1, a7
.LBB10_8:                               # =>This Inner Loop Header: Depth=1
	fld	ft0, 0(a2)
	fld	ft1, 0(a1)
	fmadd.d	ft0, fa0, ft0, ft1
	fsd	ft0, 0(a1)
	addi	a0, a0, -1
	addi	a2, a2, 8
	addi	a1, a1, 8
	bnez	a0, .LBB10_8
.LBB10_9:
	ret
                                        # -- End function
test_diff:                              # @test_diff
	ld	a3, 0(a2)
	li	a4, 2
	sd	a3, 0(a1)
	bltu	a0, a4, .LBB11_8
	addi	a7, a0, -1
	li	a3, 8
	li	t0, 1
	bltu	a7, a3, .LBB11_6
	addi	a3, a1, 8
	slli	a4, a0, 3
	add	a5, a1, a4
	add	a4, a4, a2
	sltu	a3, a3, a4
	sltu	a4, a2, a5
	and	a3, a3, a4
	bnez	a3, .LBB11_6
	andi	a6, a7, -8
	ori	t0, a6, 1
	addi	a5, a1, 40
	vsetivli	zero, 4, e64, m1, ta, mu
	mv	t1, a6
	mv	a3, a2
.LBB11_4:                               # =>This Inner Loop Header: Depth=1
	addi	a4, a3, 8
	vle64.v	v8, (a4)
	addi	a4, a3, 40
	vle64.v	v9, (a4)
	vle64.v	v10, (a3)
	addi	a4, a3, 32
	vle64.v	v11, (a4)
	vsub.vv	v8, v8, v10
	vsub.vv	v9, v9, v11
	addi	a4, a5, -32
	vse64.v	v8, (a4)
	vse64.v	v9, (a5)
	addi	a3, a3, 64
	addi	t1, t1, -8
	addi	a5, a5, 64
	bnez	t1, .LBB11_4
	beq	a7, a6, .LBB11_8
.LBB11_6:
	sub	a0, a0, t0
	slli	a3, t0, 3
	add	a1, a1, a3
	add	a2, a2, a3
.LBB11_7:                               # =>This Inner Loop Header: Depth=1
	ld	a3, 0(a2)
	ld	a4, -8(a2)
	sub	a3, a3, a4
	sd	a3, 0(a1)
	addi	a0, a0, -1
	addi	a1, a1, 8
	addi	a2, a2, 8
	bnez	a0, .LBB11_7
.LBB11_8:
	ret
                                        # -- End function
