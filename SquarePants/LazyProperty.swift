//
//  LazyProperty.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import UIKit

protocol LazyValue {
  typealias ValueType
  
  var value: ValueType { get }
}

struct LazyProperty<T>: LazyValue {
  typealias ValueType = T
  
  var value: T {
    return evaluate()
  }
  
  private let evaluate: () -> T
  
  init(_ evaluate: () -> T) {
    self.evaluate = evaluate
  }
}

// MARK: Extensions

extension LazyValue where ValueType == UIView? {
  
  var superview: LazyProperty<UIView?> {
    return LazyProperty() {
      return self.value?.superview
    }
  }
  
  var frame: LazyProperty<CGRect> {
    return LazyProperty() {
      return self.value?.frame ?? CGRectZero
    }
  }
  
  var center: LazyProperty<CGPoint> {
    return LazyProperty() {
      return self.value?.center ?? CGPointZero
    }
  }
}

extension LazyValue where ValueType == CGRect {
  
  func withInsets(insets: UIEdgeInsets) -> LazyProperty<CGRect> {
    return LazyProperty() {
      return UIEdgeInsetsInsetRect(self.value, insets)
    }
  }
  
  func withInset(inset: CGFloat) -> LazyProperty<CGRect> {
    return LazyProperty() {
      let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
      return UIEdgeInsetsInsetRect(self.value, insets)
    }
  }
}