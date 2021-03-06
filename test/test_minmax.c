

#include <stdio.h>
#include <limits.h>
#include <cutter.h>

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

CUT_EXPORT void test_cs_getMin(void)
{
    cs_init();
    CSint *vint = NULL;

    vint = CSINT(0);
    cut_assert_equal_int(0, cs_getMin(vint));

    vint = CSINT(INT_MIN);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint));

    vint = CSINT(INT_MAX);
    cut_assert_equal_int(INT_MAX, cs_getMin(vint));

    /* overflow */
    vint = CSINT(INT_MIN-1);
    cut_assert_equal_int(INT_MAX, cs_getMin(vint));

    /* overflow */
    vint = CSINT(INT_MAX+1);
    cut_assert_equal_int(INT_MIN, cs_getMin(vint));

}

CUT_EXPORT void test_cs_getMax(void)
{
    cs_init();
    CSint *vint = NULL;

    vint = CSINT(0);
    cut_assert_equal_int(0, cs_getMax(vint));

    vint = CSINT(INT_MIN);
    cut_assert_equal_int(INT_MIN, cs_getMax(vint));

    vint = CSINT(INT_MAX);
    cut_assert_equal_int(INT_MAX, cs_getMax(vint));

    /* overflow */
    vint = CSINT(INT_MIN-1);
    cut_assert_equal_int(INT_MAX, cs_getMax(vint));

    /* overflow */
    vint = CSINT(INT_MAX+1);
    cut_assert_equal_int(INT_MIN, cs_getMax(vint));

    /**/
    vint = cs_createCSint(0, 10);
    
}


CUT_EXPORT void test_cs_Min(void)
{
}

CUT_EXPORT void test_cs_VMin(void)
{
}

CUT_EXPORT void test_cs_Max(void)
{
}

CUT_EXPORT void test_cs_VMax(void)
{
}
