Seek
====

Seek is a small animation class that animates UIViews across a timeline.  Animations are defined with start and end values and can be animated anywhere between these values.

Seek supports the follow start and end values.  Alpha, Transforms (scaling, translating, rotating) and constraint constants. 


##### UIView Animation

An example of animating a UIView's alpha and translating it's frame would look like this.

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


