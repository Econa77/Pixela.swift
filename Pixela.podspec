Pod::Spec.new do |s|
  s.name             = "Pixela"
  s.version          = "0.0.1"
  s.summary          = "Pixela API client for Swift"
  s.homepage         = "https://github.com/Econa77/Pixela.swift"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Econa77" => "s.f.1992.ip@gmail.com" }
  s.source           = { :git => "https://github.com/Econa77/Pixela.swift.git",
                         :tag => "v#{s.version.to_s}" }
  s.source_files = "Sources/**/*.{swift,h,m}"
  s.swift_version = "5.0"
  s.dependency "APIKit", "~> 5.0"
  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.12"
end
