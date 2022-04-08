gemm:                                   # @gemm
	addi	sp, sp, -80
	sd	s0, 72(sp)                      # 8-byte Folded Spill
	sd	s1, 64(sp)                      # 8-byte Folded Spill
	sd	s2, 56(sp)                      # 8-byte Folded Spill
	sd	s3, 48(sp)                      # 8-byte Folded Spill
	sd	s4, 40(sp)                      # 8-byte Folded Spill
	sd	s5, 32(sp)                      # 8-byte Folded Spill
	sd	s6, 24(sp)                      # 8-byte Folded Spill
	sd	s7, 16(sp)                      # 8-byte Folded Spill
	sd	s8, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB0_14
	li	a6, 0
	li	a7, 0
	sltiu	s1, a1, 4
	xori	s1, s1, 1
	addi	s0, a2, -1
	seqz	s0, s0
	and	t0, s1, s0
	andi	t1, a1, -4
	addi	t2, a3, 16
	slli	t3, a1, 3
	addi	t4, a4, 16
	slli	t5, a2, 5
	slli	t6, a2, 3
	fmv.d.x	ft0, zero
	fneg.d	ft0, ft0
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, ft0
	vfmv.s.f	v9, ft0
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	addi	a7, a7, 1
	add	t2, t2, t3
	add	a6, a6, a1
	beq	a7, a0, .LBB0_14
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
                                        #       Child Loop BB0_9 Depth 3
                                        #       Child Loop BB0_13 Depth 3
	beqz	a2, .LBB0_2
	li	s5, 0
	mul	s2, a7, a2
	mv	s4, t4
	j	.LBB0_6
.LBB0_5:                                #   in Loop: Header=BB0_6 Depth=2
	fsd	ft0, 0(s3)
	addi	s5, s5, 1
	addi	s4, s4, 8
	beq	s5, a2, .LBB0_2
.LBB0_6:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_9 Depth 3
                                        #       Child Loop BB0_13 Depth 3
	add	s0, s5, s2
	slli	s0, s0, 3
	add	s3, a5, s0
	fld	ft0, 0(s3)
	fmul.d	ft0, ft0, fa1
	beqz	a1, .LBB0_5
	beqz	t0, .LBB0_11
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv1r.v	v10, v8
	vfmv.s.f	v10, ft0
	mv	s6, t1
	mv	s8, s4
	mv	s1, t2
	vmv1r.v	v11, v8
.LBB0_9:                                #   Parent Loop BB0_3 Depth=1
                                        #     Parent Loop BB0_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	addi	s7, s1, -16
	vsetvli	zero, zero, e64, m1, ta, mu
	vle64.v	v12, (s7)
	vle64.v	v13, (s1)
	addi	s0, s8, -16
	vle64.v	v14, (s0)
	vle64.v	v15, (s8)
	vfmacc.vv	v10, v12, v14
	vfmacc.vv	v11, v13, v15
	addi	s1, s1, 32
	addi	s6, s6, -4
	add	s8, s8, t5
	bnez	s6, .LBB0_9
	vfadd.vv	v10, v11, v10
	vfredosum.vs	v10, v10, v9
	vfmv.f.s	ft0, v10
	mv	s0, t1
	beq	t1, a1, .LBB0_5
	j	.LBB0_12
.LBB0_11:                               #   in Loop: Header=BB0_6 Depth=2
	li	s0, 0
.LBB0_12:                               #   in Loop: Header=BB0_6 Depth=2
	sub	s6, a1, s0
	mul	s1, a2, s0
	add	s1, s1, s5
	slli	s1, s1, 3
	add	s1, s1, a4
	add	s0, s0, a6
	slli	s0, s0, 3
	add	s0, s0, a3
.LBB0_13:                               #   Parent Loop BB0_3 Depth=1
                                        #     Parent Loop BB0_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	fld	ft1, 0(s0)
	fld	ft2, 0(s1)
	fmadd.d	ft0, ft1, ft2, ft0
	addi	s6, s6, -1
	add	s1, s1, t6
	addi	s0, s0, 8
	bnez	s6, .LBB0_13
	j	.LBB0_5
.LBB0_14:
	ld	s0, 72(sp)                      # 8-byte Folded Reload
	ld	s1, 64(sp)                      # 8-byte Folded Reload
	ld	s2, 56(sp)                      # 8-byte Folded Reload
	ld	s3, 48(sp)                      # 8-byte Folded Reload
	ld	s4, 40(sp)                      # 8-byte Folded Reload
	ld	s5, 32(sp)                      # 8-byte Folded Reload
	ld	s6, 24(sp)                      # 8-byte Folded Reload
	ld	s7, 16(sp)                      # 8-byte Folded Reload
	ld	s8, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 80
	ret
                                        # -- End function
