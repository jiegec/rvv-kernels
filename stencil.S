stencil:                                # @stencil
	addi	sp, sp, -64
	sd	s0, 56(sp)                      # 8-byte Folded Spill
	sd	s1, 48(sp)                      # 8-byte Folded Spill
	sd	s2, 40(sp)                      # 8-byte Folded Spill
	sd	s3, 32(sp)                      # 8-byte Folded Spill
	sd	s4, 24(sp)                      # 8-byte Folded Spill
	sd	s5, 16(sp)                      # 8-byte Folded Spill
	sd	s6, 8(sp)                       # 8-byte Folded Spill
	sd	s7, 0(sp)                       # 8-byte Folded Spill
	addi	a4, a0, -1
	li	a6, -3
	bltu	a6, a4, .LBB0_10
	addi	a4, a1, 2
	addi	a7, a1, -1
	slli	t1, a1, 3
	add	a5, t1, a3
	addi	t0, a5, 24
	slli	t6, a1, 4
	add	s1, t6, a3
	addi	s1, s1, 24
	slli	s2, a4, 3
	add	s4, a2, s2
	add	s0, t6, a2
	addi	s6, s0, 32
	addi	t3, s0, 40
	li	s0, 24
	mul	s0, a1, s0
	add	s0, s0, a2
	addi	s3, s0, 40
	addi	t4, a2, 8
	addi	t2, a1, 1
	slli	a5, t2, 3
	add	t5, a2, a5
	sltu	a5, t0, s6
	sltu	s0, s4, s1
	and	s5, a5, s0
	sltu	s0, t0, s3
	sltu	a5, t3, s1
	and	a5, a5, s0
	or	a5, s5, a5
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
	add	s5, a3, s2
	li	a5, 1
	sltiu	s1, a1, 2
	or	s2, s1, s0
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	addi	a5, s3, 1
	add	t0, t0, t5
	add	a2, a2, t5
	add	s4, s4, t5
	add	s6, s6, t5
	add	s5, s5, t5
	beq	s3, a0, .LBB0_10
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
                                        #     Child Loop BB0_9 Depth 2
	mv	s3, a5
	bltu	a6, a7, .LBB0_2
	li	s0, 1
	bnez	s2, .LBB0_8
	mv	s0, a2
	mv	s1, t0
	mv	a5, t3
.LBB0_6:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a4, s0, t1
	addi	a3, s0, 8
	vle64.v	v12, (a3)
	addi	s7, a4, 16
	addi	a3, a4, 24
	vle64.v	v13, (a3)
	vfmul.vf	v12, v12, fa1
	add	a3, s0, t6
	vle64.v	v14, (a3)
	addi	a3, a4, 32
	vle64.v	v15, (a3)
	vle64.v	v16, (s7)
	vfmacc.vv	v12, v8, v13
	vfmadd.vv	v14, v9, v12
	vfmadd.vv	v15, v10, v14
	vfmadd.vv	v16, v11, v15
	vse64.v	v16, (s1)
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
	add	a3, a2, s0
	fld	ft0, 0(a3)
	add	a3, s4, s0
	fld	ft1, 0(a3)
	fmul.d	ft0, ft0, fa1
	add	a4, s6, s0
	fld	ft2, 0(a4)
	fld	ft3, 8(a3)
	fld	ft4, -8(a3)
	fmadd.d	ft0, fa0, ft1, ft0
	fmadd.d	ft0, fa2, ft2, ft0
	fmadd.d	ft0, fa3, ft3, ft0
	fmadd.d	ft0, fa4, ft4, ft0
	add	a3, s5, s0
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
	ld	s7, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
	ret
                                        # -- End function
