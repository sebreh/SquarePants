//
//  LayoutRelationship.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import CoreGraphics

protocol Relationship {
  typealias ValueType
  
  var setter: PropertySetter<ValueType> { get }
  var lazyValue: LazyProperty<ValueType>? { get }
  var condition: Bool { get }

  func equal(value: ValueType) -> Self
  func equal(value: ValueType?) -> Self
  
  func equal(value: LazyProperty<ValueType>?) -> Self
  func equal(value: LazyProperty<ValueType?>) -> Self
  func equal(value: LazyProperty<ValueType?>?) -> Self
}

class LayoutRelationship<T>: Relationship, Layoutable {
  typealias ValueType = T
  
  let setter: PropertySetter<T>
  var lazyValue: LazyProperty<T>?
  var optionalLazyValue: LazyProperty<T?>?
  var condition: Bool = true
  
  init(setter: PropertySetter<T>) {
    self.setter = setter
  }
  
  func equal(value: ValueType) -> Self {
    self.lazyValue = LazyProperty {
      return value
    }
    
    return self
  }

  func equal(value: ValueType?) -> Self {
    self.optionalLazyValue = LazyProperty {
      return value
    }
    
    return self
  }
  
  func equal(value: LazyProperty<T>?) -> Self {
    self.lazyValue = value
    
    return self
  }
  
  func equal(value: LazyProperty<T?>) -> Self {
    self.optionalLazyValue = value
    
    return self
  }
  
  func equal(value: LazyProperty<T?>?) -> Self {
    self.optionalLazyValue = value
    
    return self
  }
  
  func when(condition: Bool) -> Self {
    self.condition = condition
    
    return self
  }
  
  func apply() {
    guard condition else { return }
    
    if let lazyValue = lazyValue {
      setter.set(lazyValue.value)
    } else if let optionalLazyValue = optionalLazyValue, let value = optionalLazyValue.value {
      setter.set(value)
    }
  }
}

// MARK: Extensions

extension Relationship where ValueType == CGSize {
  
  func fitContent(maxSize: CGSize = CGSize(width: CGFloat.max, height: CGFloat.max)) -> Self {
    return equal(setter.view.sp_fittedSize(maxSize: maxSize))
  }
}
