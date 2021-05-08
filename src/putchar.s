;; FILE: putchar.s

.area _CODE
_putchar::
_putchar_rr_s::
	ld      hl,#2
	add     hl,sp

	ld      a,(hl)

	cp	#10
	jr	nz,nocr
	ld	a,#13
nocr:
          rst 16 ; call    0xBB5A
          ret
