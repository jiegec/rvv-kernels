stencil_2d_5p:                          # @stencil_2d_5p
	addi	sp, sp, -144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	sd	s0, 128(sp)                     # 8-byte Folded Spill
	sd	s1, 120(sp)                     # 8-byte Folded Spill
	sd	s2, 112(sp)                     # 8-byte Folded Spill
	sd	s3, 104(sp)                     # 8-byte Folded Spill
	sd	s4, 96(sp)                      # 8-byte Folded Spill
	sd	s5, 88(sp)                      # 8-byte Folded Spill
	sd	s6, 80(sp)                      # 8-byte Folded Spill
	sd	s7, 72(sp)                      # 8-byte Folded Spill
	sd	s8, 64(sp)                      # 8-byte Folded Spill
	sd	s9, 56(sp)                      # 8-byte Folded Spill
	sd	s10, 48(sp)                     # 8-byte Folded Spill
	sd	s11, 40(sp)                     # 8-byte Folded Spill
	addi	s5, a0, 1
	li	t4, 2
	bltu	s5, t4, .LBB0_12
	addi	s6, a1, 2
	addi	s4, a1, -1
	addi	a7, a3, 8
	addi	t0, a1, 1
	slli	a0, t0, 3
	add	t1, a3, a0
	addi	t2, a2, 8
	add	t3, a2, a0
	slli	a0, s6, 3
	add	a0, a0, a2
	sltu	a0, a7, a0
	sltu	a4, a2, t1
	and	a0, a0, a4
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	andi	a0, a1, -2
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	ori	a0, a1, 1
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	vfmv.v.f	v9, fa2
	vfmv.v.f	v10, fa3
	vfmv.v.f	v11, fa4
	addi	a0, a2, 16
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	s10, 1
	li	s3, -2
	j	.LBB0_4
.LBB0_2:                                #   in Loop: Header=BB0_4 Depth=1
	addi	s10, s10, 1
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=1
	beq	s10, s5, .LBB0_12
.LBB0_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_8 Depth 2
                                        #     Child Loop BB0_11 Depth 2
	bgeu	s4, s3, .LBB0_2
	addi	a0, s10, -1
	mul	s7, a0, s6
	mul	s8, s10, s6
	addi	s10, s10, 1
	mul	s9, s10, s6
	li	a6, 1
	bltu	a1, t4, .LBB0_10
	slli	s11, s8, 3
	add	t5, a7, s11
	add	t4, t1, s11
	slli	a4, s9, 3
	add	s0, t2, a4
	add	ra, t3, a4
	slli	t6, s7, 3
	add	a4, t2, t6
	add	t6, t6, t3
	sltu	ra, t5, ra
	sltu	s2, s0, t4
	and	a0, ra, s2
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	or	s2, a0, a5
	sltu	t6, t5, t6
	sltu	a0, a4, t4
	li	t4, 2
	and	a0, t6, a0
	or	a0, s2, a0
	bnez	a0, .LBB0_10
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a0, a0, s11
	ld	s1, 24(sp)                      # 8-byte Folded Reload
