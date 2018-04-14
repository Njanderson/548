#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

	j test_start

crash_backward:
	RVTEST_FAIL

test_start:

program:
	lui a0, 0xdead // help identify start of block
	li a1, 23
	li a2, 10
	add a3, a1, a2
	lui a0, 0xbeef // help identify end of block
	j test_end

crash_forward:
	RVTEST_FAIL

test_end:
	RVTEST_PASS

RVTEST_CODE_END

RVTEST_DATA_BEGIN
RVTEST_DATA_END
