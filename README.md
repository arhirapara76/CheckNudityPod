# CheckNudityPod

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 13.2+ / macOS 10.13+ / tvOS 11.0+ / watchOS 4.0+ | 5.0 | [CocoaPods](#cocoapods) | Fully Tested |

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CheckNudityPod into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'CheckNudityPod'
```

```

SFW = Safe for work
NSFW = Not Safe for work

```

## Usage

Step - Pass image to MFNudity's shared object


```
        NudityModel.checkNudity(with: [Your image array]) { nsfwValue, sfwValue in
            
            print("nsfwValue: ", nsfwValue)
            print("nsfwValue: ", sfwValue)
     }

```

This 'confidence' shows float value from 0 to 100 . You can simply convert it into % and show image's not nudity in percentage . For higher 'confidence' value it will be not nude picture.

## License

CheckNudityPod is released under the MIT license. [See LICENSE](http://www.opensource.org/licenses/MIT) for details.
