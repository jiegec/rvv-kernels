gemm:                                   # @gemm
	addi	sp, sp, -16
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB0_8
	li	a6, 0
	slli	a7, a2, 3
	slli	t0, a1, 3
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	addi	a6, a6, 1
	add	a3, a3, t0
	beq	a6, a0, .LBB0_8
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
                                        #       Child Loop BB0_7 Depth 3
	beqz	a2, .LBB0_2
	li	t1, 0
	mul	t2, a6, a2
	mv	t3, a4
	j	.LBB0_6
.LBB0_5:                                #   in Loop: Header=BB0_6 Depth=2
	fsd	ft0, 0(t4)
	addi	t1, t1, 1
	addi	t3, t3, 8
	beq	t1, a2, .LBB0_2
.LBB0_6:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_7 Depth 3
	add	s0, t1, t2
	slli	s0, s0, 3
	add	t4, a5, s0
	fld	ft0, 0(t4)
	fmul.d	ft0, ft0, fa1
	mv	t5, a3
	mv	t6, t3
	mv	s0, a1
	beqz	a1, .LBB0_5
.LBB0_7:                                #   Parent Loop BB0_3 Depth=1
                                        #     Parent Loop BB0_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	fld	ft1, 0(t5)
	fld	ft2, 0(t6)
	fmadd.d	ft0, ft1, ft2, ft0
	addi	s0, s0, -1
	add	t6, t6, a7
	addi	t5, t5, 8
	bnez	s0, .LBB0_7
	j	.LBB0_5
.LBB0_8:
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
                                        # -- End function
gemm_compiler_vectorize:                # @gemm_compiler_vectorize
	addi	sp, sp, -64
	sd	s0, 56(sp)                      # 8-byte Folded Spill
	sd	s1, 48(sp)                      # 8-byte Folded Spill
	sd	s2, 40(sp)                      # 8-byte Folded Spill
	sd	s3, 32(sp)                      # 8-byte Folded Spill
	sd	s4, 24(sp)                      # 8-byte Folded Spill
	sd	s5, 16(sp)                      # 8-byte Folded Spill
	sd	s6, 8(sp)                       # 8-byte Folded Spill
	sd	s7, 0(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB1_14
	li	a6, 0
	li	a7, 0
	sltiu	s1, a1, 8
	xori	s1, s1, 1
	addi	s0, a2, -1
	seqz	s0, s0
	and	t0, s1, s0
	andi	t1, a1, -8
	slli	t2, a1, 3
	slli	t3, a2, 6
	slli	t4, a2, 3
	fmv.d.x	ft0, zero
	fneg.d	ft0, ft0
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, ft0
	vfmv.s.f	v9, ft0
	mv	t5, a3
	j	.LBB1_3
.LBB1_2:                                #   in Loop: Header=BB1_3 Depth=1
	addi	a7, a7, 1
	add	t5, t5, t2
	add	a6, a6, a1
	beq	a7, a0, .LBB1_14
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_6 Depth 2
                                        #       Child Loop BB1_9 Depth 3
                                        #       Child Loop BB1_13 Depth 3
	beqz	a2, .LBB1_2
	li	t6, 0
	mul	s2, a7, a2
	mv	s4, a4
	j	.LBB1_6
.LBB1_5:                                #   in Loop: Header=BB1_6 Depth=2
	fsd	ft0, 0(s3)
	addi	t6, t6, 1
	addi	s4, s4, 8
	beq	t6, a2, .LBB1_2
.LBB1_6:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_9 Depth 3
                                        #       Child Loop BB1_13 Depth 3
	add	s0, t6, s2
	slli	s0, s0, 3
	add	s3, a5, s0
	fld	ft0, 0(s3)
	fmul.d	ft0, ft0, fa1
	beqz	a1, .LBB1_5
	beqz	t0, .LBB1_11
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv1r.v	v10, v8
	vfmv.s.f	v10, ft0
	mv	s5, t1
	mv	s7, s4
	mv	s0, t5
	vmv1r.v	v11, v8
.LBB1_9:                                #   Parent Loop BB1_3 Depth=1
                                        #     Parent Loop BB1_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	addi	s6, s0, 32
	vsetvli	zero, zero, e64, m1, ta, mu
	vle64.v	v12, (s0)
	vle64.v	v13, (s6)
	vle64.v	v14, (s7)
	addi	s1, s7, 32
	vle64.v	v15, (s1)
	vfmacc.vv	v10, v12, v14
	vfmacc.vv	v11, v13, v15
	addi	s0, s0, 64
	addi	s5, s5, -8
	add	s7, s7, t3
	bnez	s5, .LBB1_9
	vfadd.vv	v10, v11, v10
	vfredosum.vs	v10, v10, v9
	vfmv.f.s	ft0, v10
	mv	s0, t1
	beq	t1, a1, .LBB1_5
	j	.LBB1_12
.LBB1_11:                               #   in Loop: Header=BB1_6 Depth=2
	li	s0, 0
.LBB1_12:                               #   in Loop: Header=BB1_6 Depth=2
	sub	s5, a1, s0
	mul	s1, a2, s0
	add	s1, s1, t6
	slli	s1, s1, 3
	add	s1, s1, a4
	add	s0, s0, a6
	slli	s0, s0, 3
	add	s0, s0, a3
.LBB1_13:                               #   Parent Loop BB1_3 Depth=1
                                        #     Parent Loop BB1_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	fld	ft1, 0(s0)
	fld	ft2, 0(s1)
	fmadd.d	ft0, ft1, ft2, ft0
	addi	s5, s5, -1
	add	s1, s1, t4
	addi	s0, s0, 8
	bnez	s5, .LBB1_13
	j	.LBB1_5
.LBB1_14:
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
