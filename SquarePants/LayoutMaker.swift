//
//  LayoutMaker.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import UIKit

class LayoutMaker: Layoutable {
  
  weak var view: UIView!
  
  private var layoutables = [Layoutable]()
  
  init(view: UIView) {
    self.view = view
  }
  
  private func addRelationshipWithSetter<T>(setter: PropertySetter<T>) -> LayoutRelationship<T> {
    let relationship = LayoutRelationship(setter: setter)
    layoutables.append(relationship)
    
    return relationship
  }
  
  func apply() {
    for layoutable in layoutables {
      layoutable.apply()
    }
  }
}

// MARK: Extensions

extension LayoutMaker {
  
  var center: LayoutRelationship<CGPoint> {
    return addRelationshipWithSetter(PropertySetter(view) { view, center in
      view.center = center
      })
  }
  
  var size: LayoutRelationship<CGSize> {
    return addRelationshipWithSetter(PropertySetter(view) { view, size in
      var frame = view.frame
      frame.size = size
      view.frame = frame
      })
  }
  
  var frame: LayoutRelationship<CGRect> {
    return addRelationshipWithSetter(PropertySetter(view) { (view: UIView, frame: CGRect) in
      view.frame = frame
      })
  }
  
  var alpha: LayoutRelationship<CGFloat> {
    return addRelationshipWithSetter(PropertySetter(view) { (view: UIView, alpha: CGFloat) in
      view.alpha = alpha
      })
  }
}
