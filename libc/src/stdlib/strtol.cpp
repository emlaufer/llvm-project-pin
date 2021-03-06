//===-- Implementation of strtol ------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/stdlib/strtol.h"
#include "src/__support/common.h"
#include "src/__support/str_to_integer.h"

namespace __llvm_libc {

LLVM_LIBC_FUNCTION(long, strtol,
                   (const char *__restrict str, char **__restrict str_end,
                    int base)) {
  return internal::strtointeger<long>(str, str_end, base);
}

} // namespace __llvm_libc
