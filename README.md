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

This 'Nudity' shows float value from 0 to 100.

Step - Pass image to NudityModel's shared object

```

SFW = Safe for work
NSFW = Not Safe for work

```

```
        NudityModel.checkNudity(with: [Your-Image-Array]) { nsfwValue, sfwValue in
            
            print("nsfwValue: ", nsfwValue)
            print("nsfwValue: ", sfwValue)
         }

```



Step - Pass Local Video String Url to NudityModel's shared object


```
        NudityModel.checkLocalVideoUrlNudity(with: YourLocalVideoStringUrl, securityLevel: .low) { nsfwValue, sfwValue in
        
                print("nsfwValue: ", nsfwValue)
                print("nsfwValue: ", sfwValue)
        }

```

## SecurityLevel

Total 3 security level High, Medium & Low.

| High | Medium | Low |
| --- | --- | --- |
| Take Screenshot 1 Second. | Take Screenshot 2 Second. | Take Screenshot 4 Second. |


## License

CheckNudityPod is released under the MIT license. [See LICENSE](http://www.opensource.org/licenses/MIT) for details.
