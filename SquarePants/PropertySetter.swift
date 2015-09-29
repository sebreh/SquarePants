//
//  PropertySetter.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 28/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import UIKit

public struct PropertySetter<T> {
  
  weak var view: UIView!
  var setBlock: (UIView, T) -> ()
  
  func set(value: T) {
    setBlock(view, value)
  }
  
  init(_ view: UIView, setBlock: (UIView, T) -> ()) {
    self.view = view
    self.setBlock = setBlock
  }
}