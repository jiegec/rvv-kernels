stencil_2d_5p:                          # @stencil_2d_5p
	addi	sp, sp, -128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	sd	s0, 112(sp)                     # 8-byte Folded Spill
	sd	s1, 104(sp)                     # 8-byte Folded Spill
	sd	s2, 96(sp)                      # 8-byte Folded Spill
	sd	s3, 88(sp)                      # 8-byte Folded Spill
	sd	s4, 80(sp)                      # 8-byte Folded Spill
	sd	s5, 72(sp)                      # 8-byte Folded Spill
	sd	s6, 64(sp)                      # 8-byte Folded Spill
	sd	s7, 56(sp)                      # 8-byte Folded Spill
	sd	s8, 48(sp)                      # 8-byte Folded Spill
	sd	s9, 40(sp)                      # 8-byte Folded Spill
	sd	s10, 32(sp)                     # 8-byte Folded Spill
	sd	s11, 24(sp)                     # 8-byte Folded Spill
	addi	s4, a0, 1
	li	a0, 2
	bltu	s4, a0, .LBB0_12
	addi	a0, a1, 2
	addi	s3, a1, -1
	addi	a6, a3, 8
	slli	s5, a0, 3
	slli	a0, a1, 3
	addi	a4, a0, 8
	add	a7, a3, a4
	addi	t0, a2, 8
	add	t1, a2, a4
	add	a0, a0, a2
	addi	a0, a0, 16
	sltu	a0, a6, a0
	sltu	a4, a2, a7
	and	a0, a0, a4
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	andi	t3, a1, -4
	ori	a0, t3, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	vfmv.v.f	v9, fa2
	vfmv.v.f	v10, fa3
	vfmv.v.f	v11, fa4
	addi	t5, a1, 1
	li	s8, 1
	li	t6, -2
	li	s2, 12
	j	.LBB0_4
.LBB0_2:                                #   in Loop: Header=BB0_4 Depth=1
	addi	s7, s8, 1
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=1
	mv	s8, s7
	beq	s7, s4, .LBB0_12
.LBB0_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_8 Depth 2
                                        #     Child Loop BB0_11 Depth 2
	bgeu	s3, t6, .LBB0_2
	addi	s6, s8, -1
	addi	s7, s8, 1
	li	s0, 1
	bltu	a1, s2, .LBB0_10
	mul	s10, s5, s8
	add	t4, a6, s10
	add	s1, a7, s10
	mul	a4, s5, s7
	add	s9, t0, a4
	add	s11, t1, a4
	mul	a5, s5, s6
	add	t2, t0, a5
	add	ra, t1, a5
	sltu	s11, t4, s11
	sltu	a5, s9, s1
	and	a5, s11, a5
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	or	s11, a5, a0
	sltu	a5, t4, ra
	sltu	s1, t2, s1
	and	a5, a5, s1
	or	a5, s11, a5
	bnez	a5, .LBB0_10
	li	s0, 0
	add	s1, a2, s10
	mv	a5, t3
.LBB0_8:                                #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a0, s1, s0
	vle64.v	v12, (a0)
	add	a4, t2, s0
	vle64.v	v13, (a4)
	vfmul.vf	v12, v12, fa1
	addi	a4, a0, 8
	vle64.v	v14, (a4)
	addi	a0, a0, 16
	vle64.v	v15, (a0)
	add	a0, s9, s0
	vle64.v	v16, (a0)
	vfmacc.vv	v12, v8, v13
	vfmadd.vv	v14, v9, v12
	vfmadd.vv	v15, v10, v14
	vfmadd.vv	v16, v11, v15
	add	a0, t4, s0
	vse64.v	v16, (a0)
	addi	a5, a5, -4
	addi	s0, s0, 32
	bnez	a5, .LBB0_8
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	beq	t3, a1, .LBB0_3
.LBB0_10:                               #   in Loop: Header=BB0_4 Depth=1
	sub	a0, t5, s0
	mul	a4, s5, s7
	slli	s1, s0, 3
	add	a4, a4, s1
	add	a4, a4, a2
	mul	a5, s5, s8
	add	t2, a5, s1
	add	a5, a3, t2
	mul	s0, s5, s6
	add	s1, s1, s0
	add	s1, s1, a2
	add	s0, a2, t2
