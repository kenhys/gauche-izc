#include <stdio.h>
#include <limits.h>
#include <cutter.h>
#include <glib.h>

#include "iz.h"

CUT_EXPORT void cut_startup(void)
{
#if DEBUG
    g_print("cut_startup\n");
#endif
    cut_message("cut_startup");
}
CUT_EXPORT void cut_shutdown(void)
{
#if DEBUG
    g_print("cut_shutdown\n");
#endif
    cut_message("cut_shutdown");
}

CUT_EXPORT void cut_setup(void)
{
#if DEBUG
    g_print("cut_setup\n");
#endif
    cut_message("cut_setup");
    cs_init();
}
CUT_EXPORT void cut_teardown(void)
{
#if DEBUG
    g_print("cut_teardown\n");
#endif
    cut_message("cut_teardown");
    cs_end();
}

CUT_EXPORT void test_cs_Eq(void)
{
    cut_assert_true(cs_Eq(CSINT(0), CSINT(0)));
    cut_assert_true(cs_Eq(CSINT(INT_MIN), CSINT(INT_MIN)));
    cut_assert_true(cs_Eq(CSINT(INT_MAX), CSINT(INT_MAX)));
}

CUT_EXPORT void test_cs_EQ(void)
{
    cut_assert_true(cs_EQ(CSINT(0), 0));
    cut_assert_true(cs_EQ(CSINT(INT_MIN), INT_MIN));
    cut_assert_true(cs_EQ(CSINT(INT_MAX), INT_MAX));
}

CUT_EXPORT void test_cs_Neq(void)
{
    cut_assert_true(cs_Neq(CSINT(0), CSINT(INT_MAX)));
    cut_assert_true(cs_Neq(CSINT(INT_MIN), CSINT(INT_MAX)));
    cut_assert_true(cs_Neq(CSINT(INT_MAX), CSINT(INT_MIN)));
}

CUT_EXPORT void test_cs_NEQ(void)
{
    cut_assert_true(cs_NEQ(CSINT(0), INT_MAX));
    cut_assert_true(cs_NEQ(CSINT(INT_MIN), INT_MAX));
    cut_assert_true(cs_NEQ(CSINT(INT_MAX), INT_MIN));
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

CUT_EXPORT void test_cs_LE(void)
{
    cut_assert_true(cs_LE(CSINT(0), 0));
    cut_assert_true(cs_LE(CSINT(INT_MIN), INT_MIN));
    cut_assert_true(cs_LE(CSINT(INT_MAX), INT_MAX));
    cut_assert_true(cs_LE(CSINT(INT_MIN), INT_MAX));
}

CUT_EXPORT void test_cs_Ge(void)
{
    cs_init();

    cut_assert_true(cs_Ge(CSINT(0), CSINT(0)));
    cut_assert_true(cs_Ge(CSINT(INT_MAX), CSINT(INT_MAX)));
    cut_assert_true(cs_Ge(CSINT(INT_MIN), CSINT(INT_MIN)));

    cut_assert_true(cs_Ge(CSINT(1), CSINT(0)));
    cut_assert_true(cs_Ge(CSINT(0), CSINT(-1)));
    cut_assert_true(cs_Ge(CSINT(-1), CSINT(INT_MIN)));
    cut_assert_true(cs_Ge(CSINT(INT_MAX), CSINT(1)));
    cut_assert_true(cs_Ge(CSINT(INT_MAX), CSINT(INT_MIN)));
}

CUT_EXPORT void test_cs_GE(void)
{
    cut_assert_true(cs_GE(CSINT(0), 0));
    cut_assert_true(cs_GE(CSINT(INT_MIN), INT_MIN));
    cut_assert_true(cs_GE(CSINT(INT_MAX), INT_MAX));
    cut_assert_true(cs_GE(CSINT(INT_MAX), INT_MIN));
}

CUT_EXPORT void test_cs_Lt(void)
{
    cs_init();

    cut_assert_true(cs_Lt(CSINT(0), CSINT(INT_MAX)));
    cut_assert_true(cs_Lt(CSINT(INT_MIN), CSINT(0)));
    cut_assert_true(cs_Lt(CSINT(INT_MIN), CSINT(INT_MAX)));

    cut_assert_true(cs_Lt(CSINT(0), CSINT(1)));
    cut_assert_true(cs_Lt(CSINT(-1), CSINT(0)));
    cut_assert_true(cs_Lt(CSINT(INT_MIN), CSINT(-1)));
    cut_assert_true(cs_Lt(CSINT(1), CSINT(INT_MAX)));
}

CUT_EXPORT void test_cs_LT(void)
{
}

CUT_EXPORT void test_cs_Gt(void)
{
    cs_init();

    cut_assert_true(cs_Gt(CSINT(INT_MAX), CSINT(0)));
    cut_assert_true(cs_Gt(CSINT(0), CSINT(INT_MIN)));
    cut_assert_true(cs_Gt(CSINT(INT_MAX), CSINT(INT_MIN)));

    cut_assert_true(cs_Gt(CSINT(1), CSINT(0)));
    cut_assert_true(cs_Gt(CSINT(0), CSINT(-1)));
    cut_assert_true(cs_Gt(CSINT(-1), CSINT(INT_MIN)));
    cut_assert_true(cs_Gt(CSINT(INT_MAX), CSINT(1)));
}

CUT_EXPORT void test_cs_GT(void)
{
}
