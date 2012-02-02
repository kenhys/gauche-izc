#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

CUT_EXPORT void test_init(void)
{
    cs_init();
    cut_assert_true(TRUE);
}

CUT_EXPORT void test_end(void)
{
    cs_end();
    cut_assert_true(TRUE);
}

CUT_EXPORT void test_cs_getErr(void)
{
    cs_init();
    cut_assert_equal_int(CS_ERR_NONE, cs_getErr());
}

CUT_EXPORT void test_cs_getErr_no_init(void)
{
    cut_assert_equal_int(CS_ERR_NONE, cs_getErr());
}