.LBB0_11:                               #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	fld	ft0, -8(s0)
	fld	ft1, 0(s1)
	fmul.d	ft0, ft0, fa1
	fld	ft2, 0(s0)
	fld	ft3, 8(s0)
	fmadd.d	ft0, fa0, ft1, ft0
	fld	ft1, 0(a4)
	fmadd.d	ft0, fa2, ft2, ft0
	fmadd.d	ft0, fa3, ft3, ft0
	addi	s0, s0, 8
	fmadd.d	ft0, fa4, ft1, ft0
	fsd	ft0, 0(a5)
	addi	a0, a0, -1
	addi	a4, a4, 8
	addi	a5, a5, 8
	addi	s1, s1, 8
	bnez	a0, .LBB0_11
	j	.LBB0_3
.LBB0_12:
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	ld	s0, 112(sp)                     # 8-byte Folded Reload
	ld	s1, 104(sp)                     # 8-byte Folded Reload
	ld	s2, 96(sp)                      # 8-byte Folded Reload
	ld	s3, 88(sp)                      # 8-byte Folded Reload
	ld	s4, 80(sp)                      # 8-byte Folded Reload
	ld	s5, 72(sp)                      # 8-byte Folded Reload
	ld	s6, 64(sp)                      # 8-byte Folded Reload
	ld	s7, 56(sp)                      # 8-byte Folded Reload
	ld	s8, 48(sp)                      # 8-byte Folded Reload
	ld	s9, 40(sp)                      # 8-byte Folded Reload
	ld	s10, 32(sp)                     # 8-byte Folded Reload
	ld	s11, 24(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 128
	ret
                                        # -- End function
stencil_2d_9p:                          # @stencil_2d_9p
	addi	sp, sp, -112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	sd	s0, 96(sp)                      # 8-byte Folded Spill
	sd	s1, 88(sp)                      # 8-byte Folded Spill
	sd	s2, 80(sp)                      # 8-byte Folded Spill
	sd	s3, 72(sp)                      # 8-byte Folded Spill
	sd	s4, 64(sp)                      # 8-byte Folded Spill
	sd	s5, 56(sp)                      # 8-byte Folded Spill
	sd	s6, 48(sp)                      # 8-byte Folded Spill
	sd	s7, 40(sp)                      # 8-byte Folded Spill
	sd	s8, 32(sp)                      # 8-byte Folded Spill
	sd	s9, 24(sp)                      # 8-byte Folded Spill
	sd	s10, 16(sp)                     # 8-byte Folded Spill
	sd	s11, 8(sp)                      # 8-byte Folded Spill
	addi	s3, a0, 1
	li	a0, 2
	bltu	s3, a0, .LBB1_12
	fmv.d.x	ft0, a2
	addi	a0, a1, 2
	addi	s2, a1, -1
	addi	a6, a4, 8
	slli	s4, a0, 3
	slli	a0, a1, 3
	add	a7, a6, a0
	add	a0, a0, a3
	addi	t0, a0, 16
	sltu	a0, a6, t0
	sltu	a2, a3, a7
	and	t1, a0, a2
	andi	t2, a1, -4
	ori	a0, t2, 1
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	vfmv.v.f	v9, fa2
	vfmv.v.f	v10, fa3
	vfmv.v.f	v11, fa4
	vfmv.v.f	v12, fa5
	vfmv.v.f	v13, fa6
	vfmv.v.f	v14, fa7
	vfmv.v.f	v15, ft0
	addi	t4, a1, 1
	li	s7, 1
	li	t5, -2
	li	t6, 8
	j	.LBB1_4
.LBB1_2:                                #   in Loop: Header=BB1_4 Depth=1
	addi	s6, s7, 1
.LBB1_3:                                #   in Loop: Header=BB1_4 Depth=1
	mv	s7, s6
	beq	s6, s3, .LBB1_12
.LBB1_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_8 Depth 2
                                        #     Child Loop BB1_11 Depth 2
	bgeu	s2, t5, .LBB1_2
	addi	s5, s7, -1
	addi	s6, s7, 1
	li	a5, 1
	bltu	a1, t6, .LBB1_10
	mul	s9, s4, s7
	add	ra, a6, s9
	add	s0, a7, s9
	mul	a2, s4, s6
	add	s8, a3, a2
	add	s10, t0, a2
	mul	s1, s4, s5
	add	t3, a3, s1
	add	s11, t0, s1
	sltu	s10, ra, s10
	sltu	s1, s8, s0
	and	s1, s10, s1
	or	s10, s1, t1
	sltu	s1, ra, s11
	sltu	s0, t3, s0
	and	s0, s0, s1
	or	s0, s10, s0
	bnez	s0, .LBB1_10
	add	s1, a3, s9
	mv	a5, t2
.LBB1_8:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a0, t3, s0
	addi	a2, a0, 8
	vle64.v	v16, (a2)
	vle64.v	v17, (a0)
	vfmul.vf	v16, v16, fa1
	addi	a0, a0, 16
	vle64.v	v18, (a0)
	add	a0, s1, s0
	vle64.v	v19, (a0)
	addi	a2, a0, 8
	vle64.v	v20, (a2)
	vfmacc.vv	v16, v8, v17
	vfmadd.vv	v18, v9, v16
	vfmadd.vv	v19, v10, v18
	vfmadd.vv	v20, v11, v19
	addi	a0, a0, 16
	vle64.v	v16, (a0)
	add	a0, s8, s0
	vle64.v	v17, (a0)
	addi	a2, a0, 8
	vle64.v	v18, (a2)
	addi	a0, a0, 16
	vle64.v	v19, (a0)
	vfmadd.vv	v16, v12, v20
	vfmadd.vv	v17, v13, v16
	vfmadd.vv	v18, v14, v17
	vfmadd.vv	v19, v15, v18
	add	a0, ra, s0
	vse64.v	v19, (a0)
	addi	a5, a5, -4
	addi	s0, s0, 32
	bnez	a5, .LBB1_8
	ld	a5, 0(sp)                       # 8-byte Folded Reload
	beq	t2, a1, .LBB1_3
.LBB1_10:                               #   in Loop: Header=BB1_4 Depth=1
	sub	a0, t4, a5
	mul	a2, s4, s5
	slli	t3, a5, 3
	add	a2, a2, t3
	add	a5, a3, a2
	mul	a2, s4, s7
	add	s0, a2, t3
	add	a2, a4, s0
	add	s0, s0, a3
	mul	s1, s4, s6
	add	s1, s1, t3
	add	s1, s1, a3
.LBB1_11:                               #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	fld	ft1, 0(a5)
	fld	ft2, -8(a5)
	fld	ft3, 8(a5)
	fld	ft4, -8(s0)
	fmul.d	ft1, ft1, fa1
	fmadd.d	ft1, fa0, ft2, ft1
	fmadd.d	ft1, fa2, ft3, ft1
	fmadd.d	ft1, fa3, ft4, ft1
	fld	ft2, 0(s0)
	fld	ft3, 8(s0)
	fld	ft4, -8(s1)
	fld	ft5, 0(s1)
	fmadd.d	ft1, fa4, ft2, ft1
	fmadd.d	ft1, fa5, ft3, ft1
	fmadd.d	ft1, fa6, ft4, ft1
	fmadd.d	ft1, fa7, ft5, ft1
	fld	ft2, 8(s1)
	addi	a5, a5, 8
	addi	s0, s0, 8
	addi	s1, s1, 8
	fmadd.d	ft1, ft0, ft2, ft1
	fsd	ft1, 0(a2)
	addi	a0, a0, -1
	addi	a2, a2, 8
	bnez	a0, .LBB1_11
	j	.LBB1_3
.LBB1_12:
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	ld	s0, 96(sp)                      # 8-byte Folded Reload
	ld	s1, 88(sp)                      # 8-byte Folded Reload
	ld	s2, 80(sp)                      # 8-byte Folded Reload
	ld	s3, 72(sp)                      # 8-byte Folded Reload
	ld	s4, 64(sp)                      # 8-byte Folded Reload
	ld	s5, 56(sp)                      # 8-byte Folded Reload
	ld	s6, 48(sp)                      # 8-byte Folded Reload
	ld	s7, 40(sp)                      # 8-byte Folded Reload
	ld	s8, 32(sp)                      # 8-byte Folded Reload
	ld	s9, 24(sp)                      # 8-byte Folded Reload
	ld	s10, 16(sp)                     # 8-byte Folded Reload
	ld	s11, 8(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 112
	ret
                                        # -- End function
