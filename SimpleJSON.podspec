#
# Be sure to run `pod lib lint SimpleJSON.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleJSON'
  s.version          = '0.1.0'
  s.summary          = 'A very easy and lightweight JSON library for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Heavily inspired by JSONHelper, I really liked their awesome library but there
were a few things that I didn't like in their implementation which inspired me
to make this library.
1. You don't always get the perfect JSON, sometimes you should gracefully fail 
   to deserialize a JSON string to a type which is why Deserializable has an
   optional initializer, you can return nil if the given dictionary does not 
   provide enough information to initialize.

2. To make it easiert to understand, think of operator --> as Swift operator 'as?'.
   Same way as ```var myNumber = someObject as? myNumber``` you can use
   ```var numbers = "[1, 2, 3, 4] as [Int].self" you just have to feed a type to
   --> operator. Left hand side can be string, data or an object and right hand
   side is a type that you want to TRY to read as. My suggestion best practice is
   to use if let and guard let. for example:
   if let numbers = "[1, 2, 3, 4] as? [Int].self { print(numbers) }"

3. Dates, URLs and other types are not supported. My philosophy is that these types
   are formatted differently API to API so I recommend casting them manually.
   I plan to include custom deserializer so you can install date deserializer based on
   your own need. This deserializer is going to be faster and easier.
                       DESC

  s.homepage         = 'https://github.com/peymanmortazavi/SimpleJSON'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Peyman Mortazavi' => 'pey.mortazavi@gmail.com' }
  s.source           = { :git => 'https://github.com/peymanmortazavi/SimpleJSON.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SimpleJSON/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SimpleJSON' => ['SimpleJSON/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
