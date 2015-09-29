//
//  LayoutMaker.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Sebastian Rehnby. All rights reserved.
//

import UIKit

public class LayoutMaker: Layoutable {
  
  weak var view: UIView!
  
  private var layoutables = [Layoutable]()
  
  init(view: UIView) {
    self.view = view
  }
  
  func addRelationshipWithSetter<T>(setter: PropertySetter<T>) -> LayoutRelationship<T> {
    let relationship = LayoutRelationship(setter)
    layoutables.append(relationship)
    
    return relationship
  }
  
  public func apply() {
    for layoutable in layoutables {
      layoutable.apply()
    }
  }
}

// MARK: Extensions

public extension LayoutMaker {
  
  var center: LayoutRelationship<CGPoint> {
    return addRelationshipWithSetter(view.sp_centerSetter)
  }
  
  var size: LayoutRelationship<CGSize> {
    return addRelationshipWithSetter(view.sp_sizeSetter)
  }
  
  var frame: LayoutRelationship<CGRect> {
    return addRelationshipWithSetter(view.sp_frameSetter)
  }

  var x: LayoutRelationship<CGFloat> {
    return addRelationshipWithSetter(view.sp_xSetter)
  }
  
  var y: LayoutRelationship<CGFloat> {
    return addRelationshipWithSetter(view.sp_ySetter)
  }
  
  var width: LayoutRelationship<CGFloat> {
    return addRelationshipWithSetter(view.sp_widthSetter)
  }
  
  var height: LayoutRelationship<CGFloat> {
    return addRelationshipWithSetter(view.sp_heightSetter)
  }
  
  var alpha: LayoutRelationship<CGFloat> {
    return addRelationshipWithSetter(view.sp_alphaSetter)
  }
}
