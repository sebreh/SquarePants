//
//  ViewController.swift
//  SquarePantsDemo
//
//  Created by Sebastian Rehnby on 29/09/15.
//  Copyright © 2015 Sebastian Rehnby. All rights reserved.
//

import UIKit
import SquarePants

class ViewController: UIViewController {

  private lazy var view1: UIView = {
    let view = UIView()
    view.backgroundColor = .redColor()
    
    return view
  }()
  
  private lazy var label1: UILabel = {
    let view = UILabel()
    view.text = "This is some text"
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(view1)
    view.addSubview(label1)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    view1.sp_makeLayout { make in
      make.frame.equal(CGRectMake(0, 0, 40, 40))
      make.width.equal(60)
      make.alpha.equal(0.4)
    }.apply()
    
    label1.sp_layout { $0.size.fitContent() }
  }
}

