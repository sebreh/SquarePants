//
//  LayoutRelationship.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Sebastian Rehnby. All rights reserved.
//

import CoreGraphics

public protocol LayoutRelationshipType {
  associatedtype ValueType
  
  var setter: PropertySetter<ValueType> { get }

  func equal(_ value: ValueType) -> Self
  func equal(_ value: ValueType?) -> Self
  
  func equal(_ value: LazyProperty<ValueType>?) -> Self
  func equal(_ value: LazyProperty<ValueType?>) -> Self
  func equal(_ value: LazyProperty<ValueType?>?) -> Self
}

open class LayoutRelationship<T>: LayoutRelationshipType, Layoutable {
  public typealias ValueType = T
  
  open let setter: PropertySetter<T>
  open var lazyValue: LazyProperty<T>?
  open var optionalLazyValue: LazyProperty<T?>?
  open var condition: Bool = true
  
  public init(_ setter: PropertySetter<T>) {
    self.setter = setter
  }
  
  open func equal(_ value: ValueType) -> Self {
    self.lazyValue = LazyProperty {
      return value
    }
    
    return self
  }

  open func equal(_ value: ValueType?) -> Self {
    self.optionalLazyValue = LazyProperty {
      return value
    }
    
    return self
  }
  
  open func equal(_ value: LazyProperty<T>?) -> Self {
    self.lazyValue = value
    
    return self
  }
  
  open func equal(_ value: LazyProperty<T?>) -> Self {
    self.optionalLazyValue = value
    
    return self
  }
  
  open func equal(_ value: LazyProperty<T?>?) -> Self {
    self.optionalLazyValue = value
    
    return self
  }
  
  func when(_ condition: Bool) -> Self {
    self.condition = condition
    
    return self
  }
  
  open func apply() {
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
  
  func fitContent(_ maxSize: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> Self {
    return equal(setter.view.sp_fittedSize(maxSize: maxSize))
  }
}

public extension LayoutRelationshipType where ValueType == CGPoint {
  
  func centerInSuperview(axis: LayoutAxis = .All) -> Self {
    let center = setter.view.sp_center
    
    return equal(setter.view.sp_superview.sp_contentCenter.map { superviewCenter -> CGPoint? in
      guard let centerValue = center.value,
            let superviewCenterValue = superviewCenter else { return nil }
      
      if axis == .Vertical {
        return CGPoint(x: centerValue.x, y: superviewCenterValue.y)
      } else if axis == .Horizontal {
        return CGPoint(x: superviewCenterValue.x, y: centerValue.y)
      } else {
        return superviewCenter
      }
    })
  }
}
