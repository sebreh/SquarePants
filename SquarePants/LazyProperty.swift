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
  
  var frame: LazyProperty<CGRect?> {
    return LazyProperty() {
      return self.value?.frame
    }
  }
  
  var center: LazyProperty<CGPoint?> {
    return LazyProperty() {
      return self.value?.center
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

extension LazyValue where ValueType == CGRect? {
  
  func withInsets(insets: UIEdgeInsets) -> LazyProperty<CGRect?> {
    return LazyProperty() {
      if let rect = self.value {
        return UIEdgeInsetsInsetRect(rect, insets)
      } else {
        return nil
      }
    }
  }
  
  func withInset(inset: CGFloat) -> LazyProperty<CGRect?> {
    return LazyProperty() {
      if let rect = self.value {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return UIEdgeInsetsInsetRect(rect, insets)
      } else {
        return nil
      }
    }
  }
}