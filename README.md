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

## Usage

This 'confidence' shows float value from 0 to 100.

Step - Pass image to MFNudity's shared object

```

SFW = Safe for work
NSFW = Not Safe for work

```

```
        NudityModel.checkNudity(with: [Your image array]) { nsfwValue, sfwValue in
            
            print("nsfwValue: ", nsfwValue)
            print("nsfwValue: ", sfwValue)
         }

```


Step - Pass local video url to MFNudity's shared object


```
        NudityModel.checkLocalVideoUrlNudity(with: yourlocalVideoStringUrl, securityLevel: .low) { nsfwValue, sfwValue in
        
                print("nsfwValue: ", nsfwValue)
                print("nsfwValue: ", sfwValue)
        }

```

## SecurityLevel

Total 3 security level High, Medium & Low.

| High | Medium | Low |
| --- | --- | --- |
| Take screenshot 1 Second. | Take screenshot 2 Second. | Take screenshot 4 Second. |

## License

CheckNudityPod is released under the MIT license. [See LICENSE](http://www.opensource.org/licenses/MIT) for details.
