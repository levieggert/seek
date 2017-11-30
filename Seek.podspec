Pod::Spec.new do |s|

  s.platform     = :ios, "8.0"

  s.name         = "Seek"
  s.version      = "2.0.1"
  s.license      = "MIT"

  s.homepage     = "https://github.com/levieggert/Seek"
  s.author       = { "levieggert" => "levi.eggert@gmail.com" }
  s.summary      = "A simple UIView animation framework."
  s.description  = "This framework makes it easy to animate UIView's based on percentage values.  For example, an animation is defined with a beginning and end values and then can be animated anywhere between those values by passing a float between 0 and 1."

  s.source       = { :git => "https://github.com/levieggert/Seek.git", :tag => "#{s.version}" }

  s.source_files = 'Source/*.swift'
end
