# CheckNudityPod

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 13.2+ / macOS 10.13+ / tvOS 11.0+ / watchOS 4.0+ | 5.0 | [CocoaPods](#cocoapods) | Fully Tested |

#### Known Issues on Linux and Windows

Alamofire builds on Linux and Windows but there are missing features and many issues in the underlying `swift-corelibs-foundation` that prevent full functionality and may cause crashes. These include:
- `ServerTrustManager` and associated certificate functionality is unavailable, so there is no certificate pinning and no client certificate support.
- Various methods of HTTP authentication may crash, including HTTP Basic and HTTP Digest. Crashes may occur if responses contain server challenges.
- Cache control through `CachedResponseHandler` and associated APIs is unavailable, as the underlying delegate methods aren't called.
- `URLSessionTaskMetrics` are never gathered.

Due to these issues, Alamofire is unsupported on Linux and Windows. Please report any crashes to the [Swift bug reporter](https://bugs.swift.org).

## Migration Guides

- [Alamofire 5.0 Migration Guide](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%205.0%20Migration%20Guide.md)
- [Alamofire 4.0 Migration Guide](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%204.0%20Migration%20Guide.md)
- [Alamofire 3.0 Migration Guide](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%203.0%20Migration%20Guide.md)
- [Alamofire 2.0 Migration Guide](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%202.0%20Migration%20Guide.md)

## Communication
- If you **need help with making network requests** using Alamofire, use [Stack Overflow](https://stackoverflow.com/questions/tagged/alamofire) and tag `alamofire`.
- If you need to **find or understand an API**, check [our documentation](http://alamofire.github.io/Alamofire/) or [Apple's documentation for `URLSession`](https://developer.apple.com/documentation/foundation/url_loading_system), on top of which Alamofire is built.
- If you need **help with an Alamofire feature**, use [our forum on swift.org](https://forums.swift.org/c/related-projects/alamofire).
- If you'd like to **discuss Alamofire best practices**, use [our forum on swift.org](https://forums.swift.org/c/related-projects/alamofire).
- If you'd like to **discuss a feature request**, use [our forum on swift.org](https://forums.swift.org/c/related-projects/alamofire). 
- If you **found a bug**, open an issue here on GitHub and follow the guide. The more detail the better!

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CheckNudityPod into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'CheckNudityPod'
```

## License

CheckNudityPod is released under the MIT license. [See LICENSE](http://www.opensource.org/licenses/MIT) for details.
