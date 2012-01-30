/* -*- coding: utf-8; -*- */
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
