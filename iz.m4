dnl
dnl Configure iz
dnl This file is included by the toplevel configure.ac
dnl

dnl
dnl process with-iz
dnl

dnl Use iz unless explicitly specified otherwise
ac_cv_use_iz=yes
IZ_CPPFLAGS=
IZ_LDFLAGS=

AC_ARG_WITH(iz,
  AC_HELP_STRING([--with-iz=PATH],
                 [Use iz library installed under PATH.
The rfc.iz module uses iz if it is avilable.  If your system has iz
library in non-trivial location, specify this option.
The include file is looked for in PATH/include,
and the library file is looked for in PATH/lib.
If you don't want to use iz for some reason, say --without-iz. ]),
  [
  case $with_iz in
    no)  ac_cv_use_iz=no;;
    yes) ;;
    *)   IZ_CPPFLAGS="-I$with_iz/include";
         IZ_LDFLAGS="-L$with_iz/lib";;
  esac
 ])

dnl
dnl Check iz.h
dnl

if test "$ac_cv_use_iz" != no; then
  save_cppflags=$CPPFLAGS
  CPPFLAGS="$CPPFLAGS $IZ_CPPFLAGS"
  AC_CHECK_HEADER([iz.h],
     AC_DEFINE(HAVE_IZ_H,1,[Define if you have iz.h and want to use it]),
     [AC_MSG_WARN("Can't find iz.h so I turned off using iz; you may want to use --with-iz=PATH.")
      ac_cv_use_iz=no])
  CPPFLAGS=$save_cppflags
fi

dnl
dnl Check libz.
dnl

if test "$ac_cv_use_iz" = yes; then
  save_cflags="$CFLAGS"
  save_ldflags="$LDFLAGS"
  save_libs="$LIBS"
  CFLAGS="$CFLAGS $IZ_CPPFLAGS"
  LDFLAGS="$LDFLAGS $IZ_LDFLAGS"
  LIBS="$LIBS -liz"
  AC_LINK_IFELSE(
    [AC_LANG_PROGRAM([#include <iz.h>],
                     [[cs_init();]])],
    [IZ_LIB="-liz"],
    [AC_MSG_WARN("Can't find libiz so I turned off using iz; you may want to use --with-iz=PATH")
      ac_cv_use_iz=no])
  CFLAGS="$save_cflags"
  LDFLAGS="$save_ldflags"
  LIBS="$save_libs"
fi

if test "$ac_cv_use_iz" = yes; then
  AC_DEFINE(USE_IZ)
  IZ_ARCHFILES=iz.$SHLIB_SO_SUFFIX
  AC_SUBST(IZ_ARCHFILES)
  iz_SCMFILES=iz.scm
  AC_SUBST(IZ_SCMFILES)
fi
AC_SUBST(IZ_CPPFLAGS)
AC_SUBST(IZ_LDFLAGS)




dnl Local variables:
dnl mode: autoconf
dnl end:
