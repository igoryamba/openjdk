/*
 * Copyright (c) 2001, Oracle and/or its affiliates. All rights reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This code is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 only, as
 * published by the Free Software Foundation.
 *
 * This code is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * version 2 for more details (a copy is included in the LICENSE file that
 * accompanied this code).
 *
 * You should have received a copy of the GNU General Public License version
 * 2 along with this work; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
 * or visit www.oracle.com if you need additional information or have any
 * questions.
 *
 */

package sun.jvm.hotspot.bugspot.tree;

import sun.jvm.hotspot.debugger.cdbg.*;
import sun.jvm.hotspot.ui.tree.SimpleTreeNode;

/** Encapsulates an enumerated value in a tree handled by SimpleTreeModel */

public class EnumTreeNodeAdapter extends FieldTreeNodeAdapter {
  private long val;
  private String enumName;

  public EnumTreeNodeAdapter(String enumName, long val, FieldIdentifier id) {
    this(enumName, val, id, false);
  }

  public EnumTreeNodeAdapter(String enumName, long val, FieldIdentifier id, boolean treeTableMode) {
    super(id, treeTableMode);
    this.enumName = enumName;
    this.val = val;
  }

  public int getChildCount() {
    return 0;
  }

  public SimpleTreeNode getChild(int index) {
    return null;
  }

  public boolean isLeaf() {
    return true;
  }

  public int getIndexOfChild(SimpleTreeNode child) {
    return 0;
  }

  public String getValue() {
    if (enumName != null) {
      return enumName;
    } else {
      return Long.toString(val);
    }
  }
}