spmv:                                   # @spmv
	beqz	a0, .LBB0_6
	ld	t2, 0(a1)
	li	a6, 0
	fmv.d.x	ft0, zero
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	slli	a6, a6, 3
	add	a6, a6, a5
	fsd	ft1, 0(a6)
	mv	t2, t0
	mv	a6, a7
	beq	a7, a0, .LBB0_6
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
	addi	a7, a6, 1
	slli	t0, a7, 3
	add	t0, t0, a1
	ld	t0, 0(t0)
	fmv.d	ft1, ft0
	bgeu	t2, t0, .LBB0_2
	sub	t1, t0, t2
	slli	t3, t2, 3
	add	t2, a2, t3
	add	t3, t3, a3
	fmv.d	ft1, ft0
.LBB0_5:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	ld	t4, 0(t2)
	fld	ft2, 0(t3)
	slli	t4, t4, 3
	add	t4, t4, a4
	fld	ft3, 0(t4)
	fmadd.d	ft1, ft2, ft3, ft1
	addi	t1, t1, -1
	addi	t2, t2, 8
	addi	t3, t3, 8
	bnez	t1, .LBB0_5
	j	.LBB0_2
.LBB0_6:
	ret
                                        # -- End function
spmv_compiler_vectorize:                # @spmv_compiler_vectorize
	addi	sp, sp, -32
	sd	s0, 24(sp)                      # 8-byte Folded Spill
	sd	s1, 16(sp)                      # 8-byte Folded Spill
	sd	s2, 8(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB1_11
	li	a7, 0
	ld	t0, 0(a1)
	fmv.d.x	ft0, zero
	li	a6, 8
	fneg.d	ft1, ft0
	vsetivli	zero, 4, e64, m1, ta, mu
	vfmv.v.f	v8, ft1
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv.v.v	v9, v8
	vmv.s.x	v9, zero
	vfmv.s.f	v10, ft1
	j	.LBB1_3
.LBB1_2:                                #   in Loop: Header=BB1_3 Depth=1
	slli	s1, t1, 3
	add	s1, s1, a5
	fsd	ft1, 0(s1)
	beq	a7, a0, .LBB1_11
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_7 Depth 2
                                        #     Child Loop BB1_10 Depth 2
	mv	t1, a7
	mv	t5, t0
	addi	a7, a7, 1
	slli	s0, a7, 3
	add	s0, s0, a1
	ld	t0, 0(s0)
	fmv.d	ft1, ft0
	bgeu	t5, t0, .LBB1_2
	sub	t3, t0, t5
	bgeu	t3, a6, .LBB1_6
	mv	t2, t5
	fmv.d	ft1, ft0
	j	.LBB1_9
.LBB1_6:                                #   in Loop: Header=BB1_3 Depth=1
	andi	t4, t3, -8
	add	t2, t5, t4
	slli	s0, t5, 3
	add	t5, a3, s0
	add	t6, a2, s0
	mv	s0, t4
	vmv1r.v	v11, v9
	vmv1r.v	v12, v8
.LBB1_7:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addi	s2, t6, 32
	addi	s1, t5, 32
	vsetvli	zero, zero, e64, m1, ta, mu
	vle64.v	v13, (t6)
	vle64.v	v14, (t5)
	vle64.v	v15, (s2)
	vle64.v	v16, (s1)
	vsll.vi	v13, v13, 3
	vluxei64.v	v13, (a4), v13
	vsll.vi	v15, v15, 3
	vluxei64.v	v15, (a4), v15
	vfmacc.vv	v11, v14, v13
	vfmacc.vv	v12, v16, v15
	addi	s0, s0, -8
	addi	t5, t5, 64
	addi	t6, t6, 64
	bnez	s0, .LBB1_7
	vfadd.vv	v11, v12, v11
	vfredosum.vs	v11, v11, v10
	vfmv.f.s	ft1, v11
	beq	t3, t4, .LBB1_2
.LBB1_9:                                #   in Loop: Header=BB1_3 Depth=1
	sub	t3, t0, t2
	slli	s1, t2, 3
	add	t2, a2, s1
	add	s0, a3, s1
.LBB1_10:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	ld	s1, 0(t2)
	fld	ft2, 0(s0)
	slli	s1, s1, 3
	add	s1, s1, a4
	fld	ft3, 0(s1)
	fmadd.d	ft1, ft2, ft3, ft1
	addi	t3, t3, -1
	addi	t2, t2, 8
	addi	s0, s0, 8
	bnez	t3, .LBB1_10
	j	.LBB1_2
.LBB1_11:
	ld	s0, 24(sp)                      # 8-byte Folded Reload
	ld	s1, 16(sp)                      # 8-byte Folded Reload
	ld	s2, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
spmv_rvv:                               # @spmv_rvv
	beqz	a0, .LBB2_5
	li	a6, 0
	li	a7, 8
	j	.LBB2_3
.LBB2_2:                                #   in Loop: Header=BB2_3 Depth=1
	vsetvli	t1, zero, e64, m1, tu, mu
	vfredusum.vs	v8, v9, v8
	add	t0, t0, a5
	vsetivli	zero, 1, e64, m1, ta, mu
	vse64.v	v8, (t0)
	beq	a6, a0, .LBB2_5
.LBB2_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_4 Depth 2
	vsetvli	t0, zero, e64, m1, ta, mu
	slli	t0, a6, 3
	add	t1, a1, t0
	ld	t1, 0(t1)
	addi	a6, a6, 1
	slli	t2, a6, 3
	add	t2, t2, a1
	ld	t3, 0(t2)
	vmv.v.i	v8, 0
	vmv.v.i	v9, 0
	bgeu	t1, t3, .LBB2_2
.LBB2_4:                                #   Parent Loop BB2_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	t3, t3, t1
	vsetvli	t4, t3, e64, m1, ta, mu
	slli	t3, t1, 3
	add	t5, a3, t3
	vle64.v	v10, (t5)
	add	t3, t3, a2
	vle64.v	v11, (t3)
	vmul.vx	v11, v11, a7
	vluxei64.v	v11, (a4), v11
	vsetvli	zero, t4, e64, m1, tu, mu
	ld	t3, 0(t2)
	add	t1, t1, t4
	vfmacc.vv	v9, v10, v11
	bltu	t1, t3, .LBB2_4
	j	.LBB2_2
.LBB2_5:
	ret
                                        # -- End function
spmv_rvv2:                              # @spmv_rvv2
	addi	sp, sp, -16
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	vsetvli	a6, zero, e64, m1, ta, mu
	beqz	a0, .LBB3_10
	li	t1, 0
	ld	t4, 0(a1)
	vmv.v.i	v8, 0
	slli	a7, a6, 3
	li	t0, 8
	j	.LBB3_3
.LBB3_2:                                #   in Loop: Header=BB3_3 Depth=1
	slli	s0, t1, 3
	add	s0, s0, a5
	fsd	ft0, 0(s0)
	mv	t4, t3
	mv	t1, t2
	beq	t2, a0, .LBB3_10
.LBB3_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_5 Depth 2
                                        #     Child Loop BB3_9 Depth 2
	addi	t2, t1, 1
	slli	t3, t2, 3
	add	t3, t3, a1
	ld	t3, 0(t3)
	add	t5, t4, a6
	bgeu	t5, t3, .LBB3_6
	slli	t5, t4, 3
	vmv1r.v	v9, v8
.LBB3_5:                                #   Parent Loop BB3_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	t6, a3, t5
	vsetvli	zero, zero, e64, m1, ta, mu
	vle64.v	v10, (t6)
	add	t6, a2, t5
	vle64.v	v11, (t6)
	vmul.vx	v11, v11, t0
	vluxei64.v	v11, (a4), v11
	vsetvli	zero, zero, e64, m1, tu, mu
	vfmacc.vv	v9, v10, v11
	add	t4, t4, a6
	add	t6, a6, t4
	add	t5, t5, a7
	bltu	t6, t3, .LBB3_5
	j	.LBB3_7
.LBB3_6:                                #   in Loop: Header=BB3_3 Depth=1
	vmv1r.v	v9, v8
.LBB3_7:                                #   in Loop: Header=BB3_3 Depth=1
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv1r.v	v10, v8
	vfredusum.vs	v10, v9, v8
	vfmv.f.s	ft0, v10
	bgeu	t4, t3, .LBB3_2
	sub	t5, t3, t4
	slli	t6, t4, 3
	add	t4, a2, t6
	add	t6, t6, a3
.LBB3_9:                                #   Parent Loop BB3_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	ld	s0, 0(t4)
	fld	ft1, 0(t6)
	slli	s0, s0, 3
	add	s0, s0, a4
	fld	ft2, 0(s0)
	fmadd.d	ft0, ft1, ft2, ft0
	addi	t5, t5, -1
	addi	t4, t4, 8
	addi	t6, t6, 8
	bnez	t5, .LBB3_9
	j	.LBB3_2
.LBB3_10:
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
                                        # -- End function
