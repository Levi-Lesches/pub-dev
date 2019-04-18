// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupHoverable() {
  _setEventForHoverable();
}

/// Elements with the `hoverable` class provide hover tooltip for both desktop
/// browsers and touchscreen devices:
///   - when clicked, they are added a `hover` class (toggled on repeated clicks)
///   - when any outside part is clicked, the `hover` class is removed
///   - when the mouse enters *another* `hoverable` element, the previously
///     active has its style removed
///
///  Their `:hover` and `.hover` style must match to have the same effect.
void _setEventForHoverable() {
  Element activeHover;
  void deactivateHover(_) {
    if (activeHover != null) {
      activeHover.classes.remove('hover');
      activeHover = null;
    }
  }

  document.body.onClick.listen(deactivateHover);

  for (Element h in document.querySelectorAll('.hoverable')) {
    h.onClick.listen((e) {
      if (h != activeHover) {
        deactivateHover(e);
        activeHover = h;
        activeHover.classes.add('hover');
        e.stopPropagation();
      }
    });
    h.onMouseEnter.listen((e) {
      if (h != activeHover) {
        deactivateHover(e);
      }
    });
  }
}
