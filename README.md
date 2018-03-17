Seek
====

Seek makes it easy to animate UIView's and constraints based on percentage values.  Animations are defined with a from value and a to value and can then be animated to any position between those values by providing a float between 0 and 1.

Seek currently supports from and to values for alpha, transforms (translate, rotate, scale), and constraint constants.

### Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 4+

### Cocoapods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Seek', '3.0.0'
end
```

### How to use

In this example Seek will animate a view's alpha and translate the view.

```swift
let seek: Seek = Seek()

seek.view = myView
seek.duration = 0.3
seek.properties.fromAlpha = 0
seek.properties.toAlpha = 1
seek.properties.fromTransform = Seek.getTransform(x: 0, y: 0)
seek.properties.toTransform = Seek.getTransform(x: 80, y: 80)

seek.to(position: 1)
```

You can also use Seek's class methods to animate views.

```swift
Seek.view(view: myView, duration: 0.3, properties: SeekProperties(fromAlpha: 0, toAlpha: 1))

Seek.constraint(constraint: myConstraint, constraintLayoutView: layoutView, duration: 0.3, properties: SeekProperties(fromConstraintConstant: 0, toConstraintConstant: 50))
```

Use the SeekProperties class to define your from values and to values for a Seek animation.

Use the Seek class to animate your UIView's and constraints.  Seek uses UIView.animation to run the animations.
