//
//  SquarePantsTests.swift
//  SquarePantsTests
//
//  Created by Sebastian Rehnby on 19/08/15.
//  Copyright © 2015 Peakon. All rights reserved.
//

import XCTest

class SquarePantsTests: XCTestCase {
  
  func testExample() {
    let container = UIView()
    container.frame = CGRectMake(0, 0, 100, 100)
    
    let view = UIView()
    view.frame = CGRectMake(0, 0, 40, 40)
    container.addSubview(view)
    
    let frame = view.sp_superview.frame.withInset(10)
    print("Frame: \(frame.value)")
    
    let label = UILabel()
    label.text = "This is some text"
    
    label.sp_makeLayout { make in
      make.size.fitContent().when(true)
      make.center.equal(view.sp_superview.center)
    }.apply()
    
    view.sp_makeLayout { make in
      make.frame.equal(view.sp_superview.frame.withInset(10))
      make.size.fitContent()
    }.apply()
  }
}
