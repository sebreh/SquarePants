//
//  UIViewExtensions.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Sebastian Rehnby. All rights reserved.
//

import UIKit

public extension UIView {
  
  var sp_superview: LazyProperty<UIView?> {
    return LazyProperty() { [weak self] in
      return self?.superview
    }
  }
  
  var sp_frame: LazyProperty<CGRect?> {
    return LazyProperty() { [weak self] in
      return self?.frame
    }
  }
  
  var sp_width: LazyProperty<CGFloat?> {
    return LazyProperty() { [weak self] in
      if let bounds = self?.bounds {
        return bounds.width
      } else {
        return nil
      }
    }
  }
  
  var sp_height: LazyProperty<CGFloat?> {
    return LazyProperty() { [weak self] in
      if let bounds = self?.bounds {
        return bounds.height
      } else {
        return nil
      }
    }
  }
  
  var sp_bounds: LazyProperty<CGRect?> {
    return LazyProperty() { [weak self] in
      return self?.bounds
    }
  }
  
  var sp_center: LazyProperty<CGPoint?> {
    return LazyProperty() { [weak self] in
      return self?.center
    }
  }
  
  var sp_contentCenter: LazyProperty<CGPoint?> {
    return sp_bounds.map { bounds in
      if let bounds = bounds {
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
      } else {
        return nil
      }
    }
  }
  
  var sp_transform: LazyProperty<CGAffineTransform?> {
    return LazyProperty() { [weak self] in
      return self?.transform
    }
  }
  
  func sp_fittedSize(maxSize: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> LazyProperty<CGSize?> {
    return LazyProperty() { [weak self] in
      return self?.sizeThatFits(maxSize)
    }
  }
  
  func sp_makeLayout(_ make: (_ make: LayoutMaker) -> ()) -> Layoutable {
    let maker = LayoutMaker(view: self)
    make(maker)
    
    return maker
  }
  
  func sp_layout(_ make: (_ make: LayoutMaker) -> ()) {
    let maker = LayoutMaker(view: self)
    make(maker)
    
    maker.apply()
  }
}


public extension UIView {
  
  var sp_centerSetter: PropertySetter<CGPoint> {
    return PropertySetter(self) { view, center in
      view.center = center
    }
  }
  
  var sp_sizeSetter: PropertySetter<CGSize> {
    return PropertySetter(self) { view, size in
      var frame = view.frame
      frame.size = size
      view.frame = frame
    }
  }
  
  var sp_frameSetter: PropertySetter<CGRect> {
    return PropertySetter(self) { view, frame in
      view.frame = frame
    }
  }
  
  var sp_xSetter: PropertySetter<CGFloat> {
    return PropertySetter(self) { view, x in
      var frame = view.frame
      frame.origin.x = x
      view.frame = frame
    }
  }
  
  var sp_ySetter: PropertySetter<CGFloat> {
    return PropertySetter(self) { view, y in
      var frame = view.frame
      frame.origin.y = y
      view.frame = frame
    }
  }
  
  var sp_widthSetter: PropertySetter<CGFloat> {
    return PropertySetter(self) { view, width in
      var frame = view.frame
      frame.size.width = width
      view.frame = frame
    }
  }
  
  var sp_heightSetter: PropertySetter<CGFloat> {
    return PropertySetter(self) { view, height in
      var frame = view.frame
      frame.size.height = height
      view.frame = frame
    }
  }
  
  var sp_alphaSetter: PropertySetter<CGFloat> {
    return PropertySetter(self) { view, alpha in
      view.alpha = alpha
    }
  }
}
