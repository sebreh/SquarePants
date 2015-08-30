//
//  UIViewExtensions.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import UIKit

extension UIView {
  
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
        return CGRectGetWidth(bounds)
      } else {
        return nil
      }
    }
  }
  
  var sp_height: LazyProperty<CGFloat?> {
    return LazyProperty() { [weak self] in
      if let bounds = self?.bounds {
        return CGRectGetHeight(bounds)
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
  
  var sp_transform: LazyProperty<CGAffineTransform?> {
    return LazyProperty() { [weak self] in
      return self?.transform
    }
  }
  
  func sp_fittedSize(maxSize  maxSize: CGSize = CGSize(width: CGFloat.max, height: CGFloat.max)) -> LazyProperty<CGSize?> {
    return LazyProperty() { [weak self] in
      return self?.sizeThatFits(maxSize)
    }
  }
  
  func sp_makeLayout(make: (make: LayoutMaker) -> ()) -> Layoutable {
    let maker = LayoutMaker(view: self)
    make(make: maker)
    
    return maker
  }
}
