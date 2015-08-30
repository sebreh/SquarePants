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
  
  func equal(reader: LazyProperty<ValueType>?) -> Self
}

class LayoutRelationship<T>: Relationship, Layoutable {
  typealias ValueType = T
  
  let setter: PropertySetter<T>
  var lazyValue: LazyProperty<T>?
  var condition: Bool = true
  
  init(setter: PropertySetter<T>) {
    self.setter = setter
  }
  
  func equal(reader: LazyProperty<T>?) -> Self {
    self.lazyValue = reader
    
    return self
  }
  
  func when(condition: Bool) -> Self {
    self.condition = condition
    
    return self
  }
  
  func apply() {
    if let value = lazyValue where condition == true {
      setter.set(value.value)
    }
  }
}

// MARK: Extensions

extension Relationship where ValueType == CGSize {
  
  func fitContent(maxSize: CGSize = CGSize(width: CGFloat.max, height: CGFloat.max)) -> Self {
    return equal(setter.view.sp_fittedSize(maxSize: maxSize))
  }
}
