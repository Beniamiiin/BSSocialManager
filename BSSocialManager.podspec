Pod::Spec.new do |s|
  s.name 			= 'BSSocialManager'
  s.version 		= '0.0.1'
  s.platform	    = :ios, '7.0'
  s.source_files 	= 'BSSocialManager/**/*.{h,m}'
  s.requires_arc 	= true

  s.dependency 		'FBSDKCoreKit'
  s.dependency 		'FBSDKLoginKit'
  s.dependency 		'VK-ios-sdk'
  s.dependency		'FHSTwitterEngine'
end