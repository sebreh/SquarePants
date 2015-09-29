//
//  LayoutRelationship.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import CoreGraphics

public protocol LayoutRelationshipType {
  typealias ValueType
  
  var setter: PropertySetter<ValueType> { get }

  func equal(value: ValueType) -> Self
  func equal(value: ValueType?) -> Self
  
  func equal(value: LazyProperty<ValueType>?) -> Self
  func equal(value: LazyProperty<ValueType?>) -> Self
  func equal(value: LazyProperty<ValueType?>?) -> Self
}

public class LayoutRelationship<T>: LayoutRelationshipType, Layoutable {
  public typealias ValueType = T
  
  public let setter: PropertySetter<T>
  public var lazyValue: LazyProperty<T>?
  public var optionalLazyValue: LazyProperty<T?>?
  public var condition: Bool = true
  
  public init(_ setter: PropertySetter<T>) {
    self.setter = setter
  }
  
  public func equal(value: ValueType) -> Self {
    self.lazyValue = LazyProperty {
      return value
    }
    
    return self
  }

  public func equal(value: ValueType?) -> Self {
    self.optionalLazyValue = LazyProperty {
      return value
    }
    
    return self
  }
  
  public func equal(value: LazyProperty<T>?) -> Self {
    self.lazyValue = value
    
    return self
  }
  
  public func equal(value: LazyProperty<T?>) -> Self {
    self.optionalLazyValue = value
    
    return self
  }
  
  public func equal(value: LazyProperty<T?>?) -> Self {
    self.optionalLazyValue = value
    
    return self
  }
  
  func when(condition: Bool) -> Self {
    self.condition = condition
    
    return self
  }
  
  public func apply() {
    guard condition else { return }
    
    if let lazyValue = lazyValue {
      setter.set(lazyValue.value)
    } else if let optionalLazyValue = optionalLazyValue, let value = optionalLazyValue.value {
      setter.set(value)
    }
  }
}

// MARK: Extensions

public extension LayoutRelationshipType where ValueType == CGSize {
  
  func fitContent(maxSize: CGSize = CGSize(width: CGFloat.max, height: CGFloat.max)) -> Self {
    return equal(setter.view.sp_fittedSize(maxSize: maxSize))
  }
}

public extension LayoutRelationshipType where ValueType == CGPoint {
  
  func centerInSuperview() -> Self {
    return equal(setter.view.sp_superview.sp_contentCenter)
  }
}
