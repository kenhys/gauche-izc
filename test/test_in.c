#include <stdio.h>
#include <limits.h>
#include <cutter.h>

#include "iz.h"

CUT_EXPORT void cut_startup(void)
{
    cut_message("cut_startup");
}
CUT_EXPORT void cut_shutdown(void)
{
    cut_message("cut_shutdown");
}

CUT_EXPORT void cut_setup(void)
{
    cut_message("cut_setup");
    cs_init();
}
CUT_EXPORT void cut_teardown(void)
{
    cut_message("cut_teardown");
    cs_end();
}
CUT_EXPORT void test_cs_Le(void)
{
    cut_assert_true(cs_Le(CSINT(0), CSINT(0)));
    cut_assert_true(cs_Le(CSINT(INT_MAX), CSINT(INT_MAX)));
    cut_assert_true(cs_Le(CSINT(INT_MIN), CSINT(INT_MIN)));

    cut_assert_true(cs_Le(CSINT(0), CSINT(1)));
    cut_assert_true(cs_Le(CSINT(-1), CSINT(0)));
    cut_assert_true(cs_Le(CSINT(INT_MIN), CSINT(-1)));
    cut_assert_true(cs_Le(CSINT(1), CSINT(INT_MAX)));
    cut_assert_true(cs_Le(CSINT(INT_MIN), CSINT(INT_MAX)));

    /**/
    CSint* vint = cs_createCSint(1, 10);
    cut_assert_true(cs_Le(vint, CSINT(INT_MAX)));
}

CUT_EXPORT void test_cs_Ge(void)
{
    cs_getErr();
}

CUT_EXPORT void test_cs_Lt(void)
{
    cs_init();
    cs_getErr();
}

CUT_EXPORT void test_cs_Gt(void)
{
    cs_init();
    cs_getErr();
}

CUT_EXPORT void test_cs_Eq(void)
{
    cs_init();
    cs_getErr();
}

CUT_EXPORT void test_cs_Neq(void)
{
    cs_init();
    cs_getErr();
}


