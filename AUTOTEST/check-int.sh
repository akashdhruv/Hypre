#!/bin/sh
#BHEADER**********************************************************************
# Copyright (c) 2008,  Lawrence Livermore National Security, LLC.
# Produced at the Lawrence Livermore National Laboratory.
# This file is part of HYPRE.  See file COPYRIGHT for details.
#
# HYPRE is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License (as published by the Free
# Software Foundation) version 2.1 dated February 1999.
#
# $Revision$
#EHEADER**********************************************************************

testname=`basename $0 .sh`

# Echo usage information
case $1 in
   -h|-help)
      cat <<EOF

   $0 [-h|-help] {src_dir}

   where: {src_dir}  is the hypre source directory
          -h|-help   prints this usage information and exits

   This script checks for 'int' in the 'HYPRE_Int' sections of hypre.

   Example usage: $0 ..

EOF
      exit
      ;;
esac

# Setup
src_dir=$1
shift

cd $src_dir

find . -regextype posix-egrep -regex '.*\.(c|cc|cpp|cxx|C|h|hpp|hxx|H)' -print |
  egrep -v '/AUTOTEST' |
  egrep -v '/babel' |
  egrep -v '/docs' |
  egrep -v '/docs_misc' |
  egrep -v '/examples' |
  egrep -v '/FEI_mv' > check-int.files

egrep '(^|[^[:alnum:]_]+)int([^[:alnum:]_]+|$)' `cat check-int.files` >&2

rm -f check-int.files