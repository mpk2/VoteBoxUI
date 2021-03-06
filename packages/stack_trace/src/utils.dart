// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The line used in the string representation of stack chains to represent
/// the gap between traces.
const chainGap = '===== asynchronous gap ===========================\n';

/// Returns [string] with enough spaces added to the end to make it [length]
/// characters long.
String padRight(String string, int length) {
  if (string.length >= length) return string;

  var result = new StringBuffer();
  result.write(string);
  for (var i = 0; i < length - string.length; i++) {
    result.write(' ');
  }

  return result.toString();
}
