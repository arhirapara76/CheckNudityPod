Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '13.2'
s.name = "CheckNudityiosPod"
s.summary = "CheckNudityiosPod."
s.requires_arc = true

# 2
s.version = "0.1.2"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and email address
s.author = { "Ajay" => "ajay@appringer.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/arhirapara76/CheckNudityPod"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/arhirapara76/CheckNudityPod.git", 
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.framework = "Nudity"

# 8
s.source_files = "CheckNudityPod/**/*.{swift, mlpackage}"

# 9
s.resources = "CheckNudityPod/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,mlpackage}"

# 10
s.swift_version = "5.0"

end