//
//  LayoutAxis.swift
//  SquarePants
//
//  Created by Sebastian Rehnby on 29/09/15.
//  Copyright © 2015 Sebastian Rehnby. All rights reserved.
//

public struct LayoutAxis: OptionSet {
  public let rawValue: UInt
  public init(rawValue:UInt) { self.rawValue = rawValue }
  
  public static let Vertical = LayoutAxis(rawValue: 1)
  public static let Horizontal = LayoutAxis(rawValue: 1 << 1)
  public static let All: LayoutAxis = [.Vertical, .Horizontal]
}
