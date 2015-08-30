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
  
  var sp_frame: LazyProperty<CGRect> {
    return LazyProperty() { [weak self] in
      return self?.frame ?? CGRectZero
    }
  }
  
  var sp_bounds: LazyProperty<CGRect> {
    return LazyProperty() { [weak self] in
      return self?.bounds ?? CGRectZero
    }
  }
  
  func sp_fittedSize(maxSize  maxSize: CGSize = CGSize(width: CGFloat.max, height: CGFloat.max)) -> LazyProperty<CGSize> {
    return LazyProperty() { [weak self] in
      return self?.sizeThatFits(maxSize) ?? CGSizeZero
    }
  }
  
  func sp_makeLayout(make: (make: LayoutMaker) -> ()) -> Layoutable {
    let maker = LayoutMaker(view: self)
    make(make: maker)
    
    return maker
  }
}
