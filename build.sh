#!/bin/bash
# -*- coding: utf-8-unix -*-

GOSH=gosh
CFLAGS="-DHAVE_BOOL"

CB_BUILD=0
CB_CLEAN=0
CB_TEST=0
CB_TEST_SCM=""
CB_LIBTEST=0

function cb_build ()
{
    mkdir -p log/
    $GAUCHE_CONFIG --fixup-extension izclib izc
        $GOSH $GENSTUB izclib.stub
        if [ $? -ne 0 ]; then
            exit
        fi
        com="gcc -c izclib_head.c -I$GDIST_INCDIR"
        echo $com
        eval $com
        if [ $? -ne 0 ]; then
            exit
        fi
        com="gcc -c izclib_tail.c -I$GDIST_INCDIR"
        echo $com
        eval $com
        if [ $? -ne 0 ]; then
            exit
        fi
        com="LANG=C gcc -c izclib.c -I$GDIST_INCDIR $CFLAGS 2>&1 | tee log/izclib.c.log"
        echo $com
        eval $com
        if [ $? -ne 0 ]; then
            exit
        fi
        com="LANG=C gcc -c izc.c -I$GDIST_INCDIR $CFLAGS 2>&1 | tee log/izc.c.log"
        echo $com
        eval $com
        if [ $? -ne 0 ]; then
            exit
        fi
        com="LANG=C gcc -lmingw32 `gauche-config --dylib-ldflags` izc.dll *.o  -L. -liz -L$GDIST_LIBDIR -lgauche-0.9"
        echo $com
        eval $com
        if [ $? -ne 0 ]; then
            exit
        fi
}

function cb_clean ()
{

    rm -f *.o
    rm -f izclib.c
    rm -f config.status
    rm -f configure
    rm -f *.exe
    rm -f izc.dll
    rm -f *.log
    rm -fr autom4te.*
    rm -f *_head.*
    rm -f *_tail.*
    rm -f *.def
    rm -f Makefile
    rm -f *.gpd
    rm -f test/*.dll
    rm -f *~
}

function cb_test ()
{
        #$GOSH -I. test/test-demon.scm
    #$GOSH -I. test/test-nqueen.scm
    if [ ! -z "$CB_TEST_SCM" ]; then
        $GOSH -I. $CB_TEST_SCM
    else
        sh test/run-test.sh
    fi 
}

function cb_libtest ()
{
    
    for f in $CB_LIBTESTSRC; do
        echo $f
        obj=${f%%.c}".dll"
        echo $obj
        gcc -std=c99 -shared -g -o $obj $f -I. -I./test `pkg-config --cflags glib-2.0 cutter` `pkg-config --libs cutter glib-2.0` -L. -liz
	done
}

while [ $# -gt 0 ]; do
    case "$1" in
        -g|debug)
            shift
            CFLAGS="$CFLAGS -DHAVE_BOOL -DDEBUG"
            ;;
        -gf|debugfunc)
            shift
            CFLAGS="$CFLAGS -DHAVE_BOOL -DDEBUG -DDEBUG_FUNC"
            ;;
        -t|test)
            shift
            CB_TEST=1
            if [ ! -z "$1" ]; then
                if [ -f "$1" ]; then
                    # each
                    CB_TEST_SCM=$1
                    shift
                fi
            fi
            ;;
        -lt|libtest)
            shift
            CB_LIBTEST=1
 
            if [ ! -z "$1" ]; then
                if [ -f "$1" ]; then
                    CB_LIBTESTSRC=$1
                    shift
                else
                    CB_LIBTESTSRC=test/test_*.c
                fi
            fi
            ;;
        -c|clean)
            shift
            CB_CLEAN=1
            ;;
        -b|build)
            CB_BUILD=1
            shift
            ;;
        -genlib)
            pexports iz.dll > iz.dll.def
            dlltool --dllname iz.dll --input-def iz.dll.def --output-lib libiz.a
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [ -f "$GOSH_PATH" ]; then
    GOSH_BIN_DIR=`dirname $GOSH_PATH`
    GOSH_DIR=`dirname $GOSH_BIN_DIR`
    GDIST_INCDIR=`gauche-config --sysincdir`
    GDIST_INCDIR=`echo $GDIST_INCDIR|sed -e 's|\\\\|/|g'`
    
    GDIST_LIBDIR=$GOSH_DIR/bin
    GAUCHE_CONFIG=$GOSH_DIR/bin/gauche-config
    GENSTUB=`gauche-config --syslibdir`/genstub
fi

if [ $CB_BUILD -eq 1 ]; then
    cb_build
fi
if [ $CB_CLEAN -eq 1 ]; then
    cb_clean
fi
if [ $CB_TEST -eq 1 ]; then
    cb_test
fi
if [ $CB_LIBTEST -eq 1 ]; then
    cb_libtest
fi
