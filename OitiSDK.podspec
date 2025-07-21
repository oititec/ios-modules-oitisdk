Pod::Spec.new do |s|
  s.name            = 'OitiSDK'
  s.version         = '0.5.0'
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
    'Frameworks/OILivenessIProov.xcframework',
    'Frameworks/OitiSDK.xcframework'
  ]

  s.dependency 'OICommons', '~> 2.1.1'
  s.dependency 'OINetwork', '~> 2.1.2'
  s.dependency 'OIComponents', '~> 2.0.0'
  s.dependency 'OISecurity', '~> 4.2'
  s.dependency 'iProov', '12.3.1'
end