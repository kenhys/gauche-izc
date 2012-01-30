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


CUT_EXPORT void test_cs_IfEq(void)
{
}

CUT_EXPORT void test_cs_IfNeq(void)
{
}

/* occur */
CUT_EXPORT void test_cs_Occur(void)
{
}

CUT_EXPORT void test_cs_OccurDomain(void)
{
}

CUT_EXPORT void test_cs_OccurConstraints(void)
{
}

CUT_EXPORT void test_cs_Index(void)
{
}

CUT_EXPORT void test_cs_Element(void)
{
}
