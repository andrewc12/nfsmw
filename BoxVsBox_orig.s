.fn BoxVsBox__3OBBP3OBBN21, global
	stwu r1, -0xa8(r1)
	mflr r0
	mfcr r12
	psq_st f29, 0x90(r1), 0, qr0
	psq_st f30, 0x98(r1), 0, qr0
	psq_st f31, 0xa0(r1), 0, qr0
	stmw r14, 0x48(r1)
	stw r0, 0xac(r1)
	stw r12, 0x44(r1)
	addi r0, r1, 0x18
	mr r17, r3
	mr r18, r4
	li r21, 0x0
	stw r0, 0x38(r1)
	mr r30, r5
	mr r25, r17
	mr r27, r18
	cmpwi r21, 0x1
	addi r14, r1, 0x28
	addi r15, r1, 0x8
.L_80272BDC:
	bne .L_80272BE8
	mr r25, r18
	mr r27, r17
.L_80272BE8:
	lis r9, lbl_80403FBC@ha
	lwz r26, 0x38(r1)
	lfs f29, lbl_80403FBC@l(r9)
	li r23, 0x0
	addi r19, r27, 0x40
	addi r20, r25, 0xa0
	mr r28, r14
	mr r22, r15
	addi r24, r30, 0x70
	cmpw cr4, r30, r25
	lis r16, lbl_80403FBC@ha
.L_80272C14:
	cmpwi r23, 0x1
	li r29, 0x2
	beq .L_80272C2C
	xori r29, r23, 0x2
	subfic r0, r29, 0x0
	adde r29, r0, r29
.L_80272C2C:
	slwi r9, r29, 4
	mr r3, r25
	add r9, r9, r25
	mr r4, r27
	lwz r10, 0x10(r9)
	mr r5, r22
	addi r9, r9, 0x10
	mr r31, r19
	lwz r8, 0xc(r9)
	lwz r11, 0x4(r9)
	lwz r0, 0x8(r9)
	stw r10, 0x18(r1)
	stw r8, 0xc(r26)
	stw r11, 0x4(r26)
	stw r0, 0x8(r26)
	lwz r0, 0x0(r27)
	lwz r9, 0x4(r27)
	lwz r11, 0x8(r27)
	lwz r10, 0xc(r27)
	stw r0, 0x28(r1)
	stw r9, 0x4(r28)
	stw r11, 0x8(r28)
	stw r10, 0xc(r28)
	bl VU0_v4subxyz__FRCQ25UMath7Vector4T0RQ25UMath7Vector4
	mr r3, r22
	mr r4, r26
	bl VU0_v4dotprodxyz__FRCQ25UMath7Vector4T0
	fmr f31, f1
	fcmpu cr0, f31, f29
	cror un, eq, gt
	bso .L_80272CB0
	fneg f31, f31
	b .L_80272CD4
.L_80272CB0:
	lfs f0, 0x18(r1)
	lfs f13, 0x1c(r1)
	lfs f12, 0x20(r1)
	fneg f0, f0
	fneg f13, f13
	stfs f0, 0x18(r1)
	fneg f12, f12
	stfs f13, 0x1c(r1)
	stfs f12, 0x20(r1)
.L_80272CD4:
	slwi r0, r29, 2
	lfs f30, lbl_80403FBC@l(r16)
	lfsx f0, r20, r0
	li r29, 0x0
	fsubs f31, f31, f0
.L_80272CE8:
	addi r3, r1, 0x18
	mr r4, r31
	bl VU0_v3dotprod__FRCQ25UMath7Vector3T0
	fcmpu cr0, f1, f30
	fabs f1, f1
	fsubs f31, f31, f1
	cror un, eq, lt
	bso .L_80272D1C
	addi r3, r1, 0x28
	mr r4, r31
	mr r5, r3
	bl VU0_v4subxyz__FRCQ25UMath7Vector4T0RQ25UMath7Vector4
	b .L_80272D34
.L_80272D1C:
	cror un, eq, gt
	bso .L_80272D34
	addi r3, r1, 0x28
	mr r4, r31
	mr r5, r3
	bl VU0_v4addxyz__FRCQ25UMath7Vector4T0RQ25UMath7Vector4
.L_80272D34:
	addi r29, r29, 0x1
	addi r31, r31, 0x10
	cmpwi r29, 0x2
	ble .L_80272CE8
	fcmpu cr0, f31, f29
	cror un, eq, lt
	bso .L_80272D58
	li r3, 0x0
	b .L_80272DE4
.L_80272D58:
	lfs f0, 0x90(r30)
	fcmpu cr0, f31, f0
	cror un, eq, lt
	bso .L_80272DC8
	lwz r0, 0x28(r1)
	lwz r9, 0x4(r28)
	lwz r11, 0x8(r28)
	lwz r10, 0xc(r28)
	stfs f31, 0x90(r30)
	stw r0, 0x70(r30)
	stw r9, 0x4(r24)
	stw r11, 0x8(r24)
	stw r10, 0xc(r24)
	beq cr4, .L_80272DB0
	lfs f0, 0x18(r1)
	lfs f13, 0x1c(r1)
	lfs f12, 0x20(r1)
	fneg f0, f0
	fneg f13, f13
	stfs f0, 0x80(r30)
	fneg f12, f12
	b .L_80272DC0
.L_80272DB0:
	lfs f0, 0x18(r1)
	lfs f13, 0x1c(r1)
	lfs f12, 0x20(r1)
	stfs f0, 0x80(r30)
.L_80272DC0:
	stfs f13, 0x84(r30)
	stfs f12, 0x88(r30)
.L_80272DC8:
	addi r23, r23, 0x1
	cmpwi r23, 0x2
	ble .L_80272C14
	addi r21, r21, 0x1
	cmpwi r21, 0x1
	ble .L_80272BDC
	li r3, 0x1
.L_80272DE4:
	lwz r0, 0xac(r1)
	lwz r12, 0x44(r1)
	mtlr r0
	lmw r14, 0x48(r1)
	psq_l f29, 0x90(r1), 0, qr0
	psq_l f30, 0x98(r1), 0, qr0
	psq_l f31, 0xa0(r1), 0, qr0
	mtcrf 8, r12
	addi r1, r1, 0xa8
	blr
.endfn BoxVsBox__3OBBP3OBBN21
