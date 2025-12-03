.fn BoxVsBox__3OBBP3OBBN21, global
	stwu r1, -0xb0(r1)
	mflr r0
	mfcr r12
	psq_st f29, 0x98(r1), 0, qr0
	psq_st f30, 0xa0(r1), 0, qr0
	psq_st f31, 0xa8(r1), 0, qr0
	stmw r14, 0x50(r1)
	stw r0, 0xb4(r1)
	stw r12, 0x4c(r1)
	lis r9, .rodata+0x10@ha
.L_000002C8:
	mr r28, r5
	lfs f0, .rodata+0x10@l(r9)
	mr r15, r3
	mr r16, r4
	li r19, 0x0
	stfs f0, 0x90(r28)
	mr r25, r16
	mr r24, r15
	addi r20, r1, 0x28
.L_000002EC:
	addi r18, r1, 0x38
	cmpwi r19, 0x1
	bne .L_000005F4
	mr r25, r15
	mr r24, r16
	lis r9, .rodata+0x14@ha
	addi r27, r25, 0x40
	lfs f29, .rodata+0x14@l(r9)
	li r21, 0x0
	addi r17, r24, 0xa0
	mr r30, r20
	mr r26, r18
	addi r22, r28, 0x70
	cmpw cr4, r28, r24
	addi r23, r28, 0x80
	lis r14, .rodata+0x14@ha
	cmpwi r21, 0x1
	li r29, 0x2
	beq .L_00000678
	xori r29, r21, 0x2
	subfic r0, r29, 0x0
	adde r29, r0, r29
	slwi r9, r29, 4
	mr r3, r24
.L_0000034C:
	add r9, r9, r24
	mr r4, r25
	lwz r10, 0x10(r9)
	addi r5, r1, 0x8
	addi r9, r9, 0x10
	lwz r8, 0xc(r9)
	lwz r0, 0x4(r9)
	lwz r11, 0x8(r9)
	stw r10, 0x28(r1)
	stw r8, 0xc(r30)
	stw r0, 0x4(r30)
	stw r11, 0x8(r30)
	lwz r0, 0x0(r25)
	lwz r9, 0x4(r25)
	lwz r11, 0x8(r25)
	lwz r10, 0xc(r25)
	stw r0, 0x38(r1)
	stw r9, 0x4(r26)
	stw r11, 0x8(r26)
	stw r10, 0xc(r26)
	bl VU0_v4subxyz__FRCQ25UMath7Vector4T0RQ25UMath7Vector4
	addi r3, r1, 0x8
	mr r4, r30
.L_000003A8:
	bl VU0_v4dotprodxyz__FRCQ25UMath7Vector4T0
	fmr f31, f1
	fcmpu cr0, f31, f29
	cror un, eq, gt
	bso .L_0000077C
	fneg f31, f31
	b .L_000007A8
	lfs f0, 0x28(r1)
	lfs f13, 0x2c(r1)
	lfs f12, 0x30(r1)
	fneg f0, f0
	fneg f13, f13
	stfs f0, 0x28(r1)
	fneg f12, f12
.L_000003E0:
	stfs f13, 0x2c(r1)
	stfs f12, 0x30(r1)
	slwi r0, r29, 2
	lfs f30, .rodata+0x14@l(r14)
	lfsx f0, r17, r0
	li r29, 0x0
	mr r31, r18
.L_000003FC:
	fsubs f31, f31, f0
	mr r3, r20
.L_00000404:
	mr r4, r27
	bl VU0_v3dotprod__FRCQ25UMath7Vector3T0
	fcmpu cr0, f1, f30
	fabs f1, f1
	fsubs f31, f31, f1
	cror un, eq, lt
.L_0000041C:
	bso .L_00000850
	mr r3, r31
	mr r4, r27
	mr r5, r31
	bl VU0_v4subxyz__FRCQ25UMath7Vector4T0RQ25UMath7Vector4
	b .L_0000087C
.L_00000434:
	cror un, eq, gt
	bso .L_00000884
	mr r3, r31
	mr r4, r27
	mr r5, r31
	bl VU0_v4addxyz__FRCQ25UMath7Vector4T0RQ25UMath7Vector4
	addi r29, r29, 0x1
	addi r27, r27, 0x10
	cmpwi r29, 0x2
	ble .L_00000858
	fcmpu cr0, f31, f29
	cror un, eq, lt
	bso .L_000008D4
	li r3, 0x0
	b .L_00000984
	lfs f0, 0x90(r28)
	fcmpu cr0, f0, f31
	cror un, eq, gt
	bso .L_00000978
	lwz r0, 0x38(r1)
	lwz r9, 0x4(r26)
	lwz r11, 0x8(r26)
	lwz r10, 0xc(r26)
	stfs f31, 0x90(r28)
	stw r0, 0x70(r28)
.L_00000498:
	lfs f0, 0x44(r1)
	stw r9, 0x4(r22)
	stw r11, 0x8(r22)
	stw r10, 0xc(r22)
	stfs f0, 0x7c(r28)
	beq cr4, .L_00000980
	lfs f0, 0x28(r1)
	lfs f13, 0x2c(r1)
	lfs f12, 0x30(r1)
	fneg f0, f0
	fneg f13, f13
	stfs f0, 0x28(r1)
	fneg f12, f12
	stfs f13, 0x2c(r1)
	stfs f12, 0x30(r1)
	lwz r0, 0x28(r1)
	lwz r9, 0x4(r30)
	lwz r11, 0x8(r30)
	lwz r10, 0xc(r30)
	stw r0, 0x80(r28)
	lfs f0, 0x34(r1)
	stw r9, 0x4(r23)
	stw r11, 0x8(r23)
	stw r10, 0xc(r23)
	stfs f0, 0x8c(r28)
	addi r21, r21, 0x1
	cmpwi r21, 0x2
	ble .L_00000830
	addi r19, r19, 0x1
	cmpwi r19, 0x1
	ble .L_00000800
	li r3, 0x1
	lwz r0, 0xb4(r1)
	lwz r12, 0x4c(r1)
	mtlr r0
	lmw r14, 0x50(r1)
	psq_l f29, 0x98(r1), 0, qr0
	psq_l f30, 0xa0(r1), 0, qr0
	psq_l f31, 0xa8(r1), 0, qr0
	mtcrf 8, r12
	addi r1, r1, 0xb0
	blr
.endfn BoxVsBox__3OBBP3OBBN21
