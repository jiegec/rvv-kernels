spmv:                                   # @spmv
	addi	sp, sp, -32
	sd	s0, 24(sp)                      # 8-byte Folded Spill
	sd	s1, 16(sp)                      # 8-byte Folded Spill
	sd	s2, 8(sp)                       # 8-byte Folded Spill
	sd	s3, 0(sp)                       # 8-byte Folded Spill
	beqz	a0, .LBB0_11
	li	a7, 0
	ld	t2, 0(a1)
	addi	a6, a3, 16
	addi	t0, a2, 16
	fmv.d.x	ft0, zero
	li	t1, 4
	fneg.d	ft1, ft0
	vsetivli	zero, 2, e64, m1, ta, mu
	vfmv.v.f	v8, ft1
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv.v.v	v9, v8
	vmv.s.x	v9, zero
	vsetivli	zero, 1, e64, m1, ta, mu
	vfmv.s.f	v10, ft1
	j	.LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
	slli	s1, t3, 3
	add	s1, s1, a5
	fsd	ft1, 0(s1)
	beq	a7, a0, .LBB0_11
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_7 Depth 2
                                        #     Child Loop BB0_10 Depth 2
	mv	t3, a7
	mv	s0, t2
	addi	a7, a7, 1
	slli	s1, a7, 3
	add	s1, s1, a1
	ld	t2, 0(s1)
	fmv.d	ft1, ft0
	bgeu	s0, t2, .LBB0_2
	sub	t5, t2, s0
	bgeu	t5, t1, .LBB0_6
	mv	t4, s0
	fmv.d	ft1, ft0
	j	.LBB0_9
.LBB0_6:                                #   in Loop: Header=BB0_3 Depth=1
	andi	t6, t5, -4
	add	t4, s0, t6
	slli	s0, s0, 3
	add	s2, a6, s0
	add	s1, t0, s0
	mv	s3, t6
	vmv1r.v	v11, v9
	vmv1r.v	v12, v8
.LBB0_7:                                #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetivli	zero, 2, e64, m1, ta, mu
	addi	s0, s1, -16
	vle64.v	v13, (s0)
	addi	s0, s2, -16
	vle64.v	v14, (s0)
	vle64.v	v15, (s1)
	vle64.v	v16, (s2)
	vsll.vi	v13, v13, 3
	vluxei64.v	v13, (a4), v13
	vsll.vi	v15, v15, 3
	vluxei64.v	v15, (a4), v15
	vfmacc.vv	v11, v14, v13
	vfmacc.vv	v12, v16, v15
	addi	s3, s3, -4
	addi	s2, s2, 32
	addi	s1, s1, 32
	bnez	s3, .LBB0_7
	vfadd.vv	v11, v12, v11
	vfredosum.vs	v11, v11, v10
	vfmv.f.s	ft1, v11
	beq	t5, t6, .LBB0_2
.LBB0_9:                                #   in Loop: Header=BB0_3 Depth=1
	sub	t5, t2, t4
	slli	s1, t4, 3
	add	t6, a2, s1
	add	s1, s1, a3
.LBB0_10:                               #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	ld	t4, 0(t6)
	fld	ft2, 0(s1)
	slli	s0, t4, 3
	add	s0, s0, a4
	fld	ft3, 0(s0)
	fmadd.d	ft1, ft2, ft3, ft1
	addi	t5, t5, -1
	addi	t6, t6, 8
	addi	s1, s1, 8
	bnez	t5, .LBB0_10
	j	.LBB0_2
.LBB0_11:
	ld	s0, 24(sp)                      # 8-byte Folded Reload
	ld	s1, 16(sp)                      # 8-byte Folded Reload
	ld	s2, 8(sp)                       # 8-byte Folded Reload
	ld	s3, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
                                        # -- End function
spmv_rvv:                               # @spmv_rvv
	beqz	a0, .LBB1_5
	li	a6, 0
	li	a7, 8
	j	.LBB1_3
.LBB1_2:                                #   in Loop: Header=BB1_3 Depth=1
	vsetvli	zero, t1, e64, m1, tu, mu
	vfredusum.vs	v8, v9, v8
	add	t0, t0, a5
	vsetivli	zero, 1, e64, m1, ta, mu
	vse64.v	v8, (t0)
	beq	a6, a0, .LBB1_5
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_4 Depth 2
	vsetvli	t1, zero, e64, m1, ta, mu
	slli	t0, a6, 3
	add	t2, a1, t0
	ld	t2, 0(t2)
	addi	a6, a6, 1
	slli	t3, a6, 3
	add	t3, t3, a1
	ld	t4, 0(t3)
	vmv.v.i	v8, 0
	vmv.v.i	v9, 0
	bgeu	t2, t4, .LBB1_2
.LBB1_4:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	t4, t4, t2
	vsetvli	t5, t4, e64, m1, ta, mu
	slli	t4, t2, 3
	add	t6, a3, t4
	vle64.v	v10, (t6)
	add	t4, t4, a2
	vle64.v	v11, (t4)
	vmul.vx	v11, v11, a7
	vluxei64.v	v11, (a4), v11
	vsetvli	zero, t5, e64, m1, tu, mu
	ld	t4, 0(t3)
	add	t2, t2, t5
	vfmacc.vv	v9, v10, v11
	bltu	t2, t4, .LBB1_4
	j	.LBB1_2
.LBB1_5:
	ret
                                        # -- End function
spmv_rvv2:                              # @spmv_rvv2
	addi	sp, sp, -16
	sd	s0, 8(sp)                       # 8-byte Folded Spill
	vsetvli	a6, zero, e64, m1, ta, mu
	beqz	a0, .LBB2_10
	li	t1, 0
	ld	t4, 0(a1)
	vmv.v.i	v8, 0
	slli	a7, a6, 3
	li	t0, 8
	j	.LBB2_3
.LBB2_2:                                #   in Loop: Header=BB2_3 Depth=1
	slli	s0, t1, 3
	add	s0, s0, a5
	fsd	ft0, 0(s0)
	mv	t4, t3
	mv	t1, t2
	beq	t2, a0, .LBB2_10
.LBB2_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_5 Depth 2
                                        #     Child Loop BB2_9 Depth 2
	addi	t2, t1, 1
	slli	t3, t2, 3
	add	t3, t3, a1
	ld	t3, 0(t3)
	add	t5, t4, a6
	bgeu	t5, t3, .LBB2_6
	slli	t5, t4, 3
	vmv1r.v	v9, v8
.LBB2_5:                                #   Parent Loop BB2_3 Depth=1
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
	bltu	t6, t3, .LBB2_5
	j	.LBB2_7
.LBB2_6:                                #   in Loop: Header=BB2_3 Depth=1
	vmv1r.v	v9, v8
.LBB2_7:                                #   in Loop: Header=BB2_3 Depth=1
	vsetvli	zero, zero, e64, m1, tu, mu
	vmv1r.v	v10, v8
	vfredusum.vs	v10, v9, v8
	vfmv.f.s	ft0, v10
	bgeu	t4, t3, .LBB2_2
	sub	t5, t3, t4
	slli	t6, t4, 3
	add	t4, a2, t6
	add	t6, t6, a3
.LBB2_9:                                #   Parent Loop BB2_3 Depth=1
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
	bnez	t5, .LBB2_9
	j	.LBB2_2
.LBB2_10:
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
                                        # -- End function
