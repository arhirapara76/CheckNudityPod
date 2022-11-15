Pod::Spec.new do |s|
    s.name             = "CheckNudityiosPod"
    s.version          = "0.1.18"
    s.summary          = 'Check image nudity'
    s.license          = 'MIT'
    s.author           = {'Ajay' => 'ajay@appringer.com'}

    s.source           = { :git => 'https://github.com/arhirapara76/CheckNudityPod.git', :tag => "#{s.version}" }

s.homepage = "https://github.com/arhirapara76/CheckNudityPod"

    s.ios.deployment_target = '13.2'
    s.requires_arc = true

    s.source_files = 'CheckNudityPod', 'CheckNudityPod/**/*.{swift,mlmodel,AVFoundation,MobileCoreServices}'

    s.frameworks = 'UIKit', 'Foundation','Vision','CoreML'
    s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
end