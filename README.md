Seek
====

Seek makes it easy to animate UIView's and constraints based on percentage values.  Animations are defined with a from value and a to value and can then be animated to any position between those values by providing a float between 0 and 1.

Seek currently supports from and to values for alpha, transforms (translate, rotate, scale), and constraint constants.

### Requirements

- iOS 11.0+
- Xcode 11.0
- Swift 5.0

### Cocoapods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Seek', '4.0.0'
end
```

### How to use

To animate a view using Seek instantiate a Seek instance and provide the view and properties you want to animate.

In this example Seek will animate a view's alpha and translate, scale, and rotate the view.

```swift
let seek = Seek(
    view: myViewToAnimate,
    seekProperties: [
        .alpha(seekFloat: SeekFloat(
            fromValue: 0.5, 
            toValue: 1
        )),
        .transform(seekTransform: SeekTransform(
            fromValue: SeekTransform.getTransform(x: 0, y: 0, scaleX: 1, scaleY: 1, rotationDegrees: 0), 
            toValue: SeekTransform.getTransform(x: 100, y: 100, scaleX: 1.4, scaleY: 1.4, rotationDegrees: 30)
        ))
])
```

You can also create a Seek to animate constraints.

```swift
let seek = Seek(
    view: myViewToAnimate,
    constraint: myViewConstraintToAnimate,
    constraintLayoutView: viewToCallLayoutIfNeededOn,
    seekProperties: [
        .constraints(seekFloat: SeekFloat(
            fromValue: 0, 
            toValue: view.bounds.size.width - tealBlock.frame.size.width
        )), 
        .transform(seekTransform: SeekTransform(
            fromValue: SeekTransform.getTransform(x: 0, y: 0, scaleX: 1, scaleY: 1, rotationDegrees: 0), 
            toValue: SeekTransform.getTransform(x: 0, y: 0, scaleX: 2, scaleY: 2, rotationDegrees: 50)
        ))
])
```