.LBB0_8:                                #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addi	a5, a0, -16
	vle64.v	v12, (a5)
	vle64.v	v13, (a4)
	vfmul.vf	v12, v12, fa1
	addi	a5, a0, -8
	vle64.v	v14, (a5)
	vle64.v	v15, (a0)
	vle64.v	v16, (s0)
	vfmacc.vv	v12, v8, v13
	vfmadd.vv	v14, v9, v12
	vfmadd.vv	v15, v10, v14
	vfmadd.vv	v16, v11, v15
	vse64.v	v16, (t5)
	addi	s1, s1, -2
	addi	a4, a4, 16
	addi	t5, t5, 16
	addi	s0, s0, 16
	addi	a0, a0, 16
	bnez	s1, .LBB0_8
	ld	a6, 16(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	beq	a0, a1, .LBB0_3
.LBB0_10:                               #   in Loop: Header=BB0_4 Depth=1
	sub	a4, t0, a6
	add	a0, a6, s9
	slli	a0, a0, 3
	add	a0, a0, a2
	add	a5, a6, s8
	slli	s1, a5, 3
	add	a5, a3, s1
	add	s0, a6, s7
	slli	s0, s0, 3
	add	s0, s0, a2
	add	s1, s1, a2
.LBB0_11:                               #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	fld	ft0, -8(s1)
	fld	ft1, 0(s0)
	fmul.d	ft0, ft0, fa1
	fld	ft2, 0(s1)
	fld	ft3, 8(s1)
	fmadd.d	ft0, fa0, ft1, ft0
	fld	ft1, 0(a0)
	fmadd.d	ft0, fa2, ft2, ft0
	fmadd.d	ft0, fa3, ft3, ft0
	addi	s1, s1, 8
	fmadd.d	ft0, fa4, ft1, ft0
	fsd	ft0, 0(a5)
	addi	a4, a4, -1
	addi	a0, a0, 8
	addi	a5, a5, 8
	addi	s0, s0, 8
	bnez	a4, .LBB0_11
	j	.LBB0_3
.LBB0_12:
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	ld	s0, 128(sp)                     # 8-byte Folded Reload
	ld	s1, 120(sp)                     # 8-byte Folded Reload
	ld	s2, 112(sp)                     # 8-byte Folded Reload
	ld	s3, 104(sp)                     # 8-byte Folded Reload
	ld	s4, 96(sp)                      # 8-byte Folded Reload
	ld	s5, 88(sp)                      # 8-byte Folded Reload
	ld	s6, 80(sp)                      # 8-byte Folded Reload
	ld	s7, 72(sp)                      # 8-byte Folded Reload
	ld	s8, 64(sp)                      # 8-byte Folded Reload
	ld	s9, 56(sp)                      # 8-byte Folded Reload
	ld	s10, 48(sp)                     # 8-byte Folded Reload
	ld	s11, 40(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 144
	ret
                                        # -- End function
stencil_2d_9p:                          # @stencil_2d_9p
	addi	sp, sp, -144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	sd	s0, 128(sp)                     # 8-byte Folded Spill
	sd	s1, 120(sp)                     # 8-byte Folded Spill
	sd	s2, 112(sp)                     # 8-byte Folded Spill
	sd	s3, 104(sp)                     # 8-byte Folded Spill
	sd	s4, 96(sp)                      # 8-byte Folded Spill
	sd	s5, 88(sp)                      # 8-byte Folded Spill
	sd	s6, 80(sp)                      # 8-byte Folded Spill
	sd	s7, 72(sp)                      # 8-byte Folded Spill
	sd	s8, 64(sp)                      # 8-byte Folded Spill
	sd	s9, 56(sp)                      # 8-byte Folded Spill
	sd	s10, 48(sp)                     # 8-byte Folded Spill
	sd	s11, 40(sp)                     # 8-byte Folded Spill
	addi	s4, a0, 1
	li	t3, 2
	sd	a2, 32(sp)
	bltu	s4, t3, .LBB1_12
	fld	ft0, 32(sp)
	addi	s5, a1, 2
	addi	s3, a1, -1
	addi	a7, a4, 8
	addi	t0, a1, 1
	slli	a0, t0, 3
	add	t1, a4, a0
	slli	a0, s5, 3
	add	t2, a3, a0
	sltu	a0, a7, t2
	sltu	a2, a3, t1
	and	a0, a0, a2
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	andi	a0, a1, -2
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	ori	a0, a1, 1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	vfmv.v.f	v9, fa2
	vfmv.v.f	v10, fa3
	vfmv.v.f	v11, fa4
	vfmv.v.f	v12, fa5
	vfmv.v.f	v13, fa6
	vfmv.v.f	v14, fa7
	vfmv.v.f	v15, ft0
	addi	t6, a3, 16
	li	s9, 1
	li	s2, -2
	j	.LBB1_4
.LBB1_2:                                #   in Loop: Header=BB1_4 Depth=1
	addi	s9, s9, 1
.LBB1_3:                                #   in Loop: Header=BB1_4 Depth=1
	beq	s9, s4, .LBB1_12
.LBB1_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_8 Depth 2
                                        #     Child Loop BB1_11 Depth 2
	bgeu	s3, s2, .LBB1_2
	addi	a0, s9, -1
	mul	s8, a0, s5
	mul	s7, s9, s5
	addi	s9, s9, 1
	mul	s6, s9, s5
	li	s1, 1
	bltu	a1, t3, .LBB1_10
	slli	s10, s7, 3
	add	a6, a7, s10
	add	a0, t1, s10
	slli	t4, s6, 3
	add	s11, a3, t4
	add	ra, t2, t4
	slli	s0, s8, 3
	add	t5, a3, s0
	add	t3, t2, s0
	sltu	ra, a6, ra
	sltu	a5, s11, a0
	and	a5, ra, a5
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	or	s11, a5, a2
	sltu	a5, a6, t3
	li	t3, 2
	sltu	a0, t5, a0
	and	a0, a0, a5
	or	a0, s11, a0
	bnez	a0, .LBB1_10
	add	s1, t6, s0
	add	a5, t6, t4
	add	a0, t6, s10
	ld	s0, 16(sp)                      # 8-byte Folded Reload
.LBB1_8:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addi	a2, s1, -8
	vle64.v	v16, (a2)
	addi	a2, s1, -16
	vle64.v	v17, (a2)
	vfmul.vf	v16, v16, fa1
	vle64.v	v18, (s1)
	addi	a2, a0, -16
	vle64.v	v19, (a2)
	addi	a2, a0, -8
	vle64.v	v20, (a2)
	vfmacc.vv	v16, v8, v17
	vfmadd.vv	v18, v9, v16
	vfmadd.vv	v19, v10, v18
	vfmadd.vv	v20, v11, v19
	vle64.v	v16, (a0)
	addi	a2, a5, -16
	vle64.v	v17, (a2)
	addi	a2, a5, -8
	vle64.v	v18, (a2)
	vle64.v	v19, (a5)
	vfmadd.vv	v16, v12, v20
	vfmadd.vv	v17, v13, v16
	vfmadd.vv	v18, v14, v17
	vfmadd.vv	v19, v15, v18
	vse64.v	v19, (a6)
	addi	s0, s0, -2
	addi	a6, a6, 16
	addi	s1, s1, 16
	addi	a5, a5, 16
	addi	a0, a0, 16
	bnez	s0, .LBB1_8
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	beq	a0, a1, .LBB1_3
.LBB1_10:                               #   in Loop: Header=BB1_4 Depth=1
	sub	a0, t0, s1
	add	a2, s1, s8
	slli	a2, a2, 3
	add	a5, a3, a2
	add	a2, s1, s7
	slli	s0, a2, 3
	add	a2, a4, s0
	add	s0, s0, a3
	add	s1, s1, s6
	slli	s1, s1, 3
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
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	ld	s0, 128(sp)                     # 8-byte Folded Reload
	ld	s1, 120(sp)                     # 8-byte Folded Reload
	ld	s2, 112(sp)                     # 8-byte Folded Reload
	ld	s3, 104(sp)                     # 8-byte Folded Reload
	ld	s4, 96(sp)                      # 8-byte Folded Reload
	ld	s5, 88(sp)                      # 8-byte Folded Reload
	ld	s6, 80(sp)                      # 8-byte Folded Reload
	ld	s7, 72(sp)                      # 8-byte Folded Reload
	ld	s8, 64(sp)                      # 8-byte Folded Reload
	ld	s9, 56(sp)                      # 8-byte Folded Reload
	ld	s10, 48(sp)                     # 8-byte Folded Reload
	ld	s11, 40(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 144
	ret
                                        # -- End function
