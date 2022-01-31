stencil_2d_5p:                          # @stencil_2d_5p
	addi	sp, sp, -64
	sd	s0, 56(sp)                      # 8-byte Folded Spill
	sd	s1, 48(sp)                      # 8-byte Folded Spill
	sd	s2, 40(sp)                      # 8-byte Folded Spill
	sd	s3, 32(sp)                      # 8-byte Folded Spill
	sd	s4, 24(sp)                      # 8-byte Folded Spill
	sd	s5, 16(sp)                      # 8-byte Folded Spill
	sd	s6, 8(sp)                       # 8-byte Folded Spill
	addi	a4, a0, -1
	li	a6, -3
	bltu	a6, a4, .LBB0_10
	addi	t2, a1, 2
	addi	a7, a1, -1
	slli	t1, a1, 3
	add	a5, t1, a3
	addi	t0, a5, 24
	slli	t6, a1, 4
	add	s1, t6, a3
	addi	s1, s1, 24
	add	s0, t6, a2
	addi	t3, s0, 40
	li	a4, 24
	mul	a4, a1, a4
	add	a4, a4, a2
	addi	a5, a4, 40
	slli	s2, t2, 3
	add	s4, a2, s2
	addi	s5, s0, 32
	addi	t4, a2, 8
	addi	t2, a1, 1
	slli	s0, t2, 3
	add	t5, a2, s0
	sltu	a5, t0, a5
	sltu	s0, t3, s1
	and	t3, a5, s0
	sltu	s0, t0, s5
	sltu	a5, s4, s1
	and	a5, a5, s0
	or	a5, t3, a5
	sltu	s0, t0, t5
	sltu	s1, t4, s1
	and	s1, s1, s0
	or	s0, a5, s1
	andi	t3, a1, -2
	ori	t4, a1, 1
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	vfmv.v.f	v9, fa2
	vfmv.v.f	v10, fa3
	vfmv.v.f	v11, fa4
	addi	t5, t1, 16
	addi	t6, t6, 40
	add	s6, a3, s2
	li	a5, 1
	sltiu	s1, a1, 2
	or	s2, s1, s0
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	addi	a5, s3, 1
	add	a2, a2, t5
	add	t0, t0, t5
	add	s5, s5, t5
	add	s6, s6, t5
	add	s4, s4, t5
	beq	s3, a0, .LBB0_10
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
                                        #     Child Loop BB0_9 Depth 2
	mv	s3, a5
	bltu	a6, a7, .LBB0_2
	li	s0, 1
	bnez	s2, .LBB0_8
	mv	s0, t0
	mv	s1, a2
	mv	a5, t3
.LBB0_6:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a4, s1, t1
	addi	a3, a4, 16
	vle64.v	v12, (a3)
	addi	a3, s1, 8
	vle64.v	v13, (a3)
	vfmul.vf	v12, v12, fa1
	addi	a3, a4, 24
	vle64.v	v14, (a3)
	addi	a3, a4, 32
	vle64.v	v15, (a3)
	add	a3, s1, t6
	vle64.v	v16, (a3)
	vfmacc.vv	v12, v8, v13
	vfmadd.vv	v14, v9, v12
	vfmadd.vv	v15, v10, v14
	vfmadd.vv	v16, v11, v15
	vse64.v	v16, (s0)
	addi	a5, a5, -2
	addi	s1, s1, 16
	addi	s0, s0, 16
	bnez	a5, .LBB0_6
	mv	s0, t4
	beq	t3, a1, .LBB0_2
.LBB0_8:                                #   in Loop: Header=BB0_3 Depth=1
	sub	a5, t2, s0
	slli	s0, s0, 3
.LBB0_9:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a3, s4, s0
	fld	ft0, -8(a3)
	add	a4, a2, s0
	fld	ft1, 0(a4)
	fmul.d	ft0, ft0, fa1
	fld	ft2, 0(a3)
	fld	ft3, 8(a3)
	add	a3, s5, s0
	fld	ft4, 0(a3)
	fmadd.d	ft0, fa0, ft1, ft0
	fmadd.d	ft0, fa2, ft2, ft0
	fmadd.d	ft0, fa3, ft3, ft0
	fmadd.d	ft0, fa4, ft4, ft0
	add	a3, s6, s0
	fsd	ft0, 0(a3)
	addi	a5, a5, -1
	addi	s0, s0, 8
	bnez	a5, .LBB0_9
	j	.LBB0_2
.LBB0_10:
	ld	s0, 56(sp)                      # 8-byte Folded Reload
	ld	s1, 48(sp)                      # 8-byte Folded Reload
	ld	s2, 40(sp)                      # 8-byte Folded Reload
	ld	s3, 32(sp)                      # 8-byte Folded Reload
	ld	s4, 24(sp)                      # 8-byte Folded Reload
	ld	s5, 16(sp)                      # 8-byte Folded Reload
	ld	s6, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
	ret
                                        # -- End function
