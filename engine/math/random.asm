Random_::
; Generate a random 16-bit value.
	ldh a, [hRandomSub]
	ld h, a
	ldh a, [hRandomAdd]
	ld l, a
	or a, h ; a = h | l -> if hl == 0: a = 0
	cp 0 ; if a != 0: skip_seeding -> if hl != 0: skip_seeding
	jp nz, skip_seeding
	ld a, 1 ; seed cant be 0, start from 1
	ld l, a
skip_seeding:
	; ty http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html
	; unsigned xs = 1;
	; unsigned xorshift( )
	; {
	; 	xs ^= xs << 7;
	; 	xs ^= xs >> 9;
	; 	xs ^= xs << 8;
	; 	return xs;
	; }
	ld a,h
	rra
	ld a,l
	rra
	xor h
	ld h,a
	ld a,l
	rra
	ld a,h
	rra
	xor l
	ld l,a
	xor h
	ldh [hRandomSub], a
	ld a,l
	ldh [hRandomAdd], a
	ret
