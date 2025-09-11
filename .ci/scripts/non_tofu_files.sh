#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

if [ $# -ne 1 ]; then
  echo "usage: $0 module_path"
  exit 2
fi

# make sure we only have `*.tf` files (ignoring the tests/ directory)
FILES=$(find "$1" -path "$1/tests" -prune -o -type f \! -name '*.tf' -print)

if [ "$FILES" != "" ]; then
  echo "non .tf files found in $1:"
  echo "$FILES"
  exit 3
fi

# make sure the tests/ directory only has `*.tf` and `*tftest.hcl` files
FILES=$(find "$1/tests" -type f \! -name '*.tf' \! -name '*.tftest.hcl' -print)

if [ "$FILES" != "" ]; then
  echo "non test files found in $1/tests:"
  echo "$FILES"
  exit 3
fi
