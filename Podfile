platform :ios, '13.0'
inhibit_all_warnings!

target 'Svati' do
	use_frameworks!

  pod 'BonMot'
  pod 'R.swift'
  pod 'DynamicColor'
  pod 'TinyConstraints'
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'XLPagerTabStrip'
  pod 'Tabman', '~> 2.9'
end

post_install do |installer|
 # add these lines:
 installer.pods_project.build_configurations.each do |config|
  config.build_settings["EXCLUDED_ARCHS[sdk=*]"] = "armv7"
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
 end
  
 installer.pods_project.targets.each do |target|
   
  # add these lines:
  target.build_configurations.each do |config|
   if Gem::Version.new($iOSVersion) > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
   end
  end
   
 end
end
