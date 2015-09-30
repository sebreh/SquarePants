# SquarePants

## Introduction
SquarePants is yet another library to do layout on iOS. The goal of SquarePants is to make it easy to create more complex layouts and transitions using it. It is different than most others in a few ways:

- It calculates resulting layout values lazily.
- It decouples layout from the view itself, until the moment where the layout is applied.
- It takes advantage of Swift 2 protocol extensions to provide a flexible API.

## Installation

It is recommended you use [Carthage](https://github.com/Carthage/Carthage) to install SquarePants. Simply add the following to your `Cartfile`:

```ruby
github "sebreh/SquarePants" "master"
```

## Usage

The basics of using SquarePants:

```swift
// Create a layout
let layout = view.sp_makeLayout { make in
  make.size.fitContent()
  make.y.equal(20)
  make.center.centerInSuperview(axis: .Vertical)
  make.alpha.equal(0.4)
}

// Apply the layout
layout.apply()

// Alternatively, apply the layout immediately by calling sp_layout(_)
view.sp_layout { $0.size.fitContent() }
```

## Credits

SquarePants API has been inspired by [SnapKit](https://github.com/snapkit/snapkit), a great library for working with AutoLayout.