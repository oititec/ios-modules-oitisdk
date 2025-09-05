Pod::Spec.new do |s|
  s.name            = 'OitiSDK'
  s.version         = '0.7.1'
  s.summary         = 'Framework OitiSDK para iOS.'
  s.homepage        = 'https://www.oititec.com.br/'
  s.license         = { :type => 'Copyright', :text => 'Copyright © 2025 Oiti. All rights reserved.' }
  s.author          = 'Oititec'
  s.platform        = :ios, '13.0'
  s.swift_version   = '5.0'
  s.source          = { 
    :git => 'https://github.com/oititec/ios-modules-oitisdk.git', 
    :tag => s.version.to_s 
  }
  s.vendored_frameworks = [
    'Frameworks/OitiComponents.xcframework',
    'Frameworks/OitiUtils.xcframework',
    'Frameworks/OitiNetwork.xcframework',
    'Frameworks/OitiSecurity.xcframework',
    'Frameworks/OitiLivenessIProov.xcframework',
    'Frameworks/OitiLivenessFacetec.xcframework',
    'Frameworks/OitiSDK.xcframework'
  ]

  s.dependency 'iProov', '12.3.1'
  s.dependency 'OILiveness3D_FT', '9.7.79'
end