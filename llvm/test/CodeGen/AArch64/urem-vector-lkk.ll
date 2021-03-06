; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

define <4 x i16> @fold_urem_vec_1(<4 x i16> %x) {
; CHECK-LABEL: fold_urem_vec_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w8, v0.h[0]
; CHECK-NEXT:    mov w9, #8969
; CHECK-NEXT:    movk w9, #22765, lsl #16
; CHECK-NEXT:    umov w10, v0.h[1]
; CHECK-NEXT:    mov w12, #16913
; CHECK-NEXT:    mov w13, #95
; CHECK-NEXT:    movk w12, #8456, lsl #16
; CHECK-NEXT:    umull x9, w8, w9
; CHECK-NEXT:    ubfx w14, w10, #2, #14
; CHECK-NEXT:    lsr x9, x9, #32
; CHECK-NEXT:    sub w11, w8, w9
; CHECK-NEXT:    umull x12, w14, w12
; CHECK-NEXT:    add w9, w9, w11, lsr #1
; CHECK-NEXT:    umov w11, v0.h[2]
; CHECK-NEXT:    lsr w9, w9, #6
; CHECK-NEXT:    lsr x12, x12, #34
; CHECK-NEXT:    msub w8, w9, w13, w8
; CHECK-NEXT:    mov w9, #33437
; CHECK-NEXT:    movk w9, #21399, lsl #16
; CHECK-NEXT:    mov w13, #124
; CHECK-NEXT:    umull x9, w11, w9
; CHECK-NEXT:    msub w10, w12, w13, w10
; CHECK-NEXT:    umov w12, v0.h[3]
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov w13, #2287
; CHECK-NEXT:    lsr x8, x9, #37
; CHECK-NEXT:    mov w9, #98
; CHECK-NEXT:    movk w13, #16727, lsl #16
; CHECK-NEXT:    msub w8, w8, w9, w11
; CHECK-NEXT:    mov v0.h[1], w10
; CHECK-NEXT:    umull x9, w12, w13
; CHECK-NEXT:    mov w10, #1003
; CHECK-NEXT:    lsr x9, x9, #40
; CHECK-NEXT:    mov v0.h[2], w8
; CHECK-NEXT:    msub w8, w9, w10, w12
; CHECK-NEXT:    mov v0.h[3], w8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 95, i16 124, i16 98, i16 1003>
  ret <4 x i16> %1
}

define <4 x i16> @fold_urem_vec_2(<4 x i16> %x) {
; CHECK-LABEL: fold_urem_vec_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w10, v0.h[0]
; CHECK-NEXT:    mov w8, #8969
; CHECK-NEXT:    umov w9, v0.h[1]
; CHECK-NEXT:    movk w8, #22765, lsl #16
; CHECK-NEXT:    umov w15, v0.h[2]
; CHECK-NEXT:    umov w16, v0.h[3]
; CHECK-NEXT:    umull x12, w10, w8
; CHECK-NEXT:    umull x11, w9, w8
; CHECK-NEXT:    lsr x12, x12, #32
; CHECK-NEXT:    lsr x11, x11, #32
; CHECK-NEXT:    sub w14, w10, w12
; CHECK-NEXT:    sub w13, w9, w11
; CHECK-NEXT:    add w12, w12, w14, lsr #1
; CHECK-NEXT:    umull x14, w15, w8
; CHECK-NEXT:    add w11, w11, w13, lsr #1
; CHECK-NEXT:    mov w13, #95
; CHECK-NEXT:    lsr w12, w12, #6
; CHECK-NEXT:    lsr w11, w11, #6
; CHECK-NEXT:    umull x8, w16, w8
; CHECK-NEXT:    msub w10, w12, w13, w10
; CHECK-NEXT:    lsr x12, x14, #32
; CHECK-NEXT:    msub w9, w11, w13, w9
; CHECK-NEXT:    sub w11, w15, w12
; CHECK-NEXT:    lsr x8, x8, #32
; CHECK-NEXT:    fmov s0, w10
; CHECK-NEXT:    add w10, w12, w11, lsr #1
; CHECK-NEXT:    lsr w10, w10, #6
; CHECK-NEXT:    sub w11, w16, w8
; CHECK-NEXT:    mov v0.h[1], w9
; CHECK-NEXT:    msub w9, w10, w13, w15
; CHECK-NEXT:    add w8, w8, w11, lsr #1
; CHECK-NEXT:    lsr w8, w8, #6
; CHECK-NEXT:    mov v0.h[2], w9
; CHECK-NEXT:    msub w8, w8, w13, w16
; CHECK-NEXT:    mov v0.h[3], w8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  ret <4 x i16> %1
}


