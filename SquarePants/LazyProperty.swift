//
//  LazyProperty.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import UIKit

public protocol LazyPropertyType {
  typealias ValueType
  
  var value: ValueType { get }
}

public struct LazyProperty<T>: LazyPropertyType {
  public typealias ValueType = T
  
  public var value: T {
    return evaluate()
  }
  
  private let evaluate: () -> T
  
  init(_ evaluate: () -> T) {
    self.evaluate = evaluate
  }
}

public extension LazyPropertyType {

  func map<U>(transform: ValueType -> U) -> LazyProperty<U> {
    return LazyProperty<U> {
      return transform(self.value)
    }
  }
  
  func flatMap<U>(transform: ValueType -> LazyProperty<U?>?) -> LazyProperty<U?> {
    return LazyProperty<U?> {
      return transform(self.value)?.value
    }
  }
}

// MARK: Extensions

public extension LazyPropertyType where ValueType == UIView? {
  
  var superview: LazyProperty<UIView?> {
    return map { $0?.superview }
  }
  
  var frame: LazyProperty<CGRect?> {
    return map { $0?.frame }
  }
  
  var center: LazyProperty<CGPoint?> {
    return map { $0?.center }
  }
  
  var sp_contentCenter: LazyProperty<CGPoint?> {
    return flatMap { $0?.sp_contentCenter }
  }
  
  var alpha: LazyProperty<CGFloat?> {
    return map { $0?.alpha }
  }
  
  var transform: LazyProperty<CGAffineTransform?> {
    return map { $0?.transform }
  }
}

public extension LazyPropertyType where ValueType == CGRect {
  
  func withInsets(insets: UIEdgeInsets) -> LazyProperty<CGRect> {
    return map { UIEdgeInsetsInsetRect($0, insets) }
  }
  
  func withInset(inset: CGFloat) -> LazyProperty<CGRect> {
    return map { rect in
      let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
      return UIEdgeInsetsInsetRect(rect, insets)
    }
  }
}

public extension LazyPropertyType where ValueType == CGRect? {
  
  func withInsets(insets: UIEdgeInsets) -> LazyProperty<CGRect?> {
    return map { rect in
      if let rect = rect {
        return UIEdgeInsetsInsetRect(rect, insets)
      } else {
        return nil
      }
    }
  }
  
  func withInset(inset: CGFloat) -> LazyProperty<CGRect?> {
    return map { rect in
      if let rect = rect {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return UIEdgeInsetsInsetRect(rect, insets)
      } else {
        return nil
      }
    }
  }
}