stencil_2d_9p:                          # @stencil_2d_9p
	addi	sp, sp, -80
	sd	s0, 72(sp)                      # 8-byte Folded Spill
	sd	s1, 64(sp)                      # 8-byte Folded Spill
	sd	s2, 56(sp)                      # 8-byte Folded Spill
	sd	s3, 48(sp)                      # 8-byte Folded Spill
	sd	s4, 40(sp)                      # 8-byte Folded Spill
	sd	s5, 32(sp)                      # 8-byte Folded Spill
	sd	s6, 24(sp)                      # 8-byte Folded Spill
	sd	s7, 16(sp)                      # 8-byte Folded Spill
	addi	a5, a0, -1
	li	a6, -3
	sd	a2, 8(sp)
	bltu	a6, a5, .LBB1_10
	fld	ft0, 8(sp)
	addi	t0, a1, 2
	addi	a7, a1, -1
	slli	t5, a1, 3
	addi	s3, t5, 24
	add	t2, a4, s3
	slli	t4, a1, 4
	add	s0, t4, a4
	addi	s0, s0, 24
	add	s2, t4, a3
	addi	a5, s2, 32
	li	a2, 24
	mul	a2, a1, a2
	add	a2, a2, a3
	addi	a2, a2, 48
	slli	s4, t0, 3
	add	s1, a3, s4
	sltu	t0, t2, a2
	sltu	a2, a5, s0
	and	t0, t0, a2
	sltu	a5, t2, a5
	sltu	a2, s1, s0
	and	a2, a2, a5
	or	a2, t0, a2
	sltu	a5, t2, s1
	sltu	s1, a3, s0
	and	a5, a5, s1
	or	s0, a2, a5
	andi	t0, a1, -2
	ori	t1, a1, 1
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, fa0
	vfmv.v.f	v9, fa2
	vfmv.v.f	v10, fa3
	vfmv.v.f	v11, fa4
	vfmv.v.f	v12, fa5
	vfmv.v.f	v13, fa6
	vfmv.v.f	v14, fa7
	vfmv.v.f	v15, ft0
	addi	t3, t5, 16
	addi	t6, t4, 32
	addi	t4, a1, 1
	add	s4, s4, a4
	add	s5, a3, s3
	addi	s6, s2, 40
	li	a4, 1
	sltiu	s1, a1, 2
	or	s2, s1, s0
	j	.LBB1_3
.LBB1_2:                                #   in Loop: Header=BB1_3 Depth=1
	addi	a4, s3, 1
	add	t2, t2, t3
	add	a3, a3, t3
	add	s4, s4, t3
	add	s5, s5, t3
	add	s6, s6, t3
	beq	s3, a0, .LBB1_10
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_6 Depth 2
                                        #     Child Loop BB1_9 Depth 2
	mv	s3, a4
	bltu	a6, a7, .LBB1_2
	li	a4, 1
	bnez	s2, .LBB1_8
	mv	a4, a3
	mv	s0, t2
	mv	s1, t0
.LBB1_6:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addi	a5, a4, 8
	vle64.v	v16, (a5)
	vle64.v	v17, (a4)
	vfmul.vf	v16, v16, fa1
	add	s7, a4, t5
	add	a2, a4, t6
	addi	a4, a4, 16
	vle64.v	v18, (a4)
	addi	a5, s7, 16
	vle64.v	v19, (a5)
	addi	a5, s7, 24
	vle64.v	v20, (a5)
	vfmacc.vv	v16, v8, v17
	vfmadd.vv	v18, v9, v16
	vfmadd.vv	v19, v10, v18
	vfmadd.vv	v20, v11, v19
	addi	a5, s7, 32
	vle64.v	v16, (a5)
	vle64.v	v17, (a2)
	addi	a5, a2, 8
	vle64.v	v18, (a5)
	addi	a2, a2, 16
	vle64.v	v19, (a2)
	vfmadd.vv	v16, v12, v20
	vfmadd.vv	v17, v13, v16
	vfmadd.vv	v18, v14, v17
	vfmadd.vv	v19, v15, v18
	vse64.v	v19, (s0)
	addi	s1, s1, -2
	addi	s0, s0, 16
	bnez	s1, .LBB1_6
	mv	a4, t1
	beq	t0, a1, .LBB1_2
.LBB1_8:                                #   in Loop: Header=BB1_3 Depth=1
	sub	s0, t4, a4
	slli	s1, a4, 3
.LBB1_9:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a2, a3, s1
	fld	ft1, 0(a2)
	fld	ft2, -8(a2)
	fmul.d	ft1, ft1, fa1
	fld	ft3, 8(a2)
	add	a2, s5, s1
	fld	ft4, -16(a2)
	fld	ft5, -8(a2)
	fmadd.d	ft1, fa0, ft2, ft1
	fmadd.d	ft1, fa2, ft3, ft1
	fmadd.d	ft1, fa3, ft4, ft1
	fmadd.d	ft1, fa4, ft5, ft1
	fld	ft2, 0(a2)
	add	a2, s6, s1
	fld	ft3, -16(a2)
	fld	ft4, -8(a2)
	fld	ft5, 0(a2)
	fmadd.d	ft1, fa5, ft2, ft1
	fmadd.d	ft1, fa6, ft3, ft1
	fmadd.d	ft1, fa7, ft4, ft1
	fmadd.d	ft1, ft0, ft5, ft1
	add	a2, s4, s1
	fsd	ft1, 0(a2)
	addi	s0, s0, -1
	addi	s1, s1, 8
	bnez	s0, .LBB1_9
	j	.LBB1_2
.LBB1_10:
	ld	s0, 72(sp)                      # 8-byte Folded Reload
	ld	s1, 64(sp)                      # 8-byte Folded Reload
	ld	s2, 56(sp)                      # 8-byte Folded Reload
	ld	s3, 48(sp)                      # 8-byte Folded Reload
	ld	s4, 40(sp)                      # 8-byte Folded Reload
	ld	s5, 32(sp)                      # 8-byte Folded Reload
	ld	s6, 24(sp)                      # 8-byte Folded Reload
	ld	s7, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	ret
                                        # -- End function