; Don't fold if we can combine urem with udiv.
define <4 x i16> @combine_urem_udiv(<4 x i16> %x) {
; CHECK-LABEL: combine_urem_udiv:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w9, v0.h[0]
; CHECK-NEXT:    mov w8, #8969
; CHECK-NEXT:    movk w8, #22765, lsl #16
; CHECK-NEXT:    umov w10, v0.h[1]
; CHECK-NEXT:    umov w11, v0.h[2]
; CHECK-NEXT:    mov w15, #95
; CHECK-NEXT:    umov w13, v0.h[3]
; CHECK-NEXT:    umull x12, w9, w8
; CHECK-NEXT:    umull x14, w10, w8
; CHECK-NEXT:    lsr x12, x12, #32
; CHECK-NEXT:    umull x17, w11, w8
; CHECK-NEXT:    sub w16, w9, w12
; CHECK-NEXT:    lsr x14, x14, #32
; CHECK-NEXT:    lsr x17, x17, #32
; CHECK-NEXT:    umull x8, w13, w8
; CHECK-NEXT:    add w12, w12, w16, lsr #1
; CHECK-NEXT:    sub w16, w10, w14
; CHECK-NEXT:    lsr w12, w12, #6
; CHECK-NEXT:    lsr x8, x8, #32
; CHECK-NEXT:    add w14, w14, w16, lsr #1
; CHECK-NEXT:    sub w16, w11, w17
; CHECK-NEXT:    msub w9, w12, w15, w9
; CHECK-NEXT:    lsr w14, w14, #6
; CHECK-NEXT:    add w16, w17, w16, lsr #1
; CHECK-NEXT:    fmov s1, w12
; CHECK-NEXT:    msub w10, w14, w15, w10
; CHECK-NEXT:    sub w17, w13, w8
; CHECK-NEXT:    fmov s0, w9
; CHECK-NEXT:    lsr w9, w16, #6
; CHECK-NEXT:    mov v1.h[1], w14
; CHECK-NEXT:    add w8, w8, w17, lsr #1
; CHECK-NEXT:    msub w11, w9, w15, w11
; CHECK-NEXT:    lsr w8, w8, #6
; CHECK-NEXT:    mov v0.h[1], w10
; CHECK-NEXT:    msub w10, w8, w15, w13
; CHECK-NEXT:    mov v1.h[2], w9
; CHECK-NEXT:    mov v0.h[2], w11
; CHECK-NEXT:    mov v1.h[3], w8
; CHECK-NEXT:    mov v0.h[3], w10
; CHECK-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %2 = udiv <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %3 = add <4 x i16> %1, %2
  ret <4 x i16> %3
}


; Don't fold for divisors that are a power of two.
define <4 x i16> @dont_fold_urem_power_of_two(<4 x i16> %x) {
; CHECK-LABEL: dont_fold_urem_power_of_two:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w10, v0.h[0]
; CHECK-NEXT:    umov w9, v0.h[3]
; CHECK-NEXT:    mov w8, #8969
; CHECK-NEXT:    umov w11, v0.h[1]
; CHECK-NEXT:    movk w8, #22765, lsl #16
; CHECK-NEXT:    and w10, w10, #0x3f
; CHECK-NEXT:    umull x8, w9, w8
; CHECK-NEXT:    and w11, w11, #0x1f
; CHECK-NEXT:    lsr x8, x8, #32
; CHECK-NEXT:    fmov s1, w10
; CHECK-NEXT:    umov w10, v0.h[2]
; CHECK-NEXT:    sub w12, w9, w8
; CHECK-NEXT:    mov v1.h[1], w11
; CHECK-NEXT:    add w8, w8, w12, lsr #1
; CHECK-NEXT:    and w10, w10, #0x7
; CHECK-NEXT:    lsr w8, w8, #6
; CHECK-NEXT:    mov w11, #95
; CHECK-NEXT:    msub w8, w8, w11, w9
; CHECK-NEXT:    mov v1.h[2], w10
; CHECK-NEXT:    mov v1.h[3], w8
; CHECK-NEXT:    fmov d0, d1
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 64, i16 32, i16 8, i16 95>
  ret <4 x i16> %1
}

