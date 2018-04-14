#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

	j test_start

crash_backward:
	RVTEST_FAIL

test_start:

program:
	la x31, xreg_init_data
	ld x0, 0(x31)
	ld x1, 8(x31)
	add x2, x0, x1
	j test_end

crash_forward:
	RVTEST_FAIL

test_end:
	RVTEST_PASS

RVTEST_CODE_END

	.data

hidden_data:
	.align 8
xreg_init_data:
reg_x0_init:	.dword 0x000000000000beef
reg_x1_init:	.dword 0x0000000000000001

RVTEST_DATA_BEGIN
RVTEST_DATA_END
