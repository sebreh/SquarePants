//
//  LazyProperty.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Sebastian Rehnby. All rights reserved.
//

import UIKit

public protocol LazyPropertyType {
  associatedtype ValueType
  
  var value: ValueType { get }
}

public struct LazyProperty<T>: LazyPropertyType {
  public typealias ValueType = T
  
  public var value: T {
    return evaluate()
  }
  
  fileprivate let evaluate: () -> T
  
  init(_ evaluate: @escaping () -> T) {
    self.evaluate = evaluate
  }
}

public extension LazyPropertyType {

  func map<U>(_ transform: @escaping (ValueType) -> U) -> LazyProperty<U> {
    return LazyProperty<U> {
      return transform(self.value)
    }
  }
  
  func flatMap<U>(_ transform: @escaping (ValueType) -> LazyProperty<U?>?) -> LazyProperty<U?> {
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
  
  func withInsets(_ insets: UIEdgeInsets) -> LazyProperty<CGRect> {
    return map { UIEdgeInsetsInsetRect($0, insets) }
  }
  
  func withInset(_ inset: CGFloat) -> LazyProperty<CGRect> {
    return map { rect in
      let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
      return UIEdgeInsetsInsetRect(rect, insets)
    }
  }
}

public extension LazyPropertyType where ValueType == CGRect? {
  
  func withInsets(_ insets: UIEdgeInsets) -> LazyProperty<CGRect?> {
    return map { rect in
      if let rect = rect {
        return UIEdgeInsetsInsetRect(rect, insets)
      } else {
        return nil
      }
    }
  }
  
  func withInset(_ inset: CGFloat) -> LazyProperty<CGRect?> {
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