; Don't fold if the divisor is one.
define <4 x i16> @dont_fold_srem_one(<4 x i16> %x) {
; CHECK-LABEL: dont_fold_srem_one:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w9, v0.h[1]
; CHECK-NEXT:    mov w8, #30865
; CHECK-NEXT:    movk w8, #51306, lsl #16
; CHECK-NEXT:    umov w11, v0.h[2]
; CHECK-NEXT:    mov w12, #654
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    mov w13, #47143
; CHECK-NEXT:    ubfx w10, w9, #1, #15
; CHECK-NEXT:    movk w13, #24749, lsl #16
; CHECK-NEXT:    umull x8, w10, w8
; CHECK-NEXT:    mov w10, #17097
; CHECK-NEXT:    movk w10, #45590, lsl #16
; CHECK-NEXT:    lsr x8, x8, #40
; CHECK-NEXT:    umull x10, w11, w10
; CHECK-NEXT:    msub w8, w8, w12, w9
; CHECK-NEXT:    umov w9, v0.h[3]
; CHECK-NEXT:    lsr x10, x10, #36
; CHECK-NEXT:    mov w12, #23
; CHECK-NEXT:    msub w10, w10, w12, w11
; CHECK-NEXT:    mov w11, #5423
; CHECK-NEXT:    mov v1.h[1], w8
; CHECK-NEXT:    umull x8, w9, w13
; CHECK-NEXT:    lsr x8, x8, #43
; CHECK-NEXT:    mov v1.h[2], w10
; CHECK-NEXT:    msub w8, w8, w11, w9
; CHECK-NEXT:    mov v1.h[3], w8
; CHECK-NEXT:    fmov d0, d1
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 1, i16 654, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold if the divisor is 2^16.
define <4 x i16> @dont_fold_urem_i16_smax(<4 x i16> %x) {
; CHECK-LABEL: dont_fold_urem_i16_smax:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %1 = urem <4 x i16> %x, <i16 1, i16 65536, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold i64 urem.
define <4 x i64> @dont_fold_urem_i64(<4 x i64> %x) {
; CHECK-LABEL: dont_fold_urem_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #17097
; CHECK-NEXT:    fmov x9, d1
; CHECK-NEXT:    movk x8, #45590, lsl #16
; CHECK-NEXT:    mov x13, #21445
; CHECK-NEXT:    movk x8, #34192, lsl #32
; CHECK-NEXT:    movk x13, #1603, lsl #16
; CHECK-NEXT:    movk x8, #25644, lsl #48
; CHECK-NEXT:    movk x13, #15432, lsl #32
; CHECK-NEXT:    mov x10, v0.d[1]
; CHECK-NEXT:    movk x13, #25653, lsl #48
; CHECK-NEXT:    umulh x8, x9, x8
; CHECK-NEXT:    mov x11, v1.d[1]
; CHECK-NEXT:    sub x12, x9, x8
; CHECK-NEXT:    lsr x14, x10, #1
; CHECK-NEXT:    add x8, x8, x12, lsr #1
; CHECK-NEXT:    mov x12, #12109
; CHECK-NEXT:    movk x12, #52170, lsl #16
; CHECK-NEXT:    umulh x13, x14, x13
; CHECK-NEXT:    movk x12, #28749, lsl #32
; CHECK-NEXT:    mov w14, #23
; CHECK-NEXT:    movk x12, #49499, lsl #48
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    lsr x13, x13, #7
; CHECK-NEXT:    umulh x12, x11, x12
; CHECK-NEXT:    msub x8, x8, x14, x9
; CHECK-NEXT:    mov w9, #5423
; CHECK-NEXT:    lsr x12, x12, #12
; CHECK-NEXT:    mov w14, #654
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    msub x9, x12, x9, x11
; CHECK-NEXT:    msub x10, x13, x14, x10
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    mov v1.d[1], x9
; CHECK-NEXT:    mov v0.d[1], x10
; CHECK-NEXT:    ret
  %1 = urem <4 x i64> %x, <i64 1, i64 654, i64 23, i64 5423>
  ret <4 x i64> %1
}